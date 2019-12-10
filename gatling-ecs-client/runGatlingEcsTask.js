const fs = require('fs');
const https = require('https');

const awsGatling = require("./awsGatling")

const moment = require('moment-timezone');

if (process.argv.length < 3) {
  console.log("usage: " + process.argv[0] + " " + process.argv[1] + " [JSON file]");
  process.exit(1)
}

const jsonFile = "./" + process.argv[2]; // "./"から始める必要あり
try {
  fs.statSync(jsonFile)
} catch (error) {
  console.log(jsonFile + ': file not exists');
  process.exit(1)
}

function main() {
  const params = require(jsonFile);
  const s3LogPrefix = params.s3LogPrefix || "";
  const clusterName = params.clusterName || "default";

  const now = moment.tz("Asia/Tokyo");
  const executionId = s3LogPrefix + now.format("YYYYMMDDHHmmss") + "-" + now.format("x");

  const awsVpc = {
    subnets: [params.awsSubnet],
    securityGroups: [params.awsSecurityGroup || ""].filter(a => a), //
    assignPublicIp: "ENABLED"
  };

  const taskDefsPromise = getTaskDefs(params.taskDefs);
  const taskProps = {
    runner: makeProps(executionId, params.tasks.runner),
    reporter: makeProps(executionId, params.tasks.reporter)
  };

  taskDefsPromise.then((taskDefs) => {
    return {
      runner: taskParam(taskDefs.runner, taskProps.runner, awsVpc, "gatling-runner"),
      reporter: taskDefs.reporter && taskParam(taskDefs.reporter, taskProps.reporter, awsVpc, "gatling-s3-reporter")
    };
  }).then((taskParams) => {
    return runEcsTask(clusterName, taskParams.runner, "runner").then(() => {
      if (taskParams.reporter) {
        return runEcsTask(clusterName, taskParams.reporter, "reporter").then(() => {
          return {reporter: true}
        })
      }
      return Promise.resolve({})
    })
  }).then((result) => {
    if (result.reporter && params.reportParams && params.reportParams.hostUrl) {
      result.reportUrl = params.reportParams.hostUrl + executionId + "/index.html";
      console.log(result.reportUrl);
    }
    if (result && result.reportUrl && params.chatworkNotificationParams) {
      return notification(result, params.chatworkNotificationParams)
    }
    return Promise.resolve(result)
  })
}

function getTaskDefs(taskDefsParam) {
  const taskDefParams = Object.assign({runner: null, reporter: null}, taskDefsParam);
  const runnerTaskDef = getTaskDef(taskDefParams.runner);
  const reporterTaskDef = getTaskDef(taskDefParams.reporter);

  return Promise.all([runnerTaskDef, reporterTaskDef]).then(values => {
    return {
      runner: values[0],
      reporter: values[1]
    }
  });

  function getTaskDef(taskDefParam) {
    if (!taskDefParam) {
      return Promise.resolve(null)
    }
    const defParam = Object.assign({stackName: null, taskName: null}, taskDefParam);
    if (!defParam.stackName || !defParam.taskName) {
      return Promise.resolve(null)
    }

    return awsGatling.getTaskDefinition(defParam.stackName, defParam.taskName);
  }
}

function notification(result, notificationParams) {
  const reportUrl = result.reportUrl || "";
  if (notificationParams && process.env.CHATWORK_API_TOKEN) {
    const options = {
      hostname: "api.chatwork.com",
      port: 443,
      path: '/v2/rooms/' + notificationParams.roomId + '/messages',
      method: 'POST',
      headers:{
        "X-ChatWorkToken": process.env.CHATWORK_API_TOKEN,
        'Content-Type': 'application/x-www-form-urlencoded'
      }
    };

    return new Promise((resolve, reject) => {
      let req = https.request(options, (res) => {
        if (res.statusCode === 200) {
          console.log("send message to chatwork")
        } else {
          console.log("failure message to chatwork " + res.statusCode)
        }
        resolve(result)
      });

      req.write('body=' + notificationParams.message + " " + reportUrl + "&self_unread=1");
      req.end()
    })
  }

  return Promise.resolve(result)
}

function runEcsTask(clusterName, taskParam, taskName) {
  return awsGatling.runEcsTask(clusterName, taskParam, true).then(() => {
    console.log("gatling " + taskName + " finished");
    return true;
  })
}

function makeProps(executionId, props) {
  props = Object.assign({
    count: 0,
    environment: {},
    executionIdEnvName: null
  }, props);

  let envs = props.environment || {};
  if (props.executionIdEnvName) {
    envs[props.executionIdEnvName] = executionId
  }
  return {
    count: props.count || 1,
    envs: Object.keys(envs).map((key) => {
      return {
        name: key,
        value: envs[key]
      };
    })
  }
}

function taskParam(taskDefinition, props, awsVpc, containerName) {
 return {
  taskDefinition: taskDefinition,
  count: props.count,
  launchType: "FARGATE",
  networkConfiguration: {
   awsvpcConfiguration: awsVpc
  },
  overrides: {
    containerOverrides: [
      {
        environment: props.envs,
        name: containerName
      }
    ]
  }
};
}

main();

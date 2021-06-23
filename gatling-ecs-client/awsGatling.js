const util = require('util');

const { ECSClient, RunTaskCommand, DescribeTasksCommand} = require('@aws-sdk/client-ecs');
const { CloudFormationClient, DescribeStacksCommand} = require('@aws-sdk/client-cloudformation');

const ecs = new ECSClient({region: 'ap-northeast-1'});
const cloudformation = new CloudFormationClient({region: 'ap-northeast-1'});

function getTaskDefinition(stackName, taskName) {
    return describeStack(stackName).then((data) => {
        return data.Stacks[0].Outputs.filter(output => output.OutputKey === taskName)[0].OutputValue;
    }).catch(error => console.error(error));
}

function describeStack(stackName) {
    const command = new DescribeStacksCommand({StackName: stackName});
    return cloudformation.send(command).then((data) => {
        if (!data.Stacks || data.Stacks.length !== 1) {
            return Promise.reject("no stacks");
        } else {
            return Promise.resolve(data)
        }
    })
}

/**
 *
 * @param clusterName
 * @param taskParams
 * @param waitingFinish
 * @returns {Promise<unknown>}
 */
function runEcsTask(clusterName, taskParams, waitingFinish = false) {
    // override
    taskParams.cluster = clusterName;

    console.log("ecs task parameters: ");
    console.log(util.inspect(taskParams, {depth: 6}));

    const command = new RunTaskCommand(taskParams)

    return ecs.send(command)
        .then((result) => {
            console.log("result: ");
            console.log(result);
            return result.tasks
        })
        .then((tasks) => {
            if (waitingFinish) {
                return waitingTasksFinished(clusterName, tasks)
            } else {
                return Promise.resolve({})
            }
        });
}

function waitingTasksFinished(clusterName, tasks) {
    let params = {
        cluster: clusterName,
        tasks: tasks.map(t => t.taskArn)
    };
    return checkTasks(params)
}

function checkTasks(describeTasksParams, previousStatusSet = {}) {
    return describeEcsTasks(describeTasksParams).then((statusSet) => {
        if (Object.keys(statusSet).length === 0) {
            // 無限ループ防止
            console.log("No tasks found");
            return Promise.reject({})
        } else {
            // 厳密にはソートとかしないと差が出る可能性もあるが、ログ出すだけなので気にしすぎない
            if (JSON.stringify(previousStatusSet) !== JSON.stringify(statusSet)) {
                console.log("task status changed: ");
                console.log(statusSet);
            }
            if (describeTasksParams.tasks.length === statusSet["STOPPED"]) {
                // 全て終了
                console.log("tasks are finished");
                return Promise.resolve(statusSet);
            }

            return new Promise(resolve => {
                setTimeout(() => {
                    resolve(1)
                }, 15000); // 15秒ごとにチェック
            }).then(() => {
                return checkTasks(describeTasksParams, statusSet)
            });
        }
    })
}

function describeEcsTasks(describeTasksParams) {
    const command = new DescribeTasksCommand(describeTasksParams);

    return ecs.send(command)
        .then((data) => {
            let statusSet = data.tasks.reduce((result, current) => {
                let status = current.lastStatus;
                result[status] = result[status] || 0;
                result[status]++;
                return result
            }, {});

            return statusSet;
        }, (err) => {
            console.log(err, err.stack); // an error occurred
            return ""
        })
}

exports.getTaskDefinition = getTaskDefinition;
exports.runEcsTask = runEcsTask;

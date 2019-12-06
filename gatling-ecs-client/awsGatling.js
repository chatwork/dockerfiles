const util = require('util');

const AWS = require('aws-sdk');

AWS.config.update({region: 'ap-northeast-1'});

const ecs = new AWS.ECS();
const cloudformation = new AWS.CloudFormation();

function getTaskDefinition(stackName, taskName) {
    return describeStack(stackName).then((data) => {
        return data.Stacks[0].Outputs.filter(output => output.OutputKey === taskName)[0].OutputValue;
    }).catch(error => console.error(error));
}

function describeStack(stackName) {
    return new Promise((resolve, reject) => {
        cloudformation.describeStacks({StackName: stackName}, (err, data) => {
            if (err) {
                reject(err);
                return;
            }
            if (!data.Stacks || data.Stacks.length !== 1) {
                reject("no stacks");
                return;
            }
            resolve(data);
        })
    });
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

    return new Promise((resolve, reject) => {
        ecs.runTask(taskParams, (err, result) => {
            if (err) {
                reject(err);
                return;
            }
            console.log("result: ");
            console.log(result);
            resolve(result.tasks)
        });
    }).then((tasks) => {
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
    return new Promise((resolve, reject) => {
        ecs.describeTasks(describeTasksParams, function(err, data) {
            if (err) {
                console.log(err, err.stack); // an error occurred
                reject("")
            } else {
                let statusSet = data.tasks.reduce((result, current) => {
                    let status = current.lastStatus;
                    result[status] = result[status] || 0;
                    result[status]++;
                    return result
                }, {});

                resolve(statusSet);
            }
        });
    })
}

exports.getTaskDefinition = getTaskDefinition;
exports.runEcsTask = runEcsTask;

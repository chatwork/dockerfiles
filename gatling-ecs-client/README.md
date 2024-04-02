# Gatling ECS client

One-stop Tool for running Gatling simulations and generating report on AWS ECS and S3.

## Requirements

### Docker Image

To run Gatling scenario, docker image must be pushed to Docker registry(DockerHub or ECR).

Docker Cmd must contain below procedures.

* Run Gatling Scenario
* Store Gatling log to S3

### ECS Task

* Ecs task (running Gatling scenario) must be created by CloudFormation
  * must use FARGATE
  * must contain container which name is "gatling-runner"
    * use Docker Image above
  * Outputs contains task-definition name
* Ecs task (reporter) must be created by cloudformation
  * must use FARGATE
  * must contain container which name is "gatling-s3-reporter"
    * use Docker Image chatwork/gatling-s3-reporter:0.1.1
  * Outputs contains task-definition name

As a Example, please copy and modify samples/cloudformation/gatling-ecs.template to create stack.

### JSON for executing tool

* taskDefs: (Object) // taskDefinitions used in this script
  * runner: (TaskDef) // [required]
  * reporter: (TaskDef)
* awsSubnet: (String) // [required] aws subnet associated with task
* awsSecurityGroup: (String) // aws security group associated with task
* s3LogPrefix: (String) // by default, executionId=S3_dir is automatically generated. When grouping is desired, use this parameter. For example, "some_dir_name/" can be used as directory.
* reportParams
  * hostUrl: (String) // if set, report page URL:`[hostUrl]/[execution_id]/index.html` will be printed to stdout
* chatworkNotificationParams: (Object) // parameters for sending chatwork message when task completed. [Note] Environment Variables `CHATWORK_API_TOKEN` is required
  * roomId: (String)
  * message: (String)
* tasks: (Object)
  * runner: (TaskProp) // [required]
  * reporter: (TaskProp)

`TaskDef` is defined as below
* stackName: (String) // [required] stack name specified when CloudFormation stack is created
* taskName: (String) // [required] Output name for TaskDefinition specified in CloudFormation template

`TaskProp` is defined as below
* executionIdEnvName: (String) // [required for reporter] Environment Variables name when execution_id is used in docker container
* count: (Integer) // The number of instantiations of the specified task
* environment: (Object) // key-value pairs of environment variables

As a Example, please copy and modify samples/example.json

## Usage

### basic example

```sh
# with iam
$ docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2

# with sso
$ aws sso login
$ docker run -it --rm -v ~/.aws:/root/.aws:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2
```

### Using specific aws profile

```sh
# with iam
$ docker run -it --rm -e AWS_PROFILE="xxxxxxx" -v ~/.aws/credentials:/root/.aws/credentials:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2

# with sso
$ aws sso login --profile "xxxxxxx"
$ docker run -it --rm -e AWS_PROFILE="xxxxxxx" -v ~/.aws:/root/.aws:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2
```

### Using Chatwork API Token to send message when task completed

```sh
$ export CHATWORK_API_TOKEN=xxxxxxxxxxxxxxxxxxx

# with iam
$ docker run -it --rm -e AWS_PROFILE="xxxxxxx" -e CHATWORK_API_TOKEN -v ~/.aws/credentials:/root/.aws/credentials:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2

# with sso
$ aws sso login --profile "xxxxxxx"
$ docker run -it --rm -e AWS_PROFILE="xxxxxxx" -e CHATWORK_API_TOKEN -v ~/.aws:/root/.aws:ro -v "$PWD"/gatlingEcs.json:/usr/src/app/setting.json chatwork/gatling-ecs-client:0.1.2
```

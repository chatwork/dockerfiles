# aws cli

https://aws.amazon.com/jp/cli/

## Usage

### Use environment

```
$ docker run -e AWS_ACCESS_KEY_ID=xxx -e AWS_SECRET_ACCESS_KEY=xxx -e AWS_DEFAULT_REGION=ap-northeast-1 chatwork/aws:latest s3 ls
```

### Use profile

```
$ docker run -v $HOME/.aws/credentials:/root/.aws/credentials chatwork/aws:latest s3 ls --profile PROFILE_NAME
```

# Gatling S3 reporter

Generate report page from Gatling logs.
https://gatling.io/docs/2.2/

Gatling logs must be stored in S3 directory, with filename `*.log`.
Gatling report page is created on directory where logs are stored.

## Usage

### basic example

```
$ docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials:ro -e S3_GATLING_BUCKET_NAME=[s3_bucket_name] -e S3_GATLING_RESULT_DIR_PATH=[s3_directory] chatwork/gatling-s3-reporter:latest
```

### Using specific aws profile

```
$ docker run -it --rm -v ~/.aws/credentials:/root/.aws/credentials:ro -e S3_GATLING_BUCKET_NAME=[s3_bucket_name] -e S3_GATLING_RESULT_DIR_PATH=[s3_directory] -e AWS_PROFILE=[profile_name] chatwork/gatling-s3-reporter:latest
```

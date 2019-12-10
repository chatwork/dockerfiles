#!/bin/sh

if [ -z $S3_GATLING_BUCKET_NAME ]; then
  echo "env S3_GATLING_BUCKET_NAME does not exist"
  exit 1
fi

if [ -z $S3_GATLING_RESULT_DIR_PATH ]; then
  echo "env S3_GATLING_RESULT_DIR_PATH does not exist"
  exit 1
fi

mkdir -p $S3_GATLING_RESULT_DIR_PATH

# copy logs from s3
/usr/bin/aws s3 cp s3://${S3_GATLING_BUCKET_NAME}/${S3_GATLING_RESULT_DIR_PATH}/ ${GATLING_HOME}/results/${S3_GATLING_RESULT_DIR_PATH} --recursive --exclude "*" --include "*.log"

# create report
/opt/gatling/bin/gatling.sh -ro ${S3_GATLING_RESULT_DIR_PATH}

# copy report files to s3 (excluding logs)
/usr/bin/aws s3 cp ${GATLING_HOME}/results/${S3_GATLING_RESULT_DIR_PATH} s3://${S3_GATLING_BUCKET_NAME}/${S3_GATLING_RESULT_DIR_PATH}/ --recursive --exclude "*.log"

echo [report url] https://${S3_GATLING_BUCKET_NAME}.s3.amazonaws.com/${S3_GATLING_RESULT_DIR_PATH}/index.html

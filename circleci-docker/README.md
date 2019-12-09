# circleci-docker

Image for running docker build and docker-compose.test.yaml in CircleCI.


## Usage

**.circleci/config.yml**
```
jobs:
  build:
    docker:
      - image: chatwork/circleci-docker:18.09.3
    steps:
      - checkout
      - setup_remote_docker:
          docker_layer_caching: true
          version: 18.09.3
      - run: DOCKER_BUILDKIT=1 docker build -t [your image] .;
      - run: |
          docker-compose -f docker-compose.test.yml up --no-start sut
          docker cp $PWD/goss sut:/goss
          docker-compose -f docker-compose.test.yml up --no-recreate sut
```

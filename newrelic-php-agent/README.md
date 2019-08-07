# newrelic
[https://newrelic.co.jp/](https://newrelic.co.jp/)

## Usage
```
$ docker image build -t chatwork/newrelic-php-agent --build-arg NR_VERSION=${NR_VERSION} ./
$ docker run -e LICENSE_KEY=${LICENSE_KEY} -e APPLICATION_NAME=${APPLICATION_NAME} -t chatwork/newrelic-php-agent 
```
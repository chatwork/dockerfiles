# newrelic
[https://newrelic.co.jp/](https://newrelic.co.jp/)

## Usage
```
$ docker image build -t chatwork/newrelic-php-agent ./
$ docker run -d chatwork/newrelic-php-agent /usr/bin/newrelic-daemon -c /etc/newrelic/newrelic.cfg -f --logfile /dev/stdout
```
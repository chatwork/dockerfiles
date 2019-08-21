# newrelic
[https://newrelic.co.jp/](https://newrelic.co.jp/)

## Usage
```
$ docker image build -t chatwork/newrelic-php-agent ./
$ docker run -d chatwork/newrelic-php-agent -f --pidfile /var/run/newrelic-daemon.pid --logfile /dev/stdout --port /newrelic/.newrelic.sock
```
# Postfix image

Postfix が、ログを syslog に出力するので、syslog デーモンが必要となる。
そこで、Supervisord で、Postfix と rsyslog を実行するようにしている。

## Supervisord

http://supervisord.org/

## rsyslog

https://www.rsyslog.com/

## Postfix

http://www.postfix.org/

## Example

* Postfix コンテナを起動して、ホストの 10025 ポートで待受
```
$ docker run --rm --name postfix -p 10025:25 chatwork/postfix
2018-11-07 06:38:36,020 INFO Set uid to user 0 succeeded
2018-11-07 06:38:36,020 INFO Set uid to user 0 succeeded
2018-11-07 06:38:36,022 INFO supervisord started with pid 13
2018-11-07 06:38:36,022 INFO supervisord started with pid 13
2018-11-07 06:38:37,025 INFO spawned: 'rsyslog' with pid 15
2018-11-07 06:38:37,025 INFO spawned: 'rsyslog' with pid 15
2018-11-07 06:38:37,027 INFO spawned: 'master' with pid 16
2018-11-07 06:38:37,027 INFO spawned: 'master' with pid 16
2018-11-07T06:38:37.163560+00:00 fdb0484594ab postfix/postfix-script[81]: starting the Postfix mail system
2018-11-07T06:38:37.166848+00:00 fdb0484594ab postfix/master[82]: daemon started -- version 3.3.0, configuration /etc/postfix
2018-11-07 06:38:38,168 INFO success: rsyslog entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2018-11-07 06:38:38,168 INFO success: rsyslog entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2018-11-07 06:38:38,168 INFO success: master entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)
2018-11-07 06:38:38,168 INFO success: master entered RUNNING state, process has stayed up for > than 1 seconds (startsecs)

$ curl telnet://localhost:10025
220 fdb0484594ab.localdomain ESMTP Postfix
```
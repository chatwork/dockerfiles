# Postfix Exporter

https://github.com/kumina/postfix_exporter

> A Prometheus exporter for Postfix.

## Usage

```
$ docker run -v /var/spool/postfix/public/showq:/var/spool/postfix/public/showq:r -p 9154:9154 chatwork/kumina-postfix-exporter
```

# chatwork_web assets builder

https://github.com/chatwork/chatwork_web/tree/develop/assets/build_tool

## Usage

```sh
$ docker run --rm -it chatwork/assets-builder php -v
PHP 7.1.26 (cli) (built: Jan 31 2019 01:06:23) ( NTS )
Copyright (c) 1997-2018 The PHP Group
Zend Engine v3.1.0, Copyright (c) 1998-2018 Zend Technologies

$ docker run --rm -it chatwork/assets-builder php -m | grep swoole
swoole

$ docker run --rm -it chatwork/assets-builder java -version
openjdk version "1.8.0_191"
OpenJDK Runtime Environment (IcedTea 3.10.0) (Alpine 8.191.12-r0)
OpenJDK 64-Bit Server VM (build 25.191-b12, mixed mode)
```

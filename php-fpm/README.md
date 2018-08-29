# php-fpm

php-fpm image which resolved dependency and extensions.

## Usage

```
$ docker run -v ${PWD}:/var/www/html chatwork/php-fpm
```

## Configuration

### PHP

http://php.net/manual/ja/install.fpm.configuration.php

* php_flag
* php_value
* php_admin_flag
* php_admin_value

You should define it in pool configuration file (www.conf).

### PHP-FPM

```
/usr/local/etc/
├── php-fpm.conf
├── php-fpm.conf.default
└── php-fpm.d
    ├── docker.conf
    ├── www.conf
    ├── www.conf.default
    └── zz-docker.conf
```

```
$ docker run -v php-fpm.conf:/usr/local/etc/php-fpm.conf \
             -v php-fpm.d:/usr/local/etc/php-fpm.d \
             chatwork/php-fpm
```

Mount the configuration file to be overwritten.

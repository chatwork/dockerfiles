# Fluent Bit

[Fluent Bit](https://fluentbit.io/) is fast and lightweight log processor and forwarder.
In this image, I've added a useful plugin to work with AWS.

## Usag

```
docker run -v [Your fluent-bit.conf]:/fluent-bit/etc/fluent-bit.conf chatwork/fluent-bit:latest /fluent-bit/bin/fluent-bit -e cloudwatch.so -c /fluent-bit/etc/fluent-bit.conf
```

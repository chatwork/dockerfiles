# Fluentd

[Fluentd](https://www.fluentd.org/) is an open source data collector for unified logging layer.
In this image, I've installed the officially introduced plugins and plugins that use Kubernetes, AWS, and GCP.

## Usag

```
docker run -v [Your fluent.conf]:/fluentd/etc/fluent.conf chatwork/fluentd:latest -c /fluentd/etc/fluent.conf
```

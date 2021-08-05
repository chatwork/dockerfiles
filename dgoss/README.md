# dgoss

dgoss is server validation tool.

see [https://github.com/aelsabbahy/goss](https://github.com/aelsabbahy/goss)

## Usage

```
$ docker run \
    -e GOSS_FILES_PATH=/goss \
    -e GOSS_FILES_STRATEGY=cp \
    -v ${PWD}/goss/goss.yaml:/goss/goss.yaml \
    -v /var/run/docker.sock:/var/run/docker.sock \
    chatwork/dgoss run --entrypoint '' {targetImage} tail -f /dev/null
```

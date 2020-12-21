# helmfile

https://github.com/roboll/helmfile

# helm version

This image supports only helm3.

## Usage

```
$ docker run -v ~/.kube:/root/.kube -v ${PWD}/.helm:/root/.helm -v ${PWD}/helmfile.yaml:/helmfile.yaml --net=host chatwork/helmfile sync --args --debug --args --dry-run
```

# helmfile

https://github.com/roboll/helmfile

## Usage

```
$ docker run -v ${PWD}/.helm:/root/.helm chatwork/helm init --client-only
$ docker run -v ~/.kube:/root/.kube -v ${PWD}/.helm:/root/.helm -v ${PWD}/helmfile.yaml:/helmfile.yaml --net=host chatwork/helmfile sync --args --debug --args --dry-run
```

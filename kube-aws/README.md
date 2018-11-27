# kube-aws

https://github.com/kubernetes-incubator/kube-aws.git

## Usage


```
# render stack
docker run -v $HOME/.aws:/root/.aws -v $PWD:/kubeaws -w /kubeaws -e AWS_PROFILE=XXX chatwork/kube-aws render stack

# validate
docker run -v $HOME/.aws:/root/.aws -v $PWD:/kubeaws -w /kubeaws -e AWS_PROFILE=XXX chatwork/kube-aws validate

# apply
docker run -v $HOME/.aws:/root/.aws -v $PWD:/kubeaws -w /kubeaws -e AWS_PROFILE=XXX chatwork/kube-aws apply --force
```

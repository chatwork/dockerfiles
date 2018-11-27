# sops

This image for mozilla sops(https://github.com/mozilla/sops).

# Usage

## encrypt

```
# if you use aws kms and you make .sops.yaml file in ${WORKING_DIR}
$ cd ${WORKING_DIR}
$ docker run -v $HOME/.aws:/root/.aws -v $PWD:/sops -w /sops -e AWS_PROFILE=XXXX chatwork/sops -e secrets.dec.yaml
```

## descrypt
```
# if you use aws kms and you make .sops.yaml file in ${WORKING_DIR}
$ cd ${WORKING_DIR}
$ docker run -v $HOME/.aws:/root/.aws -v $PWD:/sops -w /sops -d AWS_PROFILE=XXXX chatwork/sops -d secrets.enc.yaml
```

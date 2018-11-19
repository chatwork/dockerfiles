# variant

https://github.com/mumoshu/variant/

> Task runner for the container era.
> Containerize bash scripting workflows with dataflows and dependency injection, JSON Schema for inputs validation.

## Usage

```
$ cat variant.definition.yaml
flows:
  echo:
    script: |
      echo 1
$ docker run -v ${PWD}:/variant chatwork/variant echo
```

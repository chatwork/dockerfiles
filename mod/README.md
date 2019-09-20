# variant

https://github.com/variantdev/mod/

> Package manager for Makefile and Variantfile. Any set of files in Git/S3/GCS/HTTP as a reusable and parameterized module

## Usage

```
$ cat variant.mod
provisioners:
  files:
    Dockerfile:
      source: Dockerfile.tpl
      arguments:
        git:
          version: "{{ .git.version }}"
        mod:
          version: "{{ .mod.version }}"

dependencies:
  git:
    releasesFrom:
      dockerImageTags:
        source: alpine/git
      version: "> 1.0.6"
  mod:
    releasesFrom:
      githubReleases:
        source: variantdev/mod

$ docker run -v ${PWD}:/mod chatwork/mod up --build
```

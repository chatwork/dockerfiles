# gha-runner-scale-set-helmfile

GitHub Actions self-hosted runner image based on the new ARC (`gha-runner-scale-set`) base image, with helmfile / helm / kubectl / kustomize / yq and helm plugins (helm-diff / helm-secrets / helm-git) pre-installed.

The legacy `actions-runner-helmfile` directory keeps the old summerwind base for the legacy ARC; this directory is the new ARC equivalent and will eventually replace it once the legacy ARC runners are decommissioned.

https://github.com/actions/actions-runner-controller

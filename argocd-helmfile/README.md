# ArgoCD with helmfile

https://argoproj.github.io/argo-cd/

This is an image to use helmfile in ArgoCD's config management plugins.

## Usage

You can change the Argo CD repo server image to this image and add the following settings to `argocd-cm` and add helmfile options as needed to configure.

```
data:
  configManagementPlugins: |
    - name: helmfile
      generate:
        command: ["/bin/sh", "-c"]
        args: ["helmfile -q template --include-crds --skip-tests"]
```

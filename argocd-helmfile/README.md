# ArgoCD with helmfile

https://argoproj.github.io/argo-cd/

This is an image to use helmfile in ArgoCD's config management plugins.

# Usage

You can change the Argo CD repo server image to this image and add the following settings to `argocd-cm` and add helmfile options as needed to configure.

```
data:
  configManagementPlugins: |
    - name: helmfile
      generate:
        command: ["/bin/sh", "-c"]
        args: ["helmfile -q template --include-crds --skip-tests"]
```

Plugin configuration in `argocd-cm` is deprecated in 2.6.

You can use this image as a sidecar, or we have prepared a more lightweight [sidecar image](https://github.com/chatwork/dockerfiles/tree/master/argocd-helmfile-plugin).

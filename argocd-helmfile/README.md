# ArgoCD with helmfile

https://argoproj.github.io/argo-cd/

This is an image to use helmfile in ArgoCD's config management plugins.

## Usage

You can change the Argo CD repo server image to this image and add the following settings to `argocd-cm`.

```
data:
  configManagementPlugins: |
    - name: helmfile
      generate:
        command: ["/bin/sh", "-c"]
        args: ["helmfile --namespace $ARGOCD_APP_NAMESPACE template | sed -e '1,/---/d' | sed -e 's|apiregistration.k8s.io/v1beta1|apiregistration.k8s.io/v1|g'"]
```

`helmfile template` removes extra output with `sed` to put it on STDOUT.
In addition, it is necessary to rewrite it because a [problem occurs](https://github.com/argoproj/argo-cd/issues/1414) in the version of apiregistration in metrics-server.

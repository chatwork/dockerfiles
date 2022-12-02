# argocd-helmfile-plugin

This image is to enable the use of helmfile in the sidecar for argocd plugin.

- https://github.com/helmfile/helmfile
- https://argo-cd.readthedocs.io/en/latest/user-guide/config-management-plugins/

# helm version

This image supports only helm3.

# Usage

You need configmap for cmp-plugin.

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: helmfile-plugin
  namespace: argocd
data:
  plugin.yaml: |
    apiVersion: argoproj.io/v1alpha1
    kind: ConfigManagementPlugin
    metadata:
      name: helmfile-plugin
    spec:
      version: v1.0
      generate:
        args:
          - helmfile -q template --include-crds --skip-tests
        command:
          - /bin/sh
          - -c
      discover:
        find:
          command:
            - sh
            - -c
            - find . -name helmfile.yaml
```

and you need to add manifest sidecar in repo-server manifest.

If you are using [argocd chart](https://github.com/argoproj/argo-helm), you do not need to set up initContainer.

```
    spec:
      containers:
      .
      .
      .
      - name: helmfile-plugin
        command:
          - /var/run/argocd/argocd-cmp-server
        image: chatwork/argocd-helmfile-sidecar-plugin:latest
        securityContext:
          runAsNonRoot: true
          runAsUser: 999
        volumeMounts:
          - mountPath: /var/run/argocd
            name: var-files
          - mountPath: /home/argocd/cmp-server/plugins
            name: plugins
          - mountPath: /home/argocd/cmp-server/config/plugin.yaml
            name: helmfile-plugin
            subPath: plugin.yaml
          - mountPath: /tmp
            name: helmfile-plugin-tmp
      .
      .
      .
      volumes:
        - configMap:
            name: helmfile-plugin
          name: helmfile-plugin
        - emptyDir: {}
          name: helmfile-plugin-tmp
      .
      .
      .
      initContainers:
      - command:
        - cp
        - -n
        - /usr/local/bin/argocd
        - /var/run/argocd/argocd-cmp-server
        image: quay.io/argoproj/argocd:latest
        imagePullPolicy: IfNotPresent
        name: copyutil
        securityContext:
          allowPrivilegeEscalation: false
          capabilities:
            drop:
            - ALL
          readOnlyRootFilesystem: true
          runAsNonRoot: true
          seccompProfile:
            type: RuntimeDefault
        volumeMounts:
        - mountPath: /var/run/argocd
          name: var-files
```

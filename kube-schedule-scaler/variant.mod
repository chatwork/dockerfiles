provisioners:
  textReplace:
    Dockerfile:
      from: "ARG KUBE_SCHEDULE_SCALER_VERSION=v{{ .kubeScheduleScaler.previousVersion }}"
      to: "ARG KUBE_SCHEDULE_SCALER_VERSION=v{{ .kubeScheduleScaler.version }}"

dependencies:
  kubeScheduleScaler:
    releasesFrom:
      githubTags:
        source: chatwork/kube-schedule-scaler
    version: "> 0.0.0"

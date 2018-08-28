FROM chatwork/helm:2.7.2

LABEL version "0.23.1"
LABEL maintainer "ozaki@chatwork.com"

ENV HELMFILE_VERSION 0.23.1

WORKDIR /

RUN apk --update --no-cache add ca-certificates

ADD https://github.com/roboll/helmfile/releases/download/v${HELMFILE_VERSION}/helmfile_linux_amd64 /bin/helmfile
RUN chmod 0755 /bin/helmfile

ENTRYPOINT ["/bin/helmfile"]

ARG HELMFILE_VERSION=0.98.1

FROM quay.io/roboll/helmfile:helm3-v${HELMFILE_VERSION}

ARG HELMFILE_VERSION=0.98.1
ARG HELM_X_VERSION=0.7.2
ARG EKS_VERSION=1.14.6
ARG EKS_DATE=2019-08-22

LABEL version="${HELMFILE_VERSION}"
LABEL maintainer="ozaki@chatwork.com"
LABEL maintainer="sakamoto@chatwork.com"

WORKDIR /

RUN helm plugin install https://github.com/mumoshu/helm-x --version v${HELM_X_VERSION}

RUN curl -o /usr/local/bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/${EKS_VERSION}/${EKS_DATE}/bin/linux/amd64/aws-iam-authenticator && \
    chmod +x /usr/local//bin/aws-iam-authenticator

RUN apk --no-cache add python3 py3-pip groff jq \
    && pip3 install --no-cache-dir --upgrade pip \
    && pip3 install --no-cache-dir awscli

ENTRYPOINT ["/usr/local/bin/helmfile"]

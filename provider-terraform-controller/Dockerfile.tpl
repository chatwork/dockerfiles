ARG CROSSPLANE_PROVIDER_TERRAFORM_VERSION={{ .provider_terraform_version }}

FROM crossplane/provider-terraform-controller:v${CROSSPLANE_PROVIDER_TERRAFORM_VERSION}

ARG TARGETARCH

ARG CROSSPLANE_PROVIDER_TERRAFORM_VERSION={{ .provider_terraform_version }}
ARG TERRAFORM_VERSION={{ .terraform_version }}

LABEL version="${CROSSPLANE_PROVIDER_TERRAFORM_VERSION}-${TERRAFORM_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

USER root

RUN cd /tmp \
    && wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip \
    && unzip terraform_${TERRAFORM_VERSION}_linux_${TARGETARCH}.zip \
    && mv terraform /usr/local/bin/ \
    && rm -f /tmp/*

USER 2000

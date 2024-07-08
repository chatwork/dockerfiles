FROM chatwork/aws:2.17.10

ARG TARGETARCH
ARG ATLANTIS_VERSION=0.28.3
ARG GOSU_VERSION=1.17
ARG GIT_LFS_VERSION=3.5.1
ARG DUMB_INIT_VERSION=1.2.5
ENV DEFAULT_TERRAFORM_VERSION=1.9.1
LABEL version="${ATLANTIS_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

# In the official Atlantis image we only have the latest of each Terraform version.
SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN AVAILABLE_TERRAFORM_VERSIONS="0.11.15 0.12.31 0.13.7 0.14.11 0.15.5 1.0.11 1.1.9 1.2.9 ${DEFAULT_TERRAFORM_VERSION}" && \
    case "${TARGETARCH}" in \
        "amd64") TERRAFORM_ARCH=amd64 ;; \
        "arm64") TERRAFORM_ARCH=arm64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    for VERSION in ${AVAILABLE_TERRAFORM_VERSIONS}; do \
        curl -LOs "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" && \
        curl -LOs "https://releases.hashicorp.com/terraform/${VERSION}/terraform_${VERSION}_SHA256SUMS" && \
        sed -n "/terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip/p" "terraform_${VERSION}_SHA256SUMS" | sha256sum -c && \
        mkdir -p "/usr/local/bin/tf/versions/${VERSION}" && \
        unzip "terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" -d "/usr/local/bin/tf/versions/${VERSION}" && \
        ln -s "/usr/local/bin/tf/versions/${VERSION}/terraform" "/usr/local/bin/terraform${VERSION}" && \
        rm "terraform_${VERSION}_linux_${TERRAFORM_ARCH}.zip" && \
        rm "terraform_${VERSION}_SHA256SUMS"; \
    done && \
    ln -s "/usr/local/bin/tf/versions/${DEFAULT_TERRAFORM_VERSION}/terraform" /usr/local/bin/terraform

ARG CONFTEST_VERSION=0.54.0
ARG CONFTEST_RPM_FILE="conftest_${CONFTEST_VERSION}_linux_${TARGETARCH}.rpm"

RUN curl -LOs https://github.com/open-policy-agent/conftest/releases/download/v${CONFTEST_VERSION}/${CONFTEST_RPM_FILE} && \
    rpm -i ./${CONFTEST_RPM_FILE} && \
    rm -f ./${CONFTEST_RPM_FILE}

RUN curl -LOs https://github.com/runatlantis/atlantis/releases/download/v${ATLANTIS_VERSION}/atlantis_linux_${TARGETARCH}.zip && \
    unzip ./atlantis_linux_${TARGETARCH}.zip && \
    mv ./atlantis /usr/local/bin/atlantis && \
    curl -LOs https://raw.githubusercontent.com/runatlantis/atlantis/v${ATLANTIS_VERSION}/docker-entrypoint.sh && \
    mv ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh && \
    rm -f ./atlantis_linux_${TARGETARCH}.zip

RUN case "${TARGETARCH}" in \
        "amd64") DUMB_INIT_ARCH=x86_64 ;; \
        "arm64") DUMB_INIT_ARCH=aarch64 ;; \
        *) echo "ERROR: 'TARGETARCH' value expected: ${TARGETARCH}"; exit 1 ;; \
    esac && \
    curl -L -s --output dumb-init https://github.com/Yelp/dumb-init/releases/download/v${DUMB_INIT_VERSION}/dumb-init_${DUMB_INIT_VERSION}_${DUMB_INIT_ARCH} && \
    mv ./dumb-init /usr/bin/dumb-init && \
    chmod +x /usr/bin/dumb-init && \
    curl -L -s --output gosu "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${TARGETARCH}" && \
    curl -L -s --output gosu.asc "https://github.com/tianon/gosu/releases/download/${GOSU_VERSION}/gosu-${TARGETARCH}.asc" && \
    for server in $(shuf -e ipv4.pool.sks-keyservers.net \
                            hkp://p80.pool.sks-keyservers.net:80 \
                            keyserver.ubuntu.com \
                            hkp://keyserver.ubuntu.com:80 \
                            pgp.mit.edu) ; do \
        gpg --keyserver "$server" --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 && break || : ; \
    done && \
    gpg --batch --verify gosu.asc gosu && \
    chmod +x gosu && \
    mv gosu /bin && \
    gosu --version && \
    yum install -y shadow-utils git && \
    groupadd atlantis && \
    adduser -g atlantis atlantis && \
    usermod -aG root atlantis && \
    chown atlantis:root /home/atlantis/ && \
    chmod g=u /home/atlantis/ && \
    chmod g=u /etc/passwd && \
    curl -L -s --output git-lfs.tar.gz "https://github.com/git-lfs/git-lfs/releases/download/v${GIT_LFS_VERSION}/git-lfs-linux-${TARGETARCH}-v${GIT_LFS_VERSION}.tar.gz" && \
    tar -xf git-lfs.tar.gz && \
    chmod +x ./git-lfs-${GIT_LFS_VERSION}/git-lfs && \
    mv ./git-lfs-${GIT_LFS_VERSION}/git-lfs /usr/bin/git-lfs && \
    rm -rf ./git-lfs-${GIT_LFS_VERSION} && \
    rm git-lfs.tar.gz

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["server"]

ARG DATADOG_VERSION=7.27.0

FROM datadog/agent:${DATADOG_VERSION}

ARG DATADOG_VERSION=7.27.0

LABEL version="${DATADOG_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

RUN apt-get update \
    && apt-get install -y --no-install-recommends iproute2 conntrack \
    && rm -rf /var/lib/apt/lists/*
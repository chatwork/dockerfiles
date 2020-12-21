ARG PYTHON_VERSION=3.7-alpine

FROM python:${PYTHON_VERSION}

ARG TAVERN_VERSION=1.7.0
ARG TLDR_VERSION=0.2.2

LABEL version="${TAVERN_VERSION}"
LABEL maintainer="shinohara@chatwork.com"

RUN mkdir /tavern \
    && pip install tavern[pytest]==$TAVERN_VERSION --no-cache-dir \
    && pip install pytest-tldr==$TLDR_VERSION --no-cache-dir

WORKDIR /tavern

ENTRYPOINT ["tavern-ci"]

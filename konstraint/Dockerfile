FROM alpine/git:latest as git

ARG KONSTRAINT_VERSION=0.34.0

WORKDIR /
RUN git clone https://github.com/plexsystems/konstraint -b v${KONSTRAINT_VERSION} --depth=1 /konstraint

FROM golang:1.19-alpine AS build
ARG TARGETARCH

ARG KONSTRAINT_VERSION=0.34.0

WORKDIR /go/src/github.com/plexsystems/konstraint

COPY --from=git /konstraint /go/src/github.com/plexsystems/konstraint
RUN go mod download

RUN GOOS=linux GOARCH=${TARGETARCH} go build -o /konstraint -ldflags="-s -w -X github.com/plexsystems/konstraint/internal/commands.version=v${KONSTRAINT_VERSION}"

FROM alpine:3.16
ARG KONSTRAINT_VERSION=0.34.0
LABEL version="${KONSTRAINT_VERSION}"
LABEL maintainer="sakamoto@chatwork.com"

COPY --from=build /konstraint /usr/local/bin/konstraint
ENTRYPOINT ["konstraint"]

FROM alpine/git:1.0.4 as git

ARG VARIANT_VERSION=bc654794debb5d4cda53953ddea02a5f33dbdf5c+dirty

WORKDIR /

RUN git clone https://github.com/mumoshu/variant.git \
    && cd /variant \
    && git checkout -b tag refs/tags/$VARIANT_VERSION || git checkout $(echo $VARIANT_VERSION | sed 's/+dirty$//') -b variant-master


FROM instrumentisto/dep:0.5.0 as dep

WORKDIR /go/src/github.com/mumoshu/variant

COPY --from=git /variant /go/src/github.com/mumoshu/variant

RUN dep ensure


FROM golang:1.11.1-alpine as builder

ENV GOOS=linux
ENV GOARCH=amd64

WORKDIR /go/src/github.com/mumoshu/variant

COPY --from=dep /go/src/github.com/mumoshu/variant /go/src/github.com/mumoshu/variant
COPY diff.patch /go/src/github.com/mumoshu/variant/diff.patch

RUN apk add --no-cache bash make git ca-certificates && patch -p1 < diff.patch && make build


FROM alpine:latest

ARG VARIANT_VERSION=bc654794debb5d4cda53953ddea02a5f33dbdf5c+dirty

LABEL version="${VARIANT_VERSION}"
LABEL maintainer="ozaki@chatwork.com"

COPY --from=builder /go/src/github.com/mumoshu/variant/dist/${VARIANT_VERSION}/var /usr/local/bin/variant

VOLUME ["/variant"]
WORKDIR /variant

ENTRYPOINT ["/usr/local/bin/variant"]
CMD ["--help"]

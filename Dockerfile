FROM registry.access.redhat.com/ubi9/go-toolset@sha256:14c369670cf3473d8e9b93e42d120c01b79a6f13884c396a1c89b7ca46f859b7 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:14c369670cf3473d8e9b93e42d120c01b79a6f13884c396a1c89b7ca46f859b7
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

FROM registry.redhat.io/ubi9/go-toolset@sha256:c7bfd2501cb1be171366434a368db669b32f08a0198c1473b9bff0a379613fc3 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.redhat.io/ubi9/go-toolset@sha256:c7bfd2501cb1be171366434a368db669b32f08a0198c1473b9bff0a379613fc3
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"


FROM registry.access.redhat.com/ubi9/go-toolset@sha256:6fd64cd7f38a9b87440f963b6c04953d04de65c35b9672dbd7f1805b0ae20d09 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:6fd64cd7f38a9b87440f963b6c04953d04de65c35b9672dbd7f1805b0ae20d09
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

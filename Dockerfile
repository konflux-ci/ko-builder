FROM registry.access.redhat.com/ubi9/go-toolset@sha256:ad0ad037a1e3f7072c1c77662ed8256ecbbf5b1fc3bc89796cdae24cf649345a AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:ad0ad037a1e3f7072c1c77662ed8256ecbbf5b1fc3bc89796cdae24cf649345a
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

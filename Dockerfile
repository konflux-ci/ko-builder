FROM registry.access.redhat.com/ubi9/go-toolset@sha256:f4cd09b55c3c9c51a934d0c42cc90eca5e2e331a90c8aae31515e04ba96a7ad7 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:f4cd09b55c3c9c51a934d0c42cc90eca5e2e331a90c8aae31515e04ba96a7ad7
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

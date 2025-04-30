FROM registry.access.redhat.com/ubi9/go-toolset@sha256:8a634d63713a073d7a1e086a322e57b148eef9620834fc8266df63d9294dff1b AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:8a634d63713a073d7a1e086a322e57b148eef9620834fc8266df63d9294dff1b
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

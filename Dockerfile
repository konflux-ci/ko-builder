FROM registry.access.redhat.com/ubi9/go-toolset@sha256:a90b4605b47c396c74de55f574d0f9e03b24ca177dec54782f86cdf702c97dbc AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:a90b4605b47c396c74de55f574d0f9e03b24ca177dec54782f86cdf702c97dbc
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

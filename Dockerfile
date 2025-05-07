FROM registry.access.redhat.com/ubi9/go-toolset@sha256:3a2c4a84e7991138c00c5e9835860c048c985bb2c2cdce64567014df470b695c AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:3a2c4a84e7991138c00c5e9835860c048c985bb2c2cdce64567014df470b695c
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

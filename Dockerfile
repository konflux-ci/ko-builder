FROM registry.access.redhat.com/ubi9/go-toolset@sha256:e0ad156b08e0b50ad509d79513e13e8a31f2812c66e9c48c98cea53420ec2bca AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:e0ad156b08e0b50ad509d79513e13e8a31f2812c66e9c48c98cea53420ec2bca
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

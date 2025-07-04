FROM registry.access.redhat.com/ubi9/go-toolset@sha256:381fb72f087a07432520fa93364f66b5981557f1dd708f3c4692d6d0a76299b3 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:381fb72f087a07432520fa93364f66b5981557f1dd708f3c4692d6d0a76299b3
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

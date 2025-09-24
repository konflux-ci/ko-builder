FROM registry.access.redhat.com/ubi9/go-toolset@sha256:84286c7555df503df0bd3acb86fe2ad50af82a07f35707918bb0fad312fdc193 AS builder
ARG KO_VERSION=v0.17.1
RUN GOBIN=/tmp go install github.com/google/ko@${KO_VERSION}

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:84286c7555df503df0bd3acb86fe2ad50af82a07f35707918bb0fad312fdc193
COPY --from=builder /tmp/ko /usr/bin/ko
ENTRYPOINT ["/usr/bin/ko"]

LABEL org.opencontainers.image.description="konflux ubi based ko builder image"
LABEL org.opencontainers.image.licenses="Apache-2.0"

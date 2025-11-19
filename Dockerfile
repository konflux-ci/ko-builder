FROM registry.access.redhat.com/ubi9/go-toolset@sha256:6234f572204d672a0ee0686d748fbb9b7b05679368bf0d7a4446e13970e58060 AS builder
COPY go.mod go.sum .
RUN GOBIN=/tmp go install -mod=readonly github.com/google/ko
RUN GOBIN=/tmp go install -mod=readonly github.com/sigstore/cosign/v2/cmd/cosign

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:6234f572204d672a0ee0686d748fbb9b7b05679368bf0d7a4446e13970e58060
COPY --from=builder /tmp/ko /usr/bin/ko
COPY --from=builder /tmp/cosign /usr/bin/cosign


ENTRYPOINT ["/usr/bin/ko"]


LABEL org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="Konflux CI" \
      org.opencontainers.image.vendor="Konflux CI" \
      org.opencontainers.image.url="https://quay.io/repository/redhat-user-workloads/konflux-build-pipeli-tenant/ko-builder" \
      org.opencontainers.image.source="https://github.com/konflux-ci/ko-builder" \
      org.label-schema.name="ko-builder" \
      org.opencontainers.image.title="ko-builder" \
      name="ko-builder" \
      com.redhat.component="konflux-ko-builder" \
      io.k8s.display-name="konflux-ko-builder" \
      io.openshift.tags="ko oci" \
      summary="Container of ko which can be used to build OCI artifacts within Konflux CI." \
      description="OCI images and artifacts are central to the architecture of Konflux. In order to ensure that we can always take advantage of the latest functionality, this image can be used to reliably build the latest version of the CLI." \
      io.k8s.display-name="ko-builder" \
      io.k8s.description="OCI images and artifacts are central to the architecture of Konflux. In order to ensure that we can always take advantage of the latest functionality, this image can be used to reliably build the latest version of the CLI." \
      io.openshift.tags="oci" \
      vendor="Red Hat, Inc." \
      distribution-scope="public" \
      release="0" \
      url="github.com/konflux-ci/ko-builder"


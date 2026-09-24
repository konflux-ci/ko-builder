FROM registry.access.redhat.com/ubi9/go-toolset:1.26.7-1789950433@sha256:15c3098dc4639e8a0e6a1bc77b50964513a1d76dccae4b07b9808101c5addd04 AS ko-builder
COPY tools/ko/go.mod .
COPY tools/ko/go.sum .
RUN GOBIN=/tmp go install -mod=readonly github.com/google/ko

FROM registry.access.redhat.com/ubi9/go-toolset:1.26.7-1789950433@sha256:15c3098dc4639e8a0e6a1bc77b50964513a1d76dccae4b07b9808101c5addd04 AS cosign-builder
COPY tools/cosign/go.mod .
COPY tools/cosign/go.sum .
RUN GOBIN=/tmp go install -mod=readonly github.com/sigstore/cosign/v3/cmd/cosign

FROM registry.access.redhat.com/ubi9/go-toolset:1.26.7-1789950433@sha256:15c3098dc4639e8a0e6a1bc77b50964513a1d76dccae4b07b9808101c5addd04
COPY --from=ko-builder /tmp/ko /usr/bin/ko
COPY --from=cosign-builder /tmp/cosign /usr/bin/cosign

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


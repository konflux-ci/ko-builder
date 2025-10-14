FROM registry.access.redhat.com/ubi9/go-toolset@sha256:7b1828de52c3bac600a71b81996bf748776a456181a45e2b329b39702cf6486f AS builder
COPY go.mod go.sum .
RUN GOBIN=/tmp go install -mod=readonly github.com/google/ko

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:7b1828de52c3bac600a71b81996bf748776a456181a45e2b329b39702cf6486f
COPY --from=builder /tmp/ko /usr/bin/ko
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


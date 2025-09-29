FROM registry.access.redhat.com/ubi9/go-toolset@sha256:14c369670cf3473d8e9b93e42d120c01b79a6f13884c396a1c89b7ca46f859b7 AS builder
COPY go.mod go.sum .
RUN GOBIN=/tmp go install -mod=readonly github.com/google/ko

FROM registry.access.redhat.com/ubi9/go-toolset@sha256:14c369670cf3473d8e9b93e42d120c01b79a6f13884c396a1c89b7ca46f859b7
COPY --from=builder /tmp/ko /usr/bin/ko

USER root
RUN yum install -y docker

#ENTRYPOINT ["/usr/bin/ko"]

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


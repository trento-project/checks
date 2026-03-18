ARG OS_VER=15.7
FROM registry.suse.com/bci/bci-base:${OS_VER}
ARG OS_VER
ARG VERSION
# Define labels according to https://en.opensuse.org/Building_derived_containers
# labelprefix=com.suse.trento
LABEL org.opencontainers.image.authors="https://github.com/trento-project/checks/graphs/contributors"
LABEL org.opencontainers.image.title="Trento Checks"
LABEL org.opencontainers.image.description="Checks for Trento to be executed by Wanda. Previously part of Wanda itself"
LABEL org.opencontainers.image.documentation="https://www.trento-project.io/docs/checks/README.html"
LABEL org.opencontainers.image.version="${VERSION}"
LABEL org.opencontainers.image.url="https://github.com/trento-project/checks"
# LABEL org.opencontainers.image.created="" # Set by GHA, no need to set here
LABEL org.opencontainers.image.source="https://github.com/trento-project/checks"
LABEL org.opencontainers.image.ref.name="${OS_VER}-${VERSION}"
LABEL org.opensuse.reference="registry.suse.com/bci/bci-micro:${OS_VER}"
LABEL org.openbuildservice.disturl="https://github.com/trento-project/checks/pkgs/container/checks"
# endlabelprefix
LABEL org.opencontainers.image.base.name="registry.suse.com/bci/bci-micro:${OS_VER}"
LABEL org.opencontainers.image.base.digest="latest"
LABEL io.artifacthub.package.logo-url="https://www.trento-project.io/images/trento-icon.svg"
LABEL io.artifacthub.package.readme-url="https://raw.githubusercontent.com/trento-project/checks/refs/heads/main/packaging/suse/container/README.md"

# If set to C, LC_ALL takes precedence
ENV LC_ALL=C.UTF-8

RUN mkdir --mode=0600 /tmp/trento-checks-build

WORKDIR /tmp/trento-checks-build

# checks.tar.gz is provided by OBS (build.opensuse.org)
ADD checks.tar.gz .

RUN install --directory --mode=0755 /usr/src/trento-checks
RUN install --directory --mode=0755 /usr/src/trento-checks/checks
RUN install --preserve-timestamps --mode=0644 ./checks/checks/* /usr/src/trento-checks/checks
RUN install --preserve-timestamps --mode=0755 ./checks/bin/trento-install-checks /usr/bin/trento-install-checks

WORKDIR /

RUN rm -r /tmp/trento-checks-build

ENTRYPOINT ["/usr/bin/trento-install-checks"]

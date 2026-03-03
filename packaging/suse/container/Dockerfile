# SPDX-License-Identifier: GPL-3.0-or-later
#!BuildTag: trento/trento-checks:latest
#!BuildTag: trento/trento-checks:%%VERSION%%
#!BuildTag: trento/trento-checks:%%VERSION%%-build%RELEASE%
#!BuildName: trento-checks
#!BuildVersion: %%VERSION%%
#!UseOBSRepositories
#!ExclusiveArch: x86_64
ARG OS_VER=15.7
FROM registry.suse.com/bci/bci-base:${OS_VER}
# Define labels according to https://en.opensuse.org/Building_derived_containers
# labelprefix=com.suse.trento
LABEL org.opencontainers.image.authors="https://github.com/trento-project/checks/graphs/contributors"
LABEL org.opencontainers.image.title="Trento checks"
LABEL org.opencontainers.image.description="Checks for Trento to be executed by Wanda. Previously part of Wanda itself"
LABEL org.opencontainers.image.documentation="https://documentation.suse.com/sles-sap/trento"
LABEL org.opencontainers.image.version="%%VERSION%%"
LABEL org.opencontainers.image.url="https://www.suse.com/products/base-container-images/"
LABEL org.opencontainers.image.created="%BUILDTIME%"
LABEL org.opencontainers.image.vendor="SUSE LLC"
LABEL org.opencontainers.image.source="%SOURCEURL%"
LABEL org.opencontainers.image.ref.name="%%VERSION%%-build%RELEASE%"
LABEL org.opensuse.reference="registry.suse.com/trento/trento-checks:%%VERSION%%-build%RELEASE%"
LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL com.suse.supportlevel="l3"
LABEL com.suse.supportlevel.until=""
LABEL com.suse.eula="sle-bci"
LABEL com.suse.lifecycle-url="https://www.suse.com/lifecycle#suse-linux-enterprise-server-for-sap-applications-15"
LABEL com.suse.release-stage="released"
# endlabelprefix
LABEL org.opencontainers.image.base.name="%BASE_REFNAME%"
LABEL org.opencontainers.image.base.digest="%BASE_DIGEST%"
LABEL io.artifacthub.package.logo-url="https://www.trento-project.io/images/trento-icon.svg"
LABEL io.artifacthub.package.readme-url="%SOURCEURL_WITH(README.md)%"

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

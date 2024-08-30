# SPDX-License-Identifier: Apache-2.0
#!BuildTag: trento/trento-checks:latest
#!BuildTag: trento/trento-checks:%%VERSION%%
#!BuildTag: trento/trento-checks:%%VERSION%%-build%RELEASE%
#!UseOBSRepositories
#!ExclusiveArch: x86_64
FROM bci/bci-base:15.4

LABEL org.opencontainers.image.source="https://github.com/trento-project/checks"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# tar is required by kubectl cp
RUN zypper --non-interactive in -y tar && \
    zypper --non-interactive clean

ADD checks.tar.gz /build/

RUN mkdir -p /usr/local/src/trento-checks

RUN mv /build/checks/checks /usr/local/src/trento-checks/checks

RUN mv /build/checks/bin/trento-install-checks /usr/local/bin/trento-install-checks
RUN chmod +x /usr/local/bin/trento-install-checks

ENTRYPOINT ["/usr/local/bin/trento-install-checks"]

FROM bci/bci-base:15.4

LABEL org.opencontainers.image.source="https://github.com/trento-project/checks"

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# tar is required by kubectl cp
RUN zypper --non-interactive in -y tar && \
    zypper --non-interactive clean

COPY checks /usr/local/src/trento-checks/checks
COPY bin/trento-install-checks /usr/local/bin/trento-install-checks

RUN chmod +x /usr/local/bin/trento-install-checks

ENTRYPOINT ["/usr/local/bin/trento-install-checks"]

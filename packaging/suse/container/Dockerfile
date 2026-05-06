# SPDX-FileCopyrightText: SUSE LLC
# SPDX-License-Identifier: GPL-3.0-or-later
#!BuildTag: trento/trento-checks:latest
#!BuildTag: trento/trento-checks:%%VERSION%%
#!BuildTag: trento/trento-checks:%%VERSION%%-build%RELEASE%
#!BuildName: trento-checks
#!BuildVersion: %%VERSION%%
#!UseOBSRepositories
#!ExclusiveArch: x86_64

FROM registry.suse.com/bci/bci-base:15.7

# If set to C, LC_ALL takes precedence
ENV LC_ALL=C.UTF-8

# Define labels according to https://en.opensuse.org/Building_derived_containers
# labelprefix=com.suse.trento
LABEL org.opencontainers.image.authors="https://github.com/trento-project/checks/graphs/contributors"
LABEL org.opencontainers.image.title="Trento checks"
LABEL org.opencontainers.image.description="Checks for Trento to be executed by Wanda. Previously part of Wanda itself"
LABEL org.opencontainers.image.documentation="https://documentation.suse.com/sles-sap/trento"
LABEL org.opencontainers.image.version="%%VERSION%%"
LABEL org.opencontainers.image.url="https://github.com/trento-project/checks"
LABEL org.opencontainers.image.created="%BUILDTIME%"
LABEL org.opencontainers.image.vendor="SUSE LLC"
LABEL org.opencontainers.image.source="%SOURCEURL%"
LABEL org.opencontainers.image.ref.name="%%VERSION%%-build%RELEASE%"
LABEL org.opensuse.reference="registry.suse.com/trento/trento-checks:%%VERSION%%-build%RELEASE%"
LABEL org.openbuildservice.disturl="%DISTURL%"
LABEL com.suse.supportlevel="l3"
LABEL com.suse.supportlevel.until=""
LABEL com.suse.eula="sle-eula"
LABEL com.suse.lifecycle-url="https://www.suse.com/lifecycle#suse-linux-enterprise-server-for-sap-applications-15"
LABEL com.suse.release-stage="released"
# endlabelprefix
LABEL org.opencontainers.image.base.name="%BASE_REFNAME%"
LABEL org.opencontainers.image.base.digest="%BASE_DIGEST%"
LABEL io.artifacthub.package.logo-url="https://www.trento-project.io/images/trento-icon.svg"
LABEL io.artifacthub.package.readme-url="%SOURCEURL_WITH(README.md)%"

# Install into `/virtualroot` to preserve backwards-compatibility with
# Kubernetes deployment expectations -- /usr/share/trento/checks is
# set as mountPoint and it would shadow the installed files.
RUN set -euo pipefail; \
    zypper -n --installroot /virtualroot install --no-recommends trento-checks

# cleanup logs and temporary files
RUN set -euo pipefail; zypper -n --installroot /virtualroot clean -a; \
    rm -rf {/virtualroot,}/var/log/{alternatives.log,lastlog,tallylog,zypper.log,zypp/history,YaST2}; \
    rm -rf {/virtualroot,}/run/*; \
    rm -f {/virtualroot,}/etc/{shadow-,group-,passwd-,.pwd.lock}; \
    rm -f {/virtualroot,}/usr/lib/sysimage/rpm/.rpm.lock; \
    rm -f {/virtualroot,}/var/lib/zypp/AnonymousUniqueId; \
    rm -f {/virtualroot,}/var/lib/zypp/AutoInstalled; \
    rm -f {/virtualroot,}/var/cache/ldconfig/aux-cache

# set the day of last password change to empty
RUN set -euo pipefail; sed -i 's/^\([^:]*:[^:]*:\)[^:]*\(:.*\)$/\1\2/' /etc/shadow

# Copy the install script to standard PATH
RUN install --preserve-timestamps --mode=0755 /virtualroot/usr/share/trento/trento-install-checks /usr/bin/trento-install-checks

ENTRYPOINT ["/usr/bin/trento-install-checks"]

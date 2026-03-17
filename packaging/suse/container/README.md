# Trento Checks Container Image

## Description

This image contains the Trento Checks catalog and the `trento-install-checks` installer.

Trento Checks provide continuous infrastructure compliance through declarative YAML checks executed by [Wanda](https://github.com/trento-project/wanda).

The container is intended for sidecar-style deployments where checks are copied into the directory expected by Wanda.

## Usage

The officially supported ways to run Trento are described at the [SUSE documentation website](https://documentation.suse.com/sles-sap/trento/html/SLES-SAP-trento/id-installation.html#). It covers the RPM and the Kubernetes-based deployments.

If you want to run Trento using containers, please refer to the Helm chart available at the [Trento Helm Charts](https://github.com/trento-project/helm-charts) repository. It is the supported way to run Trento using containers in a Kubernetes environment, as it takes care of all the necessary dependencies and configurations for you.

You can install the Trento Helm Chart using the following command:

```bash
helm upgrade \
   --install trento-server oci://registry.suse.com/trento/trento-server \
   --create-namespace \
   --namespace trento \
   --set global.trentoWeb.origin=YOUR_TRENTO_SERVER_HOSTNAME \
   --set trento-web.adminUser.password=YOUR_ADMIN_PASSWORD
```

### Using the container image directly

Running the container image directly is not the recommended way to run Trento and it is not supported by SUSE. It requires manual configuration of all dependencies and environment variables, including PostgreSQL and RabbitMQ.

If you still want to run Trento from the container image without Kubernetes, please refer to the [project documentation](https://www.trento-project.io/docs/developer/internal-notes/trento-container-install.html).

As a quick example, you can run the container image using the following command:

```bash
# Create a volume for the check
docker volume create trento-checks

# Run the container to copy the checks into the volume
docker run \
  --name trento-checks-installer \
  -v trento-checks:/usr/share/trento/checks \
  registry.suse.com/trento/trento-checks
```

After this step, start Wanda with the same volume mounted at `/usr/share/trento/checks`.

For development and checks authoring, see the repository README and Wanda guides:

- [Trento Checks README](https://github.com/trento-project/checks/blob/main/README.adoc)
- [Wanda checks specification](https://github.com/trento-project/wanda/blob/main/guides/specification.adoc)

## Licensing

`SPDX-License-Identifier: GPL-3.0-or-later`

This project is licensed under the GPL 3.0-or-later license. See the [LICENSE](https://github.com/trento-project/checks/blob/main/LICENSE) file for details.

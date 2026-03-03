# Trento Checks Container Image

## Description

This image contains the Trento Checks catalog and the `trento-install-checks` installer.

Trento Checks provide continuous infrastructure compliance through declarative YAML checks executed by [Wanda](https://github.com/trento-project/wanda).

The container is intended for sidecar-style deployments where checks are copied into the directory expected by Wanda.

## Usage

The container does not expose HTTP endpoints.

Its entrypoint runs:

```console
/usr/bin/trento-install-checks
```

The installer copies checks from `/usr/src/trento-checks/checks` to `/usr/share/trento/checks`.

Example (Docker volume shared with Wanda):

```console
docker volume create trento-checks

docker run --rm \
  --name trento-checks-installer \
  -v trento-checks:/usr/share/trento/checks \
  registry.suse.com/trento/trento-checks:latest
```

After this step, start Wanda with the same volume mounted at `/usr/share/trento/checks`.

For development and checks authoring, see the repository README and Wanda guides:

- [Trento Checks README](https://github.com/trento-project/checks/blob/main/README.adoc)
- [Wanda checks specification](https://github.com/trento-project/wanda/blob/main/guides/specification.adoc)

## Licensing

`SPDX-License-Identifier: GPL-3.0-or-later`

This project is licensed under the GPL 3.0-or-later license. See the [LICENSE](https://github.com/trento-project/checks/blob/main/LICENSE) file for details.

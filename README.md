# Trento Checks

Trento Checks are the way Trento provides continous infractructure compliance.

They are implemented with a declarative, YAML-based DSL aiming at expressing some expectations on the configuration of a target system, or a group of target systems.

The Checks are then executed by our Trento checks engine, [Wanda](https://github.com/trento-project/wanda).

## Usage

The Checks code was originally hosted together with Wanda itself and only later decoupled in this repository, so most of the related documentation will remain [there](https://github.com/trento-project/wanda/blob/main/guides/) until migrated somewhere else (if ever).

You can start learning more by consulting the [specification document](https://github.com/trento-project/wanda/blob/main/guides/specification.md)
# Developing Checks

Wanda architecture aims to simplify [testing Checks Executions](https://github.com/trento-project/wanda/blob/main/README.md#testing-executions) and [adding new ones](#adding-new-checks).

## Requirements

* [Make](https://www.gnu.org/software/make/manual/make.html)
* [Docker CLI](https://www.docker.com/products/cli/)
  * or [Podman](https://podman-desktop.io/docs/migrating-from-docker/managing-docker-compatibility) using the Docker compatibility feature
* [Asdf](https://asdf-vm.com/guide/getting-started.html)

## Setup

```sh
# add all rered plugins
asdf plugin add bats jq shellcheck shfmt
# install development software
asdf install
```

## Starting a local environment

Start the environment with:

```bash
$ docker-compose up -d
```

Wanda is exposed on port `4000` and the API documentation is available at http://localhost:4000/swaggerui

**Note** that the [message broker](https://www.rabbitmq.com/) **must** be reachable by Wanda and all the targets.

## Adding new Checks

Built-in Checks can be found in the Catalog directory at `./checks/`

To implement new checks and test them:

- write a new [Check Specification](https://github.com/trento-project/wanda/blob/main/guides/specification.md) file
- locate the newly created Check in the Catalog directory `./checks/`
- test the execution as [described in the check engine](https://github.com/trento-project/wanda/blob/main/README.md#testing-executions)

## Static code analysis

```sh
# run tlint on checks
# https://github.com/trento-project/tlint
make lint

# lint on shell scripts
make shellcheck

# format shell scripts and tests
make shfmt
```

## Tests

The `./test` folder contains the test suites for the checks catalog.

```sh
# Run tests against the local environment
make test

# Customize the environment URLs
WANDA_URL=http://wanda.example \
  FACTS_SERVICE_URL=amqp://user:pwd@rabbitmq.example:5672 \
  make test
```

### Write a test

Tests are written in `bash` scripting using the [Bats](https://bats-core.readthedocs.io/en/stable/) test framework. 

A test suite is a file with `.bats` extension and they should be named after the check that is the subject of the test (for example, `test/156F64.bats` contains the tests for the check `checks/156F64.yaml`).

Every `.bats` file under `./test` folder is executed.

The anatomy of a typical test is:
* an instance of Trento agent that simulates the exepcted behaviour is spinned-up with a known agent id;
* the instance must connect to the running development environment (Wanda and RabbitMQ);
* a check execution is requested to Wanda for the current check on the given agent id;
* the check result is requested to Wanda
* the check result is evaluated by the test script according to the expectations
* the Trento agent instance is tore down.

### Test fixtures

To simulate different Trento agent behaviours, a containerized version is provided by [Trento Barbecue](https://github.com/trento-project/barbecue), which defines file-based, ephemeral execution contexts for the Trento agent.

The `./test/fixtures` folder contains a folder for each scenario we want to test our checks against. 

To create a new fixture:
* create a folder named by the fixture;
* add all files to override the basic behavior;
* optionally, add a `setup.sh` script to run manual modification to the image at build time.


## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

See the [LICENSE](LICENSE) notice.

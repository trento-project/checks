# Trento Checks

Trento Checks are the way Trento provides continous infractructure compliance.

They are implemented with a declarative, YAML-based DSL aiming at expressing some expectations on the configuration of a target system, or a group of target systems.

The Checks are then executed by our Trento checks engine, [Wanda](https://github.com/trento-project/wanda).

## Usage

The Checks code was originally hosted together with Wanda itself and only later decoupled in this repository, so most of the related documentation will remain [there](https://github.com/trento-project/wanda/blob/main/guides/) until migrated somewhere else (if ever).

You can start learning more by consulting the [specification document](https://github.com/trento-project/wanda/blob/main/guides/specification.md).

# Developing Checks

Wanda architecture aims to simplify [testing Checks Executions](https://github.com/trento-project/wanda/blob/main/README.md#testing-executions) and [adding new ones](#adding-new-checks).

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

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md)

## License

See the [LICENSE](LICENSE) notice.

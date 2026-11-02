# Trento Checks

Trento Checks are the way Trento provides continuous infrastructure
compliance.

They are implemented with a declarative, YAML-based DSL aiming at
expressing some expectations on the configuration of a target system, or
a group of target systems.

The Checks are then executed by the Trento checks engine,
[Wanda](https://github.com/trento-project/wanda).

The Checks code was originally hosted together with Wanda itself and
only later decoupled in this repository, so most of the related
documentation will remain
[there](https://github.com/trento-project/wanda/blob/main/guides/) until
migrated somewhere else (if ever).

You can start learning more by consulting the [specification
document](https://github.com/trento-project/wanda/blob/main/guides/specification.adoc)

## Developing Checks

Wanda architecture aims to simplify [testing Checks
Executions](https://github.com/trento-project/wanda/blob/main/README.adoc#testing-executions)
and [adding new ones](#adding-new-checks).

## Guides
- **[Checks Specification] (https://github.com/trento-project/wanda/blob/main/guides/specification.adoc)** - General checks specification
- **[Expression Language] (https://github.com/trento-project/wanda/blob/main/guides/expression-language.adoc)** - the checks expression Language, it's a small, fast, easy-to-use scripting language and evaluation engine.
- **[Rhai expressions cheatsheet] (https://github.com/trento-project/wanda/blob/main/guides/rhai-expressions-cheat-sheet.cheat.adoc)** - most frequent manipulations that can be done through Rhai.
- **[Gatherers] (https://github.com/trento-project/wanda/blob/main/guides/gatherers.adoc)** - Gatherers can be thought of as functions that collect facts that used to passed to the checks as values to be evaluated or used for a specific evaluation.
- **[JSON Schema] (https://github.com/trento-project/wanda/blob/main/guides/check_definition.schema.json)** - Trento Check Definition Schema.


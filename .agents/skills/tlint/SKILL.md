---
name: lint
description: run tlint on checks # https://github.com/trento-project/tlint
Runs a basic syntax analysis on the check DSL
---

## An example of tlint execution.

```sh
docker run --rm -i -v ${PWD}:/data ghcr.io/trento-project/tlint:latest show /data/checks/790926.yaml
```


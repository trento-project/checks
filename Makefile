.PHONY: lint
lint:
	@echo "Running lint..."
	docker run -v .:/data --rm ghcr.io/trento-project/tlint:latest lint -f /data/checks

.PHONY: shellcheck
shellcheck:
	@echo "Running shellcheck..."
	shellcheck ./**/*.sh ./**/*.bats

.PHONY: fmt
fmt:
	@echo "Running shfmt..."
	shfmt -w -s -ci -bn ./**/*.sh ./**/*.bats

.PHONY: test
test:
	bats --verbose-run -x -r ./test
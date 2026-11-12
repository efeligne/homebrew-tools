.PHONY: setup install-all uninstall teardown sync audit install reinstall get_shasum list

TAP := efeligne/tools
TAP_PATH := $(shell brew --repository)/Library/Taps/efeligne/homebrew-tools
FORMULAE := $(patsubst Formula/%.rb,%,$(wildcard Formula/*.rb))

setup:
	@brew tap | grep -Fxq "$(TAP)" || brew tap-new --no-git "$(TAP)"
	@brew trust "$(TAP)"
	@$(MAKE) sync
	@$(MAKE) install-all

install-all: sync
	@set -e; for formula in $(FORMULAE); do \
		echo "==> Installing $$formula"; \
		brew install --build-from-source "$(TAP)/$$formula"; \
	done

uninstall:
	@set -e; for formula in $(FORMULAE); do \
		if brew list --formula "$$formula" >/dev/null 2>&1; then \
			echo "==> Uninstalling $$formula"; \
			brew uninstall "$$formula"; \
		fi; \
	done

teardown: uninstall clean

sync:
	@mkdir -p "$(TAP_PATH)/Formula"
	@cp Formula/*.rb "$(TAP_PATH)/Formula/"

audit: sync
	@set -e; for formula in $(FORMULAE); do \
		echo "==> Auditing $$formula"; \
		brew audit --strict --online "$(TAP)/$$formula"; \
	done

install: sync
	@test -n "$(FORMULA)" || (echo "Usage: make install FORMULA=name"; exit 1)
	brew install --build-from-source "$(TAP)/$(FORMULA)"

reinstall: sync
	@test -n "$(FORMULA)" || (echo "Usage: make reinstall FORMULA=name"; exit 1)
	brew reinstall --build-from-source "$(TAP)/$(FORMULA)"

get_shasum:
	@test -n "$(REPOSITORY)" || (echo "Usage: make get_shasum REPOSITORY=name VERSION=x.y.z"; exit 1)
	@test -n "$(VERSION)" || (echo "VERSION is required"; exit 1)
	@curl -sSL "https://github.com/efeligne/$(REPOSITORY)/archive/refs/tags/v$(VERSION).tar.gz" \
		| shasum -a 256 \
		| awk '{print "$(REPOSITORY) ($(VERSION)): " $$1}'

clean:
	@for formula in $(FORMULAE); do \
		rm -f "$(TAP_PATH)/Formula/$$formula.rb"; \
	done
	@rmdir "$(TAP_PATH)/Formula" 2>/dev/null || true

list:
	@printf '%s\n' $(FORMULAE)

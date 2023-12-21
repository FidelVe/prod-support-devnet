.PHONY: start

setup:
	@echo "> Make ICON nodes container.."
	# @cd ./goloop/ && make gochain-icon-image
	@echo "> Setup archway node.."
	@cd ./archway/ && make install

start:
	@echo "Checking archway git tags.."
	$(eval ARCHWAY_TAG := $(shell cd ./archway/ && git describe --tags --abbrev=0 2>/dev/null || echo "none"))
	@echo "latest tag: $(ARCHWAY_TAG)"
	@echo "> Run ARCHWAY node.."
	@cd ./archway/ && TAG=$(ARCHWAY_TAG) docker compose up -d
	@echo "> Run ICON nodes.."
	@cd ./gochain-local && docker compose -f compose-multi.yml up -d
	@echo "> Decentralize ICON nodes.."
	@cd ./gochain-local-decentralize && npm install && npm run start

stop:
	@echo "> Stop ICON Nodes.."
	@cd ./gochain-local && docker compose -f compose-multi.yml down
	@echo "> Stop archway Nodes.."
	@cd ./archway/ && docker compose down

force: ; # Empty recipe for dummy dependency

test:
	@ls
	@cd archway && ls

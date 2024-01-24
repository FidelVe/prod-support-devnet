.PHONY: start

setup:
	@echo "> Make ICON nodes container.."
	@cd ./goloop/ && make gochain-icon-image
	# @cd ./gochain-btp/ && git checkout devnet
	@echo "> Setup archway node.."
	# @cd ./archway/ && make install
	@echo "> Setup BSC node.."
	# @cp ./misc/docker-compose.yml-icon-bridge ./icon-bridge/devnet/docker-compose.yml && docker build --tag bsc-node ./icon-bridge/devnet/docker/bsc-node --build-arg KEYSTORE_PASS=Perlia0

start:
	# @echo "Checking archway git tags.."
	# $(eval ARCHWAY_TAG := $(shell cd ./archway/ && git describe --tags --abbrev=0 2>/dev/null || echo "none"))
	# @echo "latest tag: $(ARCHWAY_TAG)"
	# @echo "> Run ARCHWAY node.."
	# @cd ./archway/ && TAG=$(ARCHWAY_TAG) docker compose up -d
	@echo "> Run ICON nodes.."
	@cd ./gochain-btp && docker compose -f compose-multi.yml up -d
	@cd ./gochain-local-decentralize && npm install && npm run start
	# @echo "> Run BSC Nodes.."
	# @cd ./icon-bridge/devnet/ && docker compose -f docker-compose.yml up -d

stop:
	@echo "> Stop ICON Nodes.."
	@cd ./gochain-btp && docker compose -f compose-multi.yml down
	@echo "> Stop archway Nodes.."
	@cd ./archway/ && docker compose down
	@echo "> Stop BSC Nodes.."
	@cd ./icon-bridge/devnet && docker compose -f docker-compose.yml down

SHELL:=/usr/bin/env sh
UNAME := $(shell uname -m)
.PHONY: start

setup:
	@echo "> Make ICON nodes container.."
	@cd ./goloop/ && make gochain-icon-image
	@echo "> Setup archway node.."
	@cd ./archway/ && make install
	@echo "> Setup BSC node.."
	@cp ./misc/docker-compose.yml-icon-bridge ./icon-bridge/devnet/docker-compose.yml && docker build --tag bsc-node ./icon-bridge/devnet/docker/bsc-node --build-arg KEYSTORE_PASS=Perlia0
	# @cd ./bsc-docker && docker compose -f docker-compose.bsc.yml build && docker compose -f docker-compose.simple.bootstrap.yml build && docker compose -f docker-compose.simple.yml build --build-arg OS_ARCH=${UNAME}
	# @cd ./bsc-docker && docker compose -f docker-compose.simple.bootstrap.yml run bootstrap-simple

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
	@echo "> Run BSC Nodes.."
	@cd ./icon-bridge/devnet/ && docker compose -f docker-compose.yml up -d
	# @cd ./bsc-docker && docker compose -f docker-compose.simple.bootstrap.yml run bootstrap-simple
	# @cd ./bsc-docker && docker compose -f docker-compose.simple.yml up -d bsc-rpc bsc-validator1 netstats

stop:
	@echo "> Stop ICON Nodes.."
	@cd ./gochain-local && docker compose -f compose-multi.yml down
	@echo "> Stop archway Nodes.."
	@cd ./archway/ && docker compose down
	@echo "> Stop BSC Nodes.."
	@cd ./icon-bridge/devnet && docker compose -f docker-compose.yml down

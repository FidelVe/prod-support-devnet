# prod-support devnet

The following repo contains all the necessary items to setup the prod-support team devnet.

## Setup

Make sure you have the following installed in your server before running the Makefile commands:
* Docker and Docker compose
* Go
* Git
* GNU Make

For setting up the devnet on a new server follow this instructions:

* Clone the repo by running `git clone --recurse-submodules https://github.com/FidelVe/prod-support-devnet.git`
* Setup devnet by running `make setup`
* Start devnet by running `make start`

To stop the devnet run the command `make stop`

## Instructions for using nginx as a reverse proxy
TODO

## NOTES
* https://github.com/icon-project/btp2-deployment/blob/xcall-multi/deployment/README.md
* https://github.com/archway-network/archway/
* https://github.com/icon-project/lodestar
* https://github.com/icon-project/btp2
* https://github.com/izyak/icon-ibc
* https://github.com/icon-project/ibc-planning/discussions/281
* https://github.com/icon-project/btp2-deployment/tree/main

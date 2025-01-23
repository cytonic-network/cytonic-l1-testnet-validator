#!/bin/bash

CHAIN_HOME=/data
CHAIN_ID=cytonic_52225-1
RUN_NODE_COMMAND="docker compose exec"

$RUN_NODE_COMMAND node evmosd --chain-id $CHAIN_ID --home $CHAIN_HOME "$@"
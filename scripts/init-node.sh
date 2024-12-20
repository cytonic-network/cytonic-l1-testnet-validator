#!/bin/bash

SEED_NODES="7f4b8fdde3b6dc62f40cab3b18fd36b5e376729d@52.201.52.98:26656"

./scripts/run-node-command.sh node init $1
cp genesis.json data/config/

sed -i "s/seeds = \"\"/seeds = \"$SEED_NODES\"/" data/config/config.toml
sed -i "s/persistent_peers = \"\"/persistent_peers = \"$SEED_NODES\"/" data/config/config.toml
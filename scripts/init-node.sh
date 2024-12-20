#!/bin/bash

SEED_NODES="fc5163b624a95a9c3786248516ad4bd7cd1cfd5d@52.201.52.98:26000"

./scripts/run-node-command.sh node init $1
cp genesis.json data/config/

sed -i "s/seeds = \"\"/seeds = \"$SEED_NODES\"/" data/config/config.toml
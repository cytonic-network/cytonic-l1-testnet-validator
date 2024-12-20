#!/bin/sh

CHAIN_ID=cytonic_52225-1

evmosd --chain-id $CHAIN_ID --home /data "$@"
#!/bin/bash

RUN_NODE_COMMAND="docker compose run --no-deps --rm"

$RUN_NODE_COMMAND $1 "${@:2}"
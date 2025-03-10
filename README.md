# cytonic-l1-testnet-validator

Scripts for running new Cytonic L1 testnet validator.

## Seeds

- `7f4b8fdde3b6dc62f40cab3b18fd36b5e376729d@52.201.52.98:26656`

## 🚀 How to become validator

1. Initialize node using `scripts/init-node.sh <moniker>`
2. Set `[api]` module enabled in `data/config/app.toml`. This is important, because otherwise automatic gas estimation for tx sending won't work.
3. Add persistent peers (from [Seeds](#seeds) section) to the `data/config/config.toml`.
4. Generate or import key
    ```
    $ scripts/evmosd-run.sh keys add <key_name>
    ```
5. (optionally) Use state sync instead of full sync. Change `[statesync]` section in `config.toml` like this:
    ```toml
    [statesync]
    enable = true
    rpc_servers = "https://cometbft-rpc.sl.testnet.cytonic.com,https://cometbft-rpc-2.sl.testnet.cytonic.com"
    trust_height = <block height>
    trust_hash = "<block hash>"
    ```
    You can get correct block height and hash using these commands:
    ```sh
    LATEST_HEIGHT=$(curl -s $SNAP_RPC/block | jq -r .result.block.header.height); \
    BLOCK_HEIGHT=$((LATEST_HEIGHT - 40000)); \
    TRUST_HASH=$(curl -s "$SNAP_RPC/block?height=$BLOCK_HEIGHT" | jq -r .result.block_id.hash)
    echo $BLOCK_HEIGHT $TRUST_HASH
    ```

6. Start node using `docker compose up -d`
7. Send ETH you want to stake + some amount for fees to Ethereum address generated by shown mnemonic by running command from the 2nd step. You can use `scripts/evmosd-run.sh debug addr <address>` to get Ethereum address from `evmos` prefixed address.
8. Create validator json spec file at `data`. Example (you can get `pubkey` value using `scripts/evmosd-run.sh tendermint show-validator`):
    ```json
    {
        "pubkey": {"@type":"/cosmos.crypto.ed25519.PubKey","key":"+CwvJiaY1CGAyWRN8Gv24EJiBTQn2voJcU7yzbgZUkE="},
        "amount": "1000000000000000000aevmos", // 1 ETH
        "moniker": "node-e",
        "commission-rate": "0.1",
        "commission-max-rate": "0.5",
        "commission-max-change-rate": "0.1",
        "min-self-delegation": "1000000000000000000"
    }
    ```
9. Send tx with stake:
    ```
    $ scripts/evmosd-exec.sh tx staking create-validator /data/<validator_spec_file>.json --from <key_name> --gas auto --gas-prices 7aevmos
    ```
10. Wait a little bit so tx will be processed.
11. You are all set!

When staking, find out stake amount of the last validator in current validator set. Your stake amount should be greater than last validator amount. Alternatively, you can delegate your ETH to some existing validator.

## ❓ Troubleshooting

- If you have `rpc error: code = Unknown desc = unknown query path: unknown request` error when you are trying to send tx, and if you are using `--gas auto` flag - check that `[api]` module is enabled in `data/config/app.toml`, as it uses API server for determining sufficient amount of gas for transaction.

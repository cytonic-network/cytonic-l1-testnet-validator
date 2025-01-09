# cytonic-l1-testnet-validator

Scripts for running new Cytonic L1 testnet validator.

## Seeds

`7f4b8fdde3b6dc62f40cab3b18fd36b5e376729d@52.201.52.98:26656`

## How to become a validator 🚀

1. Initialize node using `scripts/init-node.sh <moniker>`. Set `[api]` module enabled in `data/config/app.toml`. Add seeds and persistent peers to the `data/config/config.toml`.
2. Generate or import key
    ```
    $ scripts/run-command.sh keys add <key_name>
    ```
3. Send ETH you want to stake + some amount for fees to Ethereum address generated by shown mnemonic by running command from the 2nd step.
4. Create validator json spec file at `data`. Example (you can get `pubkey` value using `scripts/run-command.sh tendermint show-validator`):
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
5. Send tx with stake:
    ```
    $ scripts/run-command.sh tx staking create-validator /data/<validator_spec_file>.json --from <key_name> --gas "auto" --gas-prices 25aevmos
    ```
6. Wait a little bit so tx will be processed.
7. You are all set!

When staking, find out stake amount of the last validator in current validator set. Your stake amount should be greater than last validator amount. Alternatively, you can delegate your ETH to some existing validator.

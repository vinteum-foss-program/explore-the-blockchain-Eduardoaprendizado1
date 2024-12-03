# Get source block tx array
block_hash=$(bitcoin-cli getblockhash 256128)
mapfile -t TxArrayBlock256728 < <(bitcoin-cli getblock "$block_hash" | jq -r '.tx[]')

# Get coinbase tx from source block
TxCoinbase=$(bitcoin-cli getrawtransaction "${TxArrayBlock256728[0]}" 2 | jq -r '.vin[].coinbase')

# Get target block tx array
target_block_hash=$(bitcoin-cli getblockhash 257343)
mapfile -t ToMatchTargetCoinbaseTxArray < <(bitcoin-cli getblock "$target_block_hash" | jq -r '.tx[]')

for tx in "${ToMatchTargetCoinbaseTxArray[@]}"; do
    mapfile -t TxPreVout < <(bitcoin-cli getrawtransaction "$tx" 2 | jq -r '.vin[].txid')

    for txid in "${TxPreVout[@]}"; do
        # Check txid length and skip if not 64 characters
        [[ ${#txid} -eq 64 ]] || continue

        TxToCompare=$(bitcoin-cli getrawtransaction "$txid" 2 | jq -r '.vin[].coinbase')

        if [[ "$TxToCompare" == "$TxCoinbase" ]]; then
            echo "$tx"
            break 2
        fi
    done
done

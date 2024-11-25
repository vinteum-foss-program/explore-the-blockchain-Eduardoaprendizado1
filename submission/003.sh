# How many new outputs were created by block 123,456?
BLOCKHASH=$(bitcoin-cli getblockhash 123456)
BLOCK=$(bitcoin-cli getblock $BLOCKHASH 2)
OUTPUT_COUNT=$(echo $BLOCK | jq '[.tx[].vout | length] | add')
echo $OUTPUT_COUNT

# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
PUBKEYS=$(bitcoin-cli getrawtransaction "37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517" 2 | jq '[.vin[].txinwitness[1]]')
ADDRESS=$(bitcoin-cli createmultisig 1 "$PUBKEYS" | jq -r '.address')
echo $ADDRESS

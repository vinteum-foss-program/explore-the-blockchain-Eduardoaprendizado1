# Using descriptors, compute the taproot address at index 100 derived from this extended public key:
#   `xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2`
XPUB="xpub6Cx5tvq6nACSLJdra1A6WjqTo1SgeUZRFqsX5ysEtVBMwhCCRa4kfgFqaT2o1kwL3esB1PsYr3CUdfRZYfLHJunNWUABKftK2NjHUtzDms2"
BASIC_DESC="tr($XPUB/100)"
DESC_INFO=$(bitcoin-cli getdescriptorinfo "$BASIC_DESC")
CHECKSUM=$(echo $DESC_INFO | jq -r '.checksum')
FULL_DESC="$BASIC_DESC#$CHECKSUM"
bitcoin-cli deriveaddresses "$FULL_DESC" | jq -r 'if type == "array" then .[0] else . end'



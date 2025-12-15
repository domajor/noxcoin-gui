#!/bin/bash

# Rename all occurrences of NoxCoin to NoxCoin
find . -type f -exec sed -i \
    -e 's/noxcoin/noxcoin/g' \
    -e 's/NoxCoin/NoxCoin/g' \
    -e 's/NOXCOIN/NOXCOIN/g' \
    -e 's/NXC/NXC/g' \
    {} +

# Rename binary names
find src -type f -exec sed -i \
    -e 's/noxcoind/noxcoind/g' \
    -e 's/noxcoin-wallet-gui/noxcoin-wallet-gui/g' \
    -e 's/noxcoin-wallet-rpc/noxcoin-wallet-rpc/g' \
    {} +

# Update default ports
find . -type f -exec sed -i \
    -e 's/19890/19890/g' \
    -e 's/19009/19009/g' \
    -e 's/19891/19891/g' \
    {} +

echo "✔ All NoxCoin GUI modifications applied."


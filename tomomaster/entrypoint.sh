#!/bin/sh
MNEMONIC_FILE="mnemonic_tomomaster"
MNEMONIC_PATH="/run/secrets/$PASSWORD_FILE"

sed -i -e "s/:mnemonic:/$(cat $MNEMONIC_PATH)/g" local.json
echo $(cat $MNEMONIC_PATH)

mv local.json config

truffle migrate --compile-all --reset development

mv TomoValidator.json build/contracts/TomoValidator.json
mv TomoRandomize.json build/contracts/TomoRandomize.json
mv BlockSigner.json build/contracts/BlockSigner.json

npm run build

npm run dev

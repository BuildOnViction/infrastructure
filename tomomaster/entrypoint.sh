#!/bin/sh
MNEMONIC_FILE="mnemonic_tomomaster"
MNEMONIC_PATH="/run/secrets/$PASSWORD_FILE"

sed -i -e "s/:mnemonic:/$(cat $MNEMONIC_PATH)/g" local.json
echo $(cat $MNEMONIC_PATH)

mv local.json config
npm run build
mv TomoValidator.json build/contracts
mv TomoRandomize.json build/contracts
mv BlockSigner.json build/contracts

npm run dev

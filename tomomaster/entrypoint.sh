#!/bin/sh

if [[ -z $MNEMONIC_FILE ]]; then
  export MNEMONIC=$(cat $MNEMONIC_FILE)
fi

mv local.json config

truffle migrate --compile-all --reset development

mv TomoValidator.json build/contracts/TomoValidator.json
mv TomoRandomize.json build/contracts/TomoRandomize.json
mv BlockSigner.json build/contracts/BlockSigner.json

npm run build

npm run dev

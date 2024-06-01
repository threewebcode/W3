#!/usr/bin/env bash

function gas(){
  curl --location --request POST 'https://faucet.devnet.sui.io/gas' \
  --header 'Content-Type: application/json' \
  --data-raw '{
      "FixedAmountRequest": {
          "recipient": "0xab3f0954b08398daf834df97bf4e38e0fff0b40452e6a80be6acdf073d3aa330"
      }
  }'
}

function publish(){
  sui client publish --gas-budget 10000000000 --skip-fetch-latest-git-deps
}

PACKAGE=0xf4c82b3145d5eed01d1b1a9e9b367ba937968ec7804359897fe2df80197e8efb

sui client call \
  --function get \
  --module devnet \
  --package "$PACKAGE" \
  --gas-budget 1000000000 --json

function call(){

}

$@



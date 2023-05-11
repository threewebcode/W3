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
  sui client publish --gas-budget 30000
}

PACKAGE=

function call(){

}

$@



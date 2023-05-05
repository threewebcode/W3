#!/usr/bin/env bash

function key(){
    ssh-keygen -C threewebcode
    cat ~/.ssh/id_rsa.pub
}

function ssh(){
    cp ssh/* ~/.ssh/
}

function git(){
  echo $1
  cd $1
  git config --local user.name threewebcode
  git config --local user.email magestore@outlook.com
}

function create_tsp(){
    npm init typescript-project;
    npx typescript-starter;
}

function sui(){
  #curl -sLO  https://github.com/MystenLabs/sui/releases/download/devnet-0.33.0/sui
  curl -sLO https://github.com/MystenLabs/sui/releases/download/sui-v1.0.0/sui
  chmod +x sui
  mv sui $(dirname $(which cargo))
  which sui  
}

$@

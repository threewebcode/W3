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

$@

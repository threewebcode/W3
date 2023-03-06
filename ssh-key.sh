#!/usr/bin/env bash

ssh-keygen -C threewebcode
cat ~/.ssh/id_rsa.pub

git config --local user.name threewebcode
git config --local user.email magestore@outlook.com

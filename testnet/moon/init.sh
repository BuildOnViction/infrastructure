#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ tomochain ]\n"

echo "New account password for node 'moon': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_moon -
echo "Existing private key for node 'moon': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_moon -

clear
echo -e "\n[ review ]\n"
docker secret list

#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ tomochain ]\n"

echo "New account password for node 'earth': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_earth -
echo "Existing private key for node 'earth': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_earth -

clear
echo -e "\n[ review ]\n"
docker secret list

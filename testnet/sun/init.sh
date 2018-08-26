#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ tomochain ]\n"

echo "New account password for node 'sun': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_sun -
echo "Existing private key for node 'sun': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_sun -

clear
echo -e "\n[ review ]\n"
docker secret list

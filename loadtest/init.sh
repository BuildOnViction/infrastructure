#!/bin/bash

echo "Please fill the following required values:"


echo -e "\n[ netstats ]\n"

echo "New Netstats websocket secret ('WS_SECRET'): "
unset input && read -s input \
; echo $input | docker secret create netstats_ws_secret -

echo -e "\n[ tomochain ]\n"

echo "New account password for node 'sun': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_sun -
echo "Existing private key for node 'sun': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_sun -
echo "New account password for node 'moon': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_moon -
echo "Existing private key for node 'moon': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_moon -
echo "New account password for node 'earth': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_earth -
echo "Existing private key for node 'earth': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_earth -

clear
echo -e "\n[ review ]\n"
docker secret list

#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ netstats ]\n"

echo "New Netstats websocket secret ('WS_SECRET'): "
unset input && read -s input \
; echo $input | docker secret create netstats_ws_secret -

echo -e "\n[ tomoscan ]\n"

echo "Existing Sendgrid api key: "
unset input && read -s input \
; echo $input | docker secret create sendgrid_api_key -
echo "Existing Recaptcha secret: "
unset input && read -s input \
; echo $input | docker secret create re_captcha_secret -
echo "Existing jwt secret: "
unset input && read -s input \
; echo $input | docker secret create scan_jwt_secret -
echo "Existing app secret: "
unset input && read -s input \
; echo $input | docker secret create scan_app_secret -
echo "Existing slack webhook url: "
unset input && read -s input \
; echo $input | docker secret create slack_webhook_url -

echo -e "\n[ tomochain ]\n"

echo "New account password for node 'tomochain01': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_tomochain01 -
echo "Existing private key for node 'tomochain01': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_tomochain01 -
echo "New account password for node 'tomochain02': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_tomochain02 -
echo "Existing private key for node 'tomochain02': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_tomochain02 -
echo "New account password for node 'tomochain03': "
unset input && read -s input \
; echo $input | docker secret create tomochain_password_tomochain03 -
echo "Existing private key for node 'tomochain03': "
unset input && read -s input \
; echo $input | docker secret create tomochain_pk_tomochain03 -

echo -e "\n[ loadbalancer ]\n"

echo "Creating internal masternode lb conf"
docker secret create nginx_conf_blockchain-proxy "./res/blockchain-proxy/nginx.conf"

clear
echo -e "\n[ review ]\n"
docker secret list

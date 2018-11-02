#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ metrics ]\n"

echo "New Grafana db password: "
unset input && read -s input \
; echo $input | docker secret create metrics_gf_database_password - \
; echo $input | docker secret create metrics_postgres_password -
echo "New Grafana admin password: "
unset input && read -s input \
; echo $input | docker secret create metrics_gf_security_admin_password -

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

echo -e "\n[ proxy ]\n"

echo "Certificate pem file (path): "
unset input && read input \
; docker secret create proxy_cert_pem "${input}"
echo "Certificate private key file (path): "
unset input && read input \
; docker secret create proxy_cert_private_key "${input}"

clear
echo -e "\n[ review ]\n"
docker secret list

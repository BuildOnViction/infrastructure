#!/bin/bash

echo "Please fill the following required values:"

echo -e "\n[ graylog ]\n"

echo "New Greylog salt (password secret): "
unset input && read -s input \
; echo $input | docker secret create graylog_password_secret -
echo "New Greylog root (admin) password: "
unset input && read -s input \
; echo $input \
| tr -d '\n' | shasum -a 256 2> /dev/null | cut -d' ' -f1 | docker secret create graylog_root_password_sha2 -

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

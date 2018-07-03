#!/bin/bash

echo "Enter masternode sun private key"
read -s input1; echo $input1 > ./deploy/secrets/key_sun.secret
echo "Enter masternode earth private key"
read -s input2; echo $input2 > ./deploy/secrets/key_earth.secret
echo "Enter masternode moon private key"
read -s input3; echo $input3 > ./deploy/secrets/key_moon.secret
echo "Enter masternode sun account password"
read -s input5; echo $input5 > ./deploy/secrets/password_sun.secret
echo "Enter masternode earth account password"
read -s input6; echo $input6 > ./deploy/secrets/password_earth.secret
echo "Enter masternode moon account password"
read -s input7; echo $input7 > ./deploy/secrets/password_moon.secret
echo "Enter account wallet mnemonic"
read -s input4; echo $input4 > ./deploy/secrets/mnemonic_tomomaster.secret

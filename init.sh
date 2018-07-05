#!/bin/bash
TEMPLATE_PATH="deploy/.config_template"
CONFIG_PATH="deploy/config"

echo "Creating config folder from $(pwd)/$TEMPLATE_PATH."
echo "Please edit empty values in $(pwd)/$CONFIG_PATH"
rm -rf $CONFIG_PATH
cp -r $TEMPLATE_PATH $CONFIG_PATH

#!/bin/bash

# Make the prompt useful
/usr/bin/echo "export NICKNAME=${nickname}" > /etc/profile.d/prompt.sh
/bin/sed -i -e 's/\\h/$NICKNAME/g' /etc/bashrc

# Update packages
dnf update -y --allowerasing

# Shutdown the instance after a few hours
shutdown +300

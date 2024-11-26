#!/bin/bash
set -e

# Enable password authentication
sed -i --regexp-extended 's/#?PasswordAuthentication (yes|no)/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i --regexp-extended 's/#?Include \/etc\/ssh\/sshd_config.d\/\*.conf/#Include \/etc\/ssh\/sshd_config.d\/\*.conf/' /etc/ssh/sshd_config
sed -i 's/KbdInteractiveAuthentication no/KbdInteractiveAuthentication yes/' /etc/ssh/sshd_config
systemctl reload sshd  # Use reload instead of restart

# Setup .ssh directory
if [ ! -d /home/vagrant/.ssh ]; then
    mkdir /home/vagrant/.ssh
    chmod 700 /home/vagrant/.ssh
    chown vagrant:vagrant /home/vagrant/.ssh
fi

# Install sshpass on controlplane01
if [ "$(hostname)" = "controlplane01" ]; then
    export DEBIAN_FRONTEND=noninteractive
    sudo apt update -y && sudo apt install -y sshpass
fi

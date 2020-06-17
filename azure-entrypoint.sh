#!/bin/bash

# Install required packages
apt update && apt install build-essential -y 2>>error # Not installing 'ubuntu-desktop'

# Blacklist nouveau drivers
cat >> /etc/modprobe.d/nouveau.conf <<EOT
blacklist nouveau
blacklist lbm-nouveau
EOT

# Set up GRID drivers
wget -O NVIDIA-Linux-x86_64-grid.run https://go.microsoft.com/fwlink/?linkid=874272
chmod u+x NVIDIA-Linux-x86_64-grid.run
./NVIDIA-Linux-x86_64-grid.run -s>>error
cp /etc/nvidia/gridd.conf.template /etc/nvidia/gridd.conf
sed -e "\$aIgnoreSP=FALSE" /etc/nvidia/gridd.conf

# Install Hashcat
wget https://hashcat.net/files/hashcat-6.0.0.tar.gz
tar -xf hashcat-6.0.0.tar.gz
cd hashcat-6.0.0
make && make install

# Install John the Ripper
snap install john-the-ripper
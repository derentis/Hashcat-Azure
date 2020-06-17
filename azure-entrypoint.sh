#!/bin/bash

# Install required packages
apt update && apt install build-essential -y 2>>error # Not installing 'ubuntu-desktop'

# Blacklist nouveau drivers
cat >> /etc/modprobe.d/nouveau.conf <<EOT
blacklist nouveau
blacklist lbm-nouveau
EOT

# Install GRID driver
# wget https://storage.googleapis.com/nvidia-drivers-us-public/GRID/GRID10.2/NVIDIA-Linux-x86_64-440.87-grid.run
# sh NVIDIA-Linux-x86_64-440.87-grid.run -s>>error
# cp /etc/nvidia/gridd.conf.template /etc/nvidia/gridd.conf
# sed -e "\$aIgnoreSP=FALSE" /etc/nvidia/gridd.conf

# Install CUDA driver & toolkit
wget http://developer.download.nvidia.com/compute/cuda/11.0.1/local_installers/cuda_11.0.1_450.36.06_linux.run
sh cuda_11.0.1_450.36.06_linux.run --driver --toolkit --silent>>error

# Install Hashcat
wget https://hashcat.net/files/hashcat-6.0.0.tar.gz
tar -xf hashcat-6.0.0.tar.gz
cd hashcat-6.0.0
make && make install

# Install John the Ripper
snap install john-the-ripper
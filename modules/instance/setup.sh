#!/bin/sh

# Go to the home directory
cd ~

#--------------------------------------------------------------------
# System Packages

# Update apt
sudo apt-get -y update

# Install some packages
sudo apt install -y htop unzip

#--------------------------------------------------------------------
# Fast.ai Course Data

# Download the data
wget https://github.com/fastai/courses/archive/master.zip
unzip -q master.zip

# Copy the notebooks
mv courses-master/deeplearning1/nbs/* nbs/

# Remove the old data
rm -rf courses-master/
rm master.zip

#!/bin/sh

# Go to the home directory
cd ~

# Update apt
sudo apt-get -y update

# Install unzip
sudo apt install -y unzip

# Download the data
wget https://github.com/fastai/courses/archive/master.zip
unzip master.zip

# Copy the notebooks
mv courses-master/deeplearning1/nbs/* nbs/

# Remove the old data
rm -rf courses-master/
rm master.zip

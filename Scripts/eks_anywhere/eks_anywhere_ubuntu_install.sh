#!/bin/bash

# This Script is a bare-metal installation of EKS-Anywhere that should be run on a vm with the following image: Ubuntu Focal 20.04 (LTS)

# ----------------------------------------------------------- #
### Docker ###
# Installation of Docker Engine for Ubuntu can be found on the following link: https://docs.docker.com/engine/install/ubuntu/

# Do NOT obtain state of superuser (root) for this following portion of the script
# Set up the repository
# installing necessary packages needed before usingrepo
sudo apt-get update
sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Add Docker's official GPG key
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

# Setting up the repo
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null


# Install Docker Engine
# Update the apt package index
sudo apt-get update

# Install Docker Engine, containerd, and Docker Compose (Latest Versions)
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin

# Verify that Docker runs correctly
sudo docker run hello-world

# ----------------------------------------------------------- #
# Installation of Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
test -r ~/.bash_profile && echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bash_profile
echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.profile

sudo apt-get install build-essential procps curl file git

# ----------------------------------------------------------- #
# EKS Anywhere Installation with Homebrew
brew install aws/tap/eks-anywhere

# Install eksctl (latest)
curl "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" \
    --silent --location \
    | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin/

# Install eksctl-anywhere plugin 
export EKSA_RELEASE="0.12.2" OS="$(uname -s | tr A-Z a-z)" RELEASE_NUMBER=24
curl "https://anywhere-assets.eks.amazonaws.com/releases/eks-a/${RELEASE_NUMBER}/artifacts/eks-a/v${EKSA_RELEASE}/${OS}/amd64/eksctl-anywhere-v${EKSA_RELEASE}-${OS}-amd64.tar.gz" \
    --silent --location \
    | tar xz ./eksctl-anywhere
sudo mv ./eksctl-anywhere /usr/local/bin/

# Upgrade eksctl-anywhere 
brew update
brew upgrade eks-anywhere

# Verify Installation with the following command:
eksctl anywhere version


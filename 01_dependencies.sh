#!/usr/bin/env bash

echo "Updating package manager database..."
sudo apt update

# -----------------------------------------------------------------------------
echo "Installing base dependencies..."
sudo apt-get install -y unzip zip
sudo apt-get install bash-completion


# -----------------------------------------------------------------------------
echo "Installing docker..."
sudo snap install docker
# TODO wait for the daemon to be up
sleep 2
sudo chmod 666 /var/run/docker.sock

# # Install packages to allow apt to use a repository over HTTPS
# sudo apt-get install \
#     apt-transport-https \
#     ca-certificates \
#     curl \
#     software-properties-common

# # Add Docker’s official GPG key
# curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# # Use the following command to set up the stable repository
# sudo add-apt-repository \
#    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
#    $(lsb_release -cs) \
#    stable"


# sudo apt-get update
# sudo apt-get install docker-ce
# sudo docker run hello-world

# -----------------------------------------------------------------------------
echo "Installing go..."
sudo snap install --classic go

# -----------------------------------------------------------------------------
echo "Installing gcloud sdk..."

# Create an environment variable for the correct distribution
export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

# Add the Cloud SDK distribution URI as a package source
echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Import the Google Cloud Platform public key
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

# Update the package list and install the Cloud SDK
sudo apt-get update && sudo apt-get install -y google-cloud-sdk


# -----------------------------------------------------------------------------
echo "Installing kubectl..."
sudo snap install --classic kubectl
mkdir ~/.kube || true
touch ~/.kube/config

# -----------------------------------------------------------------------------
echo "Installing minikube..."
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.22.2/minikube-linux-amd64 && chmod +x minikube && sudo mv minikube /usr/local/bin/
# export MINIKUBE_WANTUPDATENOTIFICATION=false
# export MINIKUBE_WANTREPORTERRORPROMPT=false
# export MINIKUBE_HOME=$HOME
# export CHANGE_MINIKUBE_NONE_USER=true

# -----------------------------------------------------------------------------
echo "Installing helm..."
sudo snap install --classic helm
mkdir -p ~/snap/helm/common || true
ln -s ~/.kube ~/snap/helm/common/kube
helm init --client-only

# ------------------------------
# apps



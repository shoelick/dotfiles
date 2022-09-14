#!/usr/bin/env bash
sudo apt install -y build-essential
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt update && sudo apt upgrade -y
sudo apt install -y python3.9 python3.9-dev python3.9-venv
python3.9 -m ensurepip --default-pip --user


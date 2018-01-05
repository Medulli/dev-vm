#!/bin/bash

echo "Starting command: $0"

if [ "$#" -ne 2 ] || [ ! -d "$1" ]; then
    echo "Error: $0 [home folder path] [username]";
	echo "Exiting command: $0"
else
	home_folder=$1
	#Add / at the end if not present
	[[ $home_folder != *\/ ]] && home_folder+="/"

	username=$2

	#Uncomment if not done in vagrantfile
	#apt-get update

	locale-gen fr_FR.UTF-8
	locale-gen sv_SE.UTF-8
	locale-gen ca_FR.UTF-8

	#update-locale LANG=fr_FR.UTF-8

	apt-get install -y alsa-utils wget tar libevent-dev libncurses-dev xclip

	##tmux
	VERSION=2.5
	apt-get -y remove tmux

	wget https://github.com/tmux/tmux/releases/download/${VERSION}/tmux-${VERSION}.tar.gz
	sleep 2
	tar xf tmux-${VERSION}.tar.gz
	sleep 2
	rm -f tmux-${VERSION}.tar.gz
	cd tmux-${VERSION}
	./configure
	make
	make install
	cd -
	sleep 2
	rm -rf /usr/local/src/tmux-*
	mv tmux-${VERSION} /usr/local/src

	##Docker
	curl -fsSL get.docker.com > $home_folder".get-docker.sh"
	sleep 2
	sh $home_folder".get-docker.sh"
	usermod -aG docker $username

	apt-get install -y python3 python3-pip python3-dev python-dev python3-tk
	pip3 install --upgrade pip
	pip3 install numpy scipy matplotlib ipython jupyter pandas sympy nose scikit-learn tensorflow Pillow

fi

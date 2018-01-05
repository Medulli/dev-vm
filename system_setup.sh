#!/bin/bash

echo "Starting command: $0"

if [ "$#" -ne 3 ] || [ ! -d "$1" ] || [ ! -d "$2" ]; then
    echo "Error: $0 [provision folder path] [home folder path] [username]";
	echo "Exiting command: $0"
else
	provision_folder=$1
	#Add / at the end if not present
	[[ $provision_folder != *\/ ]] && provision_folder+="/"

	home_folder=$2
	#Add / at the end if not present
	[[ $home_folder != *\/ ]] && home_folder+="/"

	username=$3

	### For ros
	#add-apt-repository "deb http://archive.ubuntu.com/ubuntu trusty main universe restricted multiverse"
	#sh -c 'echo "deb http://packages.ros.org/ros/ubuntu trusty main" > /etc/apt/sources.list.d/ros-latest.list'
	#wget https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -O - | apt-key add -

	apt-get install -y git dos2unix
	git config --global core.autocrlf input

	### For g++
	apt-get install -y build-essential cmake software-properties-common python3-software-properties python-software-properties

	### VBox, X and awesome
	apt-get install -y xorg virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
	add-apt-repository ppa:klaus-vormweg/awesome -y
	apt-get update
	apt-get install -y awesome

	VBoxClient --display
	VBoxClient --draganddrop
	VBoxClient --seamless
	VBoxClient --clipboard

	cp /etc/X11/xinit/xinitrc $home_folder".xinitrc"
	chown $username:$username $home_folder".xinitrc"
	echo "xrdb "$home_folder".Xresources" > $home_folder".xinitrc"
	echo "exec awesome" >> $home_folder".xinitrc"

	#lightdm
	apt-get install -y lightdm lightdm-gtk-greeter

	# Awesome wm config
	mkdir -p $home_folder".config/awesome/lain/"
	mkdir -p $home_folder".config/awesome/freedesktop/"
	mkdir -p $home_folder".config/awesome/themes/"

	git clone https://github.com/lcpz/lain.git $home_folder".config/awesome/lain/"
	git clone https://github.com/lcpz/awesome-freedesktop.git $home_folder".config/awesome/freedesktop/"

	cp -r $provision_folder"medulli_awesome_theme/" $home_folder".config/awesome/themes/medulli/"
	cp $provision_folder"awesome_rc.lua" $home_folder".config/awesome/rc.lua"

	#Restablish ownership of config files
	chown -R $username:$username $home_folder".config/"
	dos2unix $home_folder".config/awesome/rc.lua"

	#echo 'Section "InputClass" Identifier "keyboard" MatchIsKeyboard "yes" Option "XkbLayout" "fr" Option "XkbVariant" "nodeadkeys" EndSection' >> /etc/X11/xorg.conf.d/20-keyboard.conf

	### ros itself
	#apt-get install -y ros-indigo-desktop-full
	#rosdep init
	#su $username -l -c 'rosdep update'
	#echo "source /opt/ros/indigo/setup.bash" >> $home_folder".bashrc"

	#apt-get install -y python-rosinstall

	### To set the keyboard layout
	apt-get install -y x11-xkb-utils

	echo "Windowmanager-autostart will be available after restart."

fi

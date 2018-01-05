#!/bin/bash

echo "Starting command: $0"

if [ "$#" -lt 2 ] || [ ! -d "$1" ]; then
    echo "Error: $0 [home folder path] [username] [opt:prefix]";
	echo "Exiting command: $0"
else
	home_folder=$1
	#Add / at the end if not present
	[[ $home_folder != *\/ ]] && home_folder+="/"

	username=$2

	#Uncomment if not done in vagrantfile
	#apt-get update

	rm -f /etc/fonts/conf.d/70-no-bitmaps.con
	mkdir -p $home_folder"/.config/fontconfig/"

	# Set source directory
	powerline_fonts_dir=$home_folder"fonts/"

	# clone
	git clone https://github.com/powerline/fonts.git $powerline_fonts_dir
	sleep 5

	mkdir -p $home_folder"/.config/fontconfig/"
	cp $powerline_fonts_dir"fontconfig/50-enable-terminess-powerline.conf" $home_folder"/.config/fontconfig/conf.d"
	#Restablish ownership of config files
	chown -R $username:$username $home_folder".config/"

	# Set target directory
	# if an argument is given it is used to select which fonts to install
	prefix="$3"

	find_command="find \"$powerline_fonts_dir\" \( -wholename '$prefix*.[o,t]tf' -or -name '$prefix*.pcf.gz' \) -type f -print0"

	font_dir="/usr/share/fonts/powerline/"
	mkdir -p $font_dir

	# Copy all fonts to user fonts directory
	echo "Copying fonts..."
	eval $find_command | xargs -0 -n1 -I % cp "%" "$font_dir/"

	# Reset font cache on Linux
	if command -v fc-cache @>/dev/null ; then
		echo "Resetting font cache, this may take a moment..."
		sleep 2
		fc-cache -fv $font_dir
	fi

	echo "Powerline fonts installed to $font_dir"

	# clean-up a bit
	sleep 2
	rm -rf $home_folder"fonts/"

	#fc-list | cut -f2 -d: | sort -u

fi

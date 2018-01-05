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

	cp $provision_folder".vimrc" $home_folder".vimrc"
	cp $provision_folder".tmux.conf" $home_folder".tmux.conf"
	cp $provision_folder".Xresources" $home_folder".Xresources"
	cp $provision_folder".zshrc" $home_folder".zshrc"
	cp $provision_folder".gruvbox-palette.sh" $home_folder".gruvbox-palette.sh"
	cp $provision_folder".ycm_extra_conf.py" $home_folder".ycm_extra_conf.py"
	cp $provision_folder".zsh_history_substring_search.zsh" $home_folder".zsh_history_substring_search.zsh"
	cp $provision_folder".completion.zsh" $home_folder".completion.zsh"
	chown -R $username:$username $home_folder
fi

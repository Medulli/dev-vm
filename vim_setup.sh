#!/bin/bash

echo "Starting command: $0"

if [ "$#" -ne 2 ] || [ ! -d "$1" ]; then
    echo "Error: $0 [home folder path] [username]";
	echo "Exiting command: $0"
else

	##Uncomment if not done in vagrantfile
	##apt-get update

	home_folder=$1
	#Add / at the end if not present
	[[ $home_folder != *\/ ]] && home_folder+="/"

	username=$2

	apt-get remove -y --purge vim vim-runtime vim-gnome vim-tiny vim-gui-common vim-nox-py2

	apt-get install -y liblua5.1-dev luajit libluajit-5.1 python-dev python3-dev ruby-dev libperl-dev libncurses5-dev libatk1.0-dev libx11-dev libxpm-dev libxt-dev

	#So vim can be uninstalled again via `dpkg -r vim`
	apt-get install -y checkinstall

	rm -rf /usr/local/share/vim /usr/bin/vim
	sleep 5

	cd $home_folder
	git clone https://github.com/vim/vim
	cd $home_folder"vim"
	git pull && git fetch

	#In case Vim was already installed
	cd src
	make distclean
	cd ..

	./configure \
	--enable-multibyte \
	--enable-perlinterp=dynamic \
	--enable-rubyinterp=dynamic \
	--with-ruby-command=/usr/bin/ruby \
	--enable-pythoninterp=dynamic \
	--with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
	--enable-python3interp \
	--with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
	--enable-luainterp \
	--with-luajit \
	--enable-cscope \
	--enable-gui=auto \
	--with-features=huge \
	--with-x \
	--enable-fontset \
	--enable-largefile \
	--disable-netbeans \
	--with-compiledby="medulli" \
	--enable-fail-if-missing

	make && make install
	sleep 10

	##Pathogen
	mkdir -p $home_folder".vim/autoload" $home_folder".vim/bundle" && \
	curl -LSso $home_folder".vim/autoload/pathogen.vim" https://tpo.pe/pathogen.vim

	##Omnisharp
	apt-get install -y mono-complete

	cd $home_folder".vim/bundle" && \
	git clone https://github.com/OmniSharp/omnisharp-vim.git
	cd omnisharp-vim
	git submodule update --init --recursive
	cd server
	export NoCompilerStandardLib=false
	xbuild

	##YouCompleteMe
	git clone https://github.com/valloric/YouCompleteMe.git $home_folder".vim/bundle/YouCompleteMe"
	cd $home_folder".vim/bundle/YouCompleteMe"
	##Git might be a dick and fail here. Re-update until no error
	git submodule update --init --recursive
	python3 install.py --clang-completer --omnisharp-completer
	sleep 5
	#Custom file handled with dotfiles
	#cp $home_folder".vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py" $home_folder".ycm_extra_conf.py"

	##Dispatch (for omnisharp)
	git clone git://github.com/tpope/vim-dispatch.git $home_folder".vim/bundle/dispatch"

	##Syntastic
	git clone --depth=1 https://github.com/scrooloose/syntastic.git $home_folder".vim/bundle/synthastic"

	##CtrlP
	git clone https://github.com/ctrlpvim/ctrlp.vim.git $home_folder".vim/bundle/ctrlp"

	##vim-csharp
	git clone git://github.com/OrangeT/vim-csharp.git $home_folder".vim/bundle/csharp"

	##tmuxline
	##git clone https://github.com/edkolev/tmuxline.vim $home_folder".vim/bundle/tmuxline"

	##a (.c <-> .h)
	##git clone https://github.com/vim-scripts/a.vim $home_folder".vim/bundle/a"

	##nerdcommenter
	git clone https://github.com/scrooloose/nerdcommenter.git $home_folder".vim/bundle/nerdcommenter"

	##nerdtree
	git clone https://github.com/scrooloose/nerdtree.git $home_folder".vim/bundle/nerdtree"

	##easymotion
	git clone https://github.com/easymotion/vim-easymotion $home_folder".vim/bundle/easymotion"

	##ack - ack in searches
	#_git clone https://github.com/mileszs/ack.vim.git $home_folder".vim/bundle/ack"

	##airline
	git clone https://github.com/vim-airline/vim-airline $home_folder".vim/bundle/airline"
	##vim -u NONE -c ":helptags $home_folder'.vim/bundle/vim-airline/doc'" -c q

	##gitgutter
	git clone git://github.com/airblade/vim-gitgutter.git $home_folder".vim/bundle/gitgutter"

	##fugitive
	git clone git://github.com/tpope/vim-fugitive.git $home_folder".vim/bundle/fugitive"
	##vim -u NONE -c "helptags $home_folder'.vim/bundle/vim-fugitive/doc'" -c q

	##colors-solarized
	##git clone git://github.com/altercation/vim-colors-solarized.git $home_folder".vim/bundle/colors-solarized"

	##colors-gruvbox
	git clone https://github.com/morhetz/gruvbox.git $home_folder".vim/bundle/gruvbox"

	##tabline
	git clone git://github.com/mkitt/tabline.vim.git $home_folder".vim/bundle/tabline"

	##abolish - spell check
	##git clone git://github.com/tpope/vim-abolish.git $home_folder".vim/bundle/abolish"

	##tabular
	#_git clone git://github.com/godlygeek/tabular.git $home_folder".vim/bundle/tabular"

	##visual-star-search
	##git clone https://github.com/nelstrom/vim-visual-star-search $home_folder".vim/bundle/visual-star-search"

	##Re-establish ownership of config files
	chown -R $username:$username $home_folder".vim"
	dos2unix $home_folder".vimrc"

fi

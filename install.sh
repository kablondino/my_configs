#!/bin/bash
# Hard link ZSH config file
if [ -e ~/.zshrc ]; then
	echo "Moving old .dircolors file to ~/.dircolors.bak"
	mv ~/.zshrc ~/.zshrc.bak
	echo "Hard linking new .dircolors"
	ln ./.zshrc ~/.zshrc
else
	echo "Hard linking new .dircolors"
	ln ./.zshrc ~/.zshrc
fi
#echo "Hard linking .zshrc"
#ln ./.zshrc ~/.zshrc

# Hard link dircolors file
if [ -e ~/.dircolors ]; then
	echo "Moving old .dircolors file to ~/.dircolors.bak"
	mv ~/.dircolors ~/.dircolors.bak
	echo "Hard linking new .dircolors"
	ln ./.dircolors ~/.dircolors
else
	echo "Hard linking new .dircolors"
	ln ./.dircolors ~/.dircolors
fi
#echo "Hard linking new .dircolors"
#ln ./.dircolors ~/.dircolors

# Hard link VIM config file
if [ -e ~/.vimrc ]; then
	echo "Moving old .vimrc file to ~/.vimrc.bak"
	mv ~/.vimrc ~/.vimrc.bak
	echo "Hard linking new .vimrc"
	ln ./vim_configs/.vimrc ~/.vimrc
else
	echo "Hard linking new .vimrc"
	ln ./vim_configs/.vimrc ~/.vimrc
fi
#echo "Hard linking new .vimrc"
#ln ./vim_configs/.vimrc ~/.vimrc

# Make .vim directory and link colors
echo "Creating or checking ~/.vim directory and subdirectories"
if [ ! -d ~/.vim/colors ]; then
	if [ ! -d ~/.vim ]; then
		mkdir ~/.vim/
	fi
	mkdir ~/.vim/colors/
fi

if [ -e ~/.vim/colors/swagdino.vim ]; then
	echo "Moving old swagdino.vim colorscheme to swagdino.vim.bak"
	mv ~/.vim/colors/swagdino.vim ~/.vim/colors/swagdino.vim.bak
	echo "Linking swagdino.vim colorscheme"
	ln ./vim_configs/swagdino.vim ~/.vim/colors/swagdino.vim
else
	echo "Linking swagdino.vim colorscheme"
	ln ./vim_configs/swagdino.vim ~/.vim/colors/swagdino.vim
fi
#echo "Linking swagdino.vim colorscheme"
#ln ./vim_configs/swagdino.vim ~/.vim/colors/swagdino.vim

if [ -e ~/.vim/colors/swagdino_pencil.vim ]; then
	echo "Moving old swagdino_pencil.vim colorscheme to swagdino_pencil.vim.bak"
	mv ~/.vim/colors/swagdino_pencil.vim ~/.vim/colors/swagdino_pencil.vim.bak
	echo "Linking swagdino_pencil.vim colorscheme"
	ln ./vim_configs/swagdino_pencil.vim ~/.vim/colors/swagdino_pencil.vim
else
	echo "Linking swagdino_pencil.vim colorscheme"
	ln ./vim_configs/swagdino_pencil.vim ~/.vim/colors/swagdino_pencil.vim
fi
#echo "Linking swagdino_pencil.vim colorscheme"
#ln ./vim_configs/swagdino_pencil.vim ~/.vim/colors/swagdino_pencil.vim

# Vundle Install
if [ ! -e ~/.vim/bundle/Vundle.vim ]; then
	git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Check for tmux
if [ -e ~/.tmux.conf ]; then
	echo "Moving old .tmux.conf file to ~/.tmux.conf.bak"
	mv ~/.tmux.conf ~/.tmux.conf.bak
	echo "Hard linking new .tmux.conf"
	ln ./.tmux.conf ~/.tmux.conf
else
	echo "Hard linking new .dircolors"
	ln ./.tmux.conf ~/.tmux.conf
fi
#echo "Linking .tmux.conf"
#ln ./.tmux.conf ~/.tmux.conf

if [ -e ~/.tmux.conf.local ]; then
	echo "Moving old .tmux.conf.local file to ~/.tmux.conf.local.bak"
	mv ~/.tmux.conf.local ~/.tmux.conf.local.bak
	echo "Hard linking new .tmux.conf.local"
	ln ./.tmux.conf.local ~/.tmux.conf.local
else
	echo "Hard linking new .dircolors"
	ln ./.tmux.conf.local ~/.tmux.conf.local
fi
#echo "Linking .tmux.conf.local"
#ln ./.tmux.conf.local ~/.tmux.conf.local

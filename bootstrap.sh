#!/bin/sh

cd $(dirname "$0")
PWD=$(pwd)

###
#CREATE DIRECTORY ENVIROMENT
###
	mkdir -p "$HOME"
	mkdir -p "$HOME/tmp"
	mkdir -p "$HOME/docs"
	mkdir -p "$HOME/var/music"
	mkdir -p "$HOME/var/pictures"
	mkdir -p "$HOME/var/videos"
###

###
#CHECK FOR MISSING COMMANDS
###
	for p in wmctrl xprop xdotool ls++ zathura xboomx xbacklight amixer gm scrot; do
		if ! type "$p" &> /dev/null; then
			echo "$p is missing... That will break stuff"
		fi
	done

	if ! fc-list | fgrep -q gohufont; then
		echo "gohufont is missing... That will break the ReqSpec O.O"
	fi
###

###
#CONFIG FILES
###
	#XRESOURCES
	ln -sf "$PWD/Xresources"  "$HOME/.Xresources"
	type -f "$PWD/Xresources_extra" &> /dev/null && ln -sf "$PWD/Xresources_extra"  "$HOME/.Xresources_extra"

	#BASHRC
	ln -sf "$PWD/bash.rc"  "$HOME/.bashrc"

	#PROFILE
	ln -sf "$PWD/profile"  "$HOME/.profile"

 	#INPUTRC
	ln -sf "$PWD/input.rc"  "$HOME/.inputrc"

	#NANORC
	#ln -sf "$PWD/nano.rc"  "$HOME/.nanorc"

	#SPECTRWM
	ln -sf "$PWD/spectrwm.rc"  "$HOME/.spectrwm.conf"
	ln -sf "$PWD/spectrwm_de.rc"  "$HOME/.spectrwm_de.conf"

	#XBINDKEYSRC
	ln -sf "$PWD/xbindkeys.rc"  "$HOME/.xbindkeysrc"

	#XINITRC
	ln -sf "$PWD/xinit.rc"  "$HOME/.xinitrc"

	#ZSH
	ln -sf "$PWD/zsh.rc"  "$HOME/.zshrc"

	#EMACS
	mkdir "$HOME/.emacs.d" 2> /dev/null
	ln -sf "$PWD/emacs.rc" "$HOME/.emacs.d/init.el"

	#NCMPCPP
	mkdir "$HOME/.ncmpcpp" 2> /dev/null
	ln -sf "$PWD/ncmpcpp.rc" "$HOME/.ncmpcpp/config"

	#XBOOMX
	mkdir "$HOME/.xboomx" 2> /dev/null
	ln -sf "$PWD/dmenu/xboomx.rc" "$HOME/.xboomx/config"

	#TODO.SH
	mkdir "$HOME/.todo" 2> /dev/null
	ln -sf "$PWD/todo.rc" "$HOME/.todo/config"

	#COMPTON
	ln -sf "$PWD/compton.rc" "$HOME/.compton.conf"

	#GIT
	ln -sf "$PWD/git.rc" "$HOME/.gitconfig"

	#SUBLIME TEST 3
	mkdir -p "$HOME/.config/sublime-text-3/Packages/User" 2> /dev/null
	ln -sf "$PWD/Preferences.sublime-settings" "$HOME/.config/sublime-text-3/Packages/User/"
###

###
#SCRIPTS and COMMANDS
###
	mkdir "$HOME/bin" 2> /dev/null
	ln -sf "$PWD/commands/slimlock_wrapper" "$HOME/bin"
	ln -sf "$PWD/commands/rofi_run" "$HOME/bin"
	ln -sf "$PWD/commands/rofi_ssh" "$HOME/bin"
###

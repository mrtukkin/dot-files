#Various Stuff
###
setopt NOTIFY
#cd without the command
setopt AUTO_CD
unsetopt beep
#setopt NO_CLOBBER
setopt no_hup
setopt no_check_jobs

#HISTORY
###
	HISTFILE=~/.histfile
	HISTSIZE=5000
	SAVEHIST=50000
	#Immediatly append to histfile
	setopt inc_append_history
	#Ignore commands with leading space
	setopt hist_ignore_space
	#Ignore ALL dups
	setopt hist_ignore_all_dups
	#Don't store the history command
	setopt hist_no_store
	#Save more information in histfile
	setopt extended_history
	[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
	[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward
###


#Prompt
###
	fpath=( "$HOME/etc/pure_zsh" $fpath )
	autoload -U promptinit && promptinit
	prompt pure
###

#Keybindings
###
	# Use emacs-style keybindings
	bindkey -e
	bindkey "$terminfo[khome]" beginning-of-line # Home
	bindkey "$terminfo[kend]" end-of-line # End
	bindkey "$terminfo[kich1]" overwrite-mode # Insert
	bindkey "$terminfo[kdch1]" delete-char # Delete
	bindkey "$terminfo[kcuu1]" up-line-or-history # Up
	bindkey "$terminfo[kcud1]" down-line-or-history # Down
	bindkey "$terminfo[kcub1]" backward-char # Left
	bindkey "$terminfo[kcuf1]" forward-char # Right
	# bindkey "$terminfo[kpp]" # PageUp
	# bindkey "$terminfo[knp]" # PageDown
	# Bind ctrl-left / ctrl-right
	bindkey "\e[1;5D" backward-word
	bindkey "\e[1;5C" forward-word
###

#Completition
###
	autoload -U compinit
	compinit
	#View Aliases as normal commands
	setopt complete_aliases
	#Complete in both directions
	setopt complete_in_word
	#ext. Regex in complt.
	setopt extended_glob
	#Send no err. Message when pattern has no result
	unsetopt no_match
	#Use Menu compl. after second press
	#setopt auto_menu
	#Make globbing (filename generation) sensitive to case
	unsetopt CASE_GLOB
	#Required for git plugin
	setopt prompt_subst
	#Use fish like highlighting
	source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

	#completion system
	###
		zstyle ':completion::complete:*'       use-cache on
		zstyle ':completion::complete:*'       cache-path "$HOME/.zcache"

    # allow one error for every three characters typed in approximate completer
    zstyle ':completion:*:approximate:'    max-errors 'reply=( $((($#PREFIX+$#SUFFIX)/3 )) numeric )'

    # don't complete backup files as executables
    zstyle ':completion:*:complete:-command-::commands' ignored-patterns '(aptitude-*|*\~)'

    # start menu completion only if it could find no unambiguous initial string
    zstyle ':completion:*:correct:*'       insert-unambiguous true
    zstyle ':completion:*:corrections'     format $'%{\e[0;31m%}%d (errors: %e)%{\e[0m%}'
    zstyle ':completion:*:correct:*'       original true

    # activate color-completion
    zstyle ':completion:*:default'         list-colors ${(s.:.)LS_COLORS}

    # format on completion
    zstyle ':completion:*:descriptions'    format $'%{\e[0;31m%}completing %B%d%b%{\e[0m%}'

    # complete 'cd -<tab>' with menu
    zstyle ':completion:*:*:cd:*:directory-stack' menu yes select

    # insert all expansions for expand completer
    zstyle ':completion:*:expand:*'        tag-order all-expansions
    zstyle ':completion:*:history-words'   list false

    # activate menu
    zstyle ':completion:*:history-words'   menu yes

    # ignore duplicate entries
    zstyle ':completion:*:history-words'   remove-all-dups yes
    zstyle ':completion:*:history-words'   stop yes

    # match uppercase from lowercase
    #zstyle ':completion:*'                 matcher-list 'm:{a-z}={A-Z}'
    zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

    # separate matches into groups
    zstyle ':completion:*:matches'         group 'yes'
    zstyle ':completion:*'                 group-name ''

    # if there are more than 2 options allow selecting from a menu
    zstyle ':completion:*'                 menu select=2
		zstyle ":completion:*"                 menu select=long

    zstyle ':completion:*:messages'        format '%d'
    zstyle ':completion:*:options'         auto-description '%d'

    # describe options in full
    zstyle ':completion:*:options'         description 'yes'

    # on processes completion complete all user processes
    zstyle ':completion:*:processes'       command 'ps -au$USER'

    # offer indexes before parameters in subscripts
    zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

    # provide verbose completion information
    zstyle ':completion:*'                 verbose true

    # recent (as of Dec 2007) zsh versions are able to provide descriptions
    # for commands (read: 1st word in the line) that it will list for the user
    # to choose from. The following disables that, because it's not exactly fast.
    zstyle ':completion:*:-command-:*:'    verbose false

    # set format for warnings
    zstyle ':completion:*:warnings'        format $'%{\e[0;31m%}No matches for:%{\e[0m%} %d'

    # define files to ignore for zcompile
    zstyle ':completion:*:*:zcompile:*'    ignored-patterns '(*~|*.zwc)'
    zstyle ':completion:correct:'          prompt 'correct to: %e'

    # Ignore completion functions for commands you don't have:
    zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'

    # Provide more processes in completion of programs like killall:
    zstyle ':completion:*:processes-names' command 'ps c -u ${USER} -o command | uniq'

    # complete manual by their section
    zstyle ':completion:*:manuals'    separate-sections true
    zstyle ':completion:*:manuals.*'  insert-sections   true
    zstyle ':completion:*:man:*'      menu yes select

    # provide .. as a completion
    zstyle ':completion:*' special-dirs ..
	###
###

#Alias definitions
###
	source ~/etc/.alias
	if [ -e ~/etc/.alias_private ]; then
		source ~/etc/.alias_private
	fi
###

# typing ... expands to ../.., .... to ../../.., etc.
rationalise-dot() {
	if [[ $LBUFFER = *.. ]]; then
		LBUFFER+=/..
	else
		LBUFFER+=.
	fi
}
zle -N rationalise-dot
bindkey . rationalise-dot
bindkey -M isearch . self-insert # history search fix

# Git plugin
autoload -Uz vcs_info
zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:(git*):*" get-revision true
zstyle ":vcs_info:(git*):*" check-for-changes true

local _branch="%c%u%m %{$fg[green]%}%b%{$reset_color%}"
local _repo="%{$fg[green]%}%r %{$fg[yellow]%}%{$reset_color%}"
local _revision="%{$fg[yellow]%}%.7i%{$reset_color%}"
local _action="%{$fg[red]%}%a%{$reset_color%}"
zstyle ":vcs_info:*" stagedstr "%{$fg[yellow]%}✓%{$reset_color%}"
zstyle ":vcs_info:*" unstagedstr "%{$fg[red]%}✗%{$reset_color%}"
zstyle ":vcs_info:git*" formats "$_branch:$_revision - $_repo"
zstyle ":vcs_info:git*" actionformats "$_branch:$_revision:$_action - $_repo"
zstyle ':vcs_info:git*+set-message:*' hooks git-stash

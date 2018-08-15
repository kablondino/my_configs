#  ███████╗██╗    ██╗ █████╗  ██████╗ ██████╗ ██╗███╗   ██╗ ██████╗ 
#  ██╔════╝██║    ██║██╔══██╗██╔════╝ ██╔══██╗██║████╗  ██║██╔═══██╗
#  ███████╗██║ █╗ ██║███████║██║  ███╗██║  ██║██║██╔██╗ ██║██║   ██║
#  ╚════██║██║███╗██║██╔══██║██║   ██║██║  ██║██║██║╚██╗██║██║   ██║
#  ███████║╚███╔███╔╝██║  ██║╚██████╔╝██████╔╝██║██║ ╚████║╚██████╔╝
#  ╚══════╝ ╚══╝╚══╝ ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝ 
#                                                                   
#  ███████╗███████╗██╗  ██╗██████╗  ██████╗                         
#  ╚══███╔╝██╔════╝██║  ██║██╔══██╗██╔════╝                         
#    ███╔╝ ███████╗███████║██████╔╝██║                              
#   ███╔╝  ╚════██║██╔══██║██╔══██╗██║                              
#  ███████╗███████║██║  ██║██║  ██║╚██████╗                         
#  ╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝                         


# HOW TO RUN ZSH SETUP AGAIN!
#	autoload -Uz zsh-newuser-install
#	zsh-newuser-install -f

# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory autocd notify

# Vim mode!
bindkey -v

# Proper backspace and delete keys
bindkey "^?" backward-delete-char
bindkey "[3~" delete-char


zstyle :compinstall filename '$HOME/.zshrc'

# Autocomplete
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
#zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

# Default text editor
export EDITOR=$(which vim)
export VISUAL=$(which vim)

# Timeout for keyboard
export KEYTIMEOUT=1

# Set the TERM so that italics and color are available, even in TMUX
export TERM=xterm-256color

# Load the source file for git prompt thing
#source ~/zsh-git-prompt/zshrc.sh

# Prompt customization
autoload -Uz promptinit
autoload -U colors && colors
autoload -Uz vcs_info
precmd() { vcs_info }

# Format the vcs_info_msg_0_ variable
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*' actionformats "%s  %r/%S %b %m%u%c "

promptinit

# ------------ Set up some variables for prompt --------------

local PR_USER PR_USER_OP PR_PROMPT PR_HOST

setopt PROMPT_SUBST

# Powerline colors
#vim_cmd_mode="%{[01;38;5;022;48;5;148m%} NORMAL %{[00;38;5;148m%}%k%f"
#vim_ins_mode="%{[01;38;5;031;48;5;015m%} INSERT %{[00;38;5;015m%}%k%f"
#vim_vis_mode="%{[01;38;5;088;48;5;208m%} VISUAL %{[00;38;5;208m%}%k%f"

# Landscape colors
vim_cmd_mode="%{[01;38;5;012;48;5;015m%} NORMAL %{[00;38;5;015m%}%k%f"
vim_ins_mode="%{[01;38;5;022;48;5;015m%} INSERT %{[00;38;5;015m%}%k%f"
vim_vis_mode="%{[01;38;5;057;48;5;015m%} VISUAL %{[00;38;5;015m%}%k%f"

# Deus colors
vim_cmd_mode="%{[01;38;5;000;48;5;114m%} NORMAL %{[00;38;5;114m%}%k%f"
vim_ins_mode="%{[01;38;5;000;48;5;039m%} INSERT %{[00;38;5;039m%}%k%f"
vim_vis_mode="%{[01;38;5;000;48;5;170m%} VISUAL %{[00;38;5;170m%}%k%f"


vim_mode=$vim_ins_mode

function zle-keymap-select {
	vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
	zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
	vim_mode=${vim_ins_mode}
}
zle -N zle-line-finish

# Check the UID
if [[ $UID -ne 0 ]]; then # normal user
	PR_USER="%{[00;38;5;022m%}%{[00;38;5;000;48;5;022m%} %n "	# HOST corrects colors
	PR_USER_OP='%F{green}%#%f'
	PR_PROMPT='${vim_mode} '
else # root
	PR_USER='%F{blue}%n%f '
	PR_USER_OP='%F{blue}%#%f'
	PR_PROMPT='${vim_mode} '
fi

# Check if we are on SSH or not
if [[ -n "$SSH_CLIENT"  ||  -n "$SSH2_CLIENT" ]]; then
	PR_HOST='%{[00;38;5;036;48;5;022m%}%{[00;38;5;032;48;5;036m%} %{[00;38;5;000;48;5;032m%} %M%k%f' # SSH
else
	PR_HOST='%{[00;38;5;107;48;5;022m%}%{[00;38;5;148;48;5;107m%} %{[00;38;5;000;48;5;148m%} %M%k%f' # no SSH
fi

local display_time="%{[00;38;5;000;48;5;204m%}%*%{[00;38;5;204;48;5;170m%} "
local current_dir="%{[01;48;5;097;38;5;000m%} %~%b%{[00;38;5;097m%}%f%k"

local return_code="%(?..%{[00;38;5;088m%}%{[00;38;5;000;48;5;088m%} %? %{[00;38;5;088m%}%f%k)"	# U+F112
local user_host="${PR_USER}${PR_HOST}"

# TWO LINE PROMPT
PROMPT="${display_time}%{[01;38;5;170;48;5;097m%}${current_dir}
$PR_PROMPT"
#╰─
# CHROME OS and crouton do not like the right prompt!
RPROMPT="${return_code}${user_host}"

# REFRESH prompt every X seconds:
#TMOUT=2; TRAPALRM() { zle reset-prompt }

# Directory and file colors
test -r ~/.dircolors && eval "$(dircolors $HOME/.dircolors)"

# Unset SSH_ASKPASS
unset SSH_ASKPASS

## Aliases
alias ls='ls --color=auto'		# Always use color
alias ll='ls -lh'				# Human-readable for detailed list
alias la='ls -A'
alias sl='sl -e'
alias quit='exit'
alias tmux='tmux -2'
alias less='less -R'
alias mv='mv -i'				# Confirm move if overwriting

# ANACONDA
export PATH="/home/kabv/miniconda2/bin:$PATH"

# Graduation Project directory
alias grad_proj='cd ~/Documents/Masters/Graduation_Project/ && git status'
alias thesis='cd ~/Documents/Masters/Graduation_Project/Thesis/ && ls'

# Activate FiPy
alias fipy='cd $HOME/Documents/Masters/Graduation_Project/FiPy_Model && source activate fipy'


# Open urxvt-256color on the display 0, for use in WSL
alias x11_urxvt='DISPLAY=:0 urxvt-256color'

# Make the permissions on new files default to 755, for use in WSL
umask 022


## FUNCTIONS!
# Delete each line in a file that starts with a NON-number(digit) character
function data_clean() {
	grep "^[0-9]" $1 > $2
}

# Insert a # on the first line of each TSV file in the current directory
#function comment_TSV() { sed -i '1s/^/\#/' *.tsv }

# urlencode some text
function urlencode {
	print "${${(j: :)@}//(#b)(?)/%$[[##16]##${match[1]}]}"
}

# open a web browser on google for a query
function google {
	xdg-open "https://www.google.com/search?q=`urlencode "${(j: :)@}"`"
}

# print a separator banner as wide as the terminal
function hr {
	print ${(l:COLUMNS::=:)}
}

# display a list of supported colors
function lscolors {
	((cols = $COLUMNS - 4))
	s=$(printf %${cols}s)
	for i in {000..$(tput colors)}; do
		echo -e $i $(tput setaf $i; tput setab $i)${s// /=}$(tput op);
	done
}

# Explain command, requires curl and internet
explain () {
	if [ "$#" -eq 0 ]; then
		while read  -p "Command: " cmd; do
			curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$cmd"
		done
		echo "Bye!"

	elif [ "$#" -eq 1 ]; then
		curl -Gs "https://www.mankier.com/api/explain/?cols="$(tput cols) --data-urlencode "q=$1"

	else
		echo "Usage"
		echo "explain                  interactive mode."
		echo "explain 'cmd -o | ...'   one quoted command to explain it."
	fi
}


#neofetch <- SLOW on OpenSUSE
fortune
echo -n "Current Shell: "; echo -n "ZSH "; echo $ZSH_VERSION


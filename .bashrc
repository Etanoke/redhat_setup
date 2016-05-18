alias vi='vim'
alias view='vim -R'
alias ls='ls --color=auto'
alias l='ls -l'
alias ll='ls -l'
alias la='ls -la'

export EDITOR="vim"

# paste this to ~/.bashrc
<< __COMMENT_OUT__
file=$HOME"/redhat_setup/.bashrc"
if [ -f $file ]; then
	. $file
fi
__COMMENT_OUT__
# Clear "Last login" information	
# printf '\33c\e[3J'

eval "$(/opt/homebrew/bin/brew shellenv)"

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	macos
	ripgrep
	rust
	docker
	gh
	brew
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

alias vim='nvim'
alias ls='lsd'
alias python='python3'
alias pip='pip3'
alias mrpython='python3 ~/Documents/Université/MrPython/mrpython/Application.py'

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/opt/homebrew/opt/libpcap/bin:$PATH"

# Add GNU Make to path
export PATH="/opt/homebrew/opt/make/libexec/gnubin:$PATH"

# bun completions
[ -s "/Users/boubli/.bun/_bun" ] && source "/Users/boubli/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Secretive Config
export SSH_AUTH_SOCK=/Users/boubli/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh

# mysqlclient
export PATH="/opt/homebrew/opt/mysql-client/bin:$PATH"
# libpq
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"

. "$HOME/.cargo/env"


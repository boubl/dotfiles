# ==== boubli's .zshrc ==== #

OS=$(uname -s)

# ==== zsh and omz ==== #
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
	git
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

# ==== things to sort ==== #
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. "$HOME/.cargo/env"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/boubli/.local/bin

# ==== macOS related configuration ==== #
if [[ $OS = Darwin ]]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
	
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
fi



# ==== Aliases ==== #
alias vim='nvim'
alias ls='lsd'
alias python='python3'
alias pip='pip3'


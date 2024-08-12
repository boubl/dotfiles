# ==== boubli's .zshrc ==== #

OS=$(uname -s)

# ==== zsh and omz ==== #
export ZSH="$HOME/.oh-my-zsh"
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
	zsh-history-substring-search
	eza
)
source $ZSH/oh-my-zsh.sh

GEOMETRY_STATUS_SYMBOL="🍌"             # default prompt symbol

source /opt/homebrew/opt/geometry/share/geometry/geometry.zsh

# ==== things to sort ==== #
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
. "$HOME/.cargo/env"
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/boubli/.local/bin
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

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

# ==== Cursor moves ==== #
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word


# ==== Aliases ==== #
alias vim='nvim'
alias python='python3'
alias pip='pip3'


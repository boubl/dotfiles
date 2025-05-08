if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -x GOPATH (go env GOPATH)
set -x -a PATH (go env GOPATH)/bin

# bun
set -x BUN_INSTALL "$HOME/.bun"
set -x -a PATH $BUN_INSTALL/bin

# zigup
set -x ZIGUP_INSTALL "$HOME/zig"
set -x -a PATH $ZIGUP_INSTALL/

# Homebrew settings
set -x HOMEBREW_NO_ENV_HINTS 1

# Zoxide
zoxide init fish | source
alias cd=z

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
# test -r '/Users/boubli/.opam/opam-init/init.fish' && source '/Users/boubli/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration

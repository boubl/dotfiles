if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Homebrew settings
set -x HOMEBREW_NO_ENV_HINTS 1
set -x GSK_RENDERER ngl

# Zoxide
zoxide init fish | source
alias cd=z

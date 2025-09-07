if status is-interactive
    # Commands to run in interactive sessions can go here
    # set ZELLIJ_AUTO_ATTACH true
    # set ZELLIJ_AUTO_EXIT true
    # eval (zellij setup --generate-auto-start fish | string collect)

    # Starship
    starship init fish | source

    # Zoxide
    zoxide init fish | source
    alias cd=z
end

# Homebrew settings
set -x HOMEBREW_NO_ENV_HINTS 1

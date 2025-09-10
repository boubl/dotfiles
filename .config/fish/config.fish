function fish_greeting
    fastfetch
end

if status is-interactive
    # Starship
    starship init fish | source

    # Zoxide
    zoxide init fish | source
    alias cd=z
end

# Homebrew settings
set -x HOMEBREW_NO_ENV_HINTS 1

function fish_greeting
    fastfetch
end

if status is-interactive
    # Starship
    starship init fish | source

    # Bat
    bat --completion fish | source
    alias cat=bat
    set -x MANPAGER "sh -c 'awk '\''{ gsub(/\x1B\[[0-9;]*m/, \"\", \$0); gsub(/.\x08/, \"\", \$0); print }'\'' | bat -p -lman'"

    # Zoxide
    zoxide init fish | source
    alias cd=z

    fish_vi_key_bindings
end

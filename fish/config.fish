if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Disable startup message
set fish_greeting

# Better looking ls command
alias ls="lsd"

# Zoxide for smard cd
zoxide init fish | source
alias cd="z"

# Rebind nvim to vim
alias vim="nvim"

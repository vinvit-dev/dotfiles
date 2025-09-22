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

# Some git aliases 
alias gs="git status"
alias gl="git log --oneline --graph"
alias gaa="git add ."
alias gm="git merge"
alias gpu="git pull"
alias gpp="git push"
alias gco="git commit"
alias gcm="git commit -m"

# fzf alias to open file in nvim
alias f='nvim "$(fzf)"'

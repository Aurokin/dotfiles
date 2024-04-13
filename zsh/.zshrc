# Auro's ZSH Config
# Requires Installing
# - Pure (https://github.com/sindresorhus/pure)

# Pure
fpath+=($HOME/.zsh/pure)
autoload -U promptinit; promptinit
prompt pure

# Terminal
export TERM=xterm-256color

# NVim
export EDITOR=nvim
export VISUAL=nvim

# Git
export GIT_EDITOR=nvim

# Tree
export LS_COLORS=true

# Nix
export NIXPKGS_ALLOW_UNFREE=1

# LANG
export JDTLS_ENABLED=false;
if [[ $OSTYPE == *"darwin"* ]]; then
    # OSX
    user=`id -un`
    export OS="darwin";
    export GLOBAL_NODE_MODULES="/opt/homebrew/lib/node_modules"
    export PATH="/Users/$user/.nix-profile/bin:$PATH"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
    export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"
    export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
else
    export OS="unix"
    export JDTLS_DIR="/usr/local/lib/jdtls"
    export GLOBAL_NODE_MODULES="/usr/lib/node_modules" 
    export PATH="/opt/swift/usr/bin:$PATH"
    export PATH="/nix/var/nix/profiles/default/bin:$PATH"
    export PATH="/home/$user/.nix-profile/bin:$PATH"
fi

# Set Aliases
alias c="clear"
alias lsl="eza -l"
alias lsa="eza -la"
alias lsz="eza"
alias ga="git add ."
alias gc="git commit"
alias gs="git status"
alias gd="git diff"
alias gp="git push"
alias gcb="git checkout \$(git branch | fzf)"
alias rr="rm -rf"
alias tmt="source ~/.zsh_scripts/tmux-twigs.sh"
alias zshrd="source ~/.zshrc"

# Bat Tokyo Night
export BAT_THEME="tokyonight_night"

# FZF Tokyo Night
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
--color=fg:#c0caf5,bg:#1a1b26,hl:#ff9e64 \
--color=fg+:#c0caf5,bg+:#292e42,hl+:#ff9e64 \
--color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
--color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# FZF CD Alias
# Hidden Folders are also an issue
# For below to work we need to filter out library files or others we don't have perms to
alias fd="cd \$(find /home /Users ~ ~/downloads ~/workspace ~/Downloads ~/roms ~/notes ~/code ~/images -mindepth 1 -maxdepth 1 -type d | fzf) && clear"
alias fcd="cd \$(find * -type d | fzf)"
# alias frd="cd / && cd \$(find * -typed | fzf)"

bindkey -s ^t "tmt\n"
bindkey -s ^k "tmt k\n"
# Load Local Alias
# If File Exists
PC_NAME=$(uname -n)
if [[ $PC_NAME == "barry" ]]; then
    source /home/auro/.barry.zsh  
fi

# Zoxide
eval "$(zoxide init zsh)"

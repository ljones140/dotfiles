# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export EDITOR='vim'

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME='geometry/geometry'
export PROMPT_GEOMETRY_COLORIZE_SYMBOL=true
export PROMPT_GEOMETRY_COLORIZE_ROOT=true
export PROMPT_GEOMETRY_EXEC_TIME=true

# Base16 Shell
# BASE16_SHELL=$HOME/.config/base16-shell/
# [ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

#plugins
plugins=(
  alias-finder
  bundler
  copyfile
  copypath
  docker
  docker-compose
  git
  npm
  ruby
  zsh-autosuggestions
  zsh-history-substring-search
  zsh-syntax-highlighting
)
export ZSH_ALIAS_FINDER_AUTOMATIC=true

# ensure dotfiles bin directory is loaded first
PATH="$HOME/.bin:/usr/local/sbin:$PATH:$HOME/bin"

# https://github.com/ajeetdsouza/zoxide
# z smart cd
eval "$(zoxide init zsh)"

export -U PATH

source $ZSH/oh-my-zsh.sh

#speed up escape in vim
# 10ms for key sequences
KEYTIMEOUT=1

ssh-add -A &> /dev/null
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gk='gitk --all&'
alias gx='gitx --all'
alias tas='tmux attach-session -t'

# Alias ls to exa
# fancy alternative to ls
alias ls='exa --git --icons --color=always --group-directories-first'

# banked github
alias cicd-deploy-dev='gh workflow run deployment.yaml -F environment=development -r $(git symbolic-ref --short HEAD)'

# decode JWTs
jwt-decode() {
  jq -R 'split(".") |.[0:2] | map(@base64d) | map(fromjson)' <<< $1
}
# iterm shell intergration
source ~/.iterm2_shell_integration.zsh

# ripgrep
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export PATH="/usr/local/opt/libpq/bin:$PATH"

# zsh history substeing search with remaps
bindkey '^[OA' history-substring-search-up
bindkey '^[OB' history-substring-search-down
bindkey "^P" history-substring-search-up
bindkey "^N" history-substring-search-up

# This speeds up pasting w/ autosuggest
# https://github.com/zsh-users/zsh-autosuggestions/issues/238
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

export ERL_AFLAGS="-kernel shell_history enabled"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ${HOME}/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Install `zinit` if not installed
if [ ! -d "${HOME}/.zinit" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

# Load `zinit`
source "${HOME}/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

############
# Plug-ins # 
############
zinit atload'!source ~/.p10k.zsh' lucid nocd for \
    romkatv/powerlevel10k

# OMZSH
zinit wait lucid light-mode for \
    OMZ::lib/key-bindings.zsh \
    OMZ::lib/clipboard.zsh \
    OMZ::lib/git.zsh \
    OMZ::lib/completion.zsh \
    OMZ::lib/directories.zsh

zinit lucid wait light-mode as"program" from"gh-r" for \
    mv"ripgrep* -> rg" pick"rg/rg" @BurntSushi/ripgrep \
    \
    atclone"cp -vf bat*/autocomplete/bat.zsh _bat" \
    atpull"%atclone" \
    mv"bat* -> bat" pick"bat/bat" \
    @sharkdp/bat \
    \
    atclone"cp -vf completions/exa.zsh _exa" \
    atpull"%atclone" \
    mv"bin/exa* -> exa" \
    @ogham/exa

# Fzf 
zinit lucid wait light-mode as"program" for \
    from"gh-r" id-as"junegunn/fzf-tmux-binary" junegunn/fzf \
    pick"bin/fzf-tmux" multisrc"shell/*.zsh" junegunn/fzf \

zinit wait lucid light-mode for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    Aloxaf/fzf-tab \
    zdharma/fast-syntax-highlighting \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit wait lucid light-mode for \
    Tarrasch/zsh-bd \

# fzf-tab styles
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'

#################
# Shell history #
#################
HISTFILE=${HOME}/.zsh_history
SAVEHIST=10000
HISTSIZE=10000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

###########
# Aliases #
###########
alias shutdown='sudo shutdown now'
alias restart='sudo reboot'
alias suspend='sudo pm-suspend'

alias grep="grep -n --color"
alias ls="ls -h" 

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -i'

# git
alias ga='git add'
alias gb='git branch'
alias gbr='git branch -r'
alias gc='git commit'
alias gcln='git branch --merged | egrep -v "(^\*|master|main)" | xargs git branch -d'
alias gco='git checkout'
alias gd='git diff'
alias gl='git log'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'
alias gp='git push'
alias gpl='git pull'
alias gplo='git pull origin'
alias gpo='git push origin'
alias gr='git remote'
alias grs='git remote show'
alias gs='git status'
alias gsh='git show'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'

update() {
  # Check if the cmd exists
  # https://stackoverflow.com/a/677212/2563765
  if command -v zinit >/dev/null 2>&1; then
    zinit update
  fi
  if command -v brew >/dev/null 2>&1; then
    brew update
    brew outdated
    brew upgrade
  fi
  if command -v npm >/dev/null 2>&1; then
    npm install -g npm
  fi
}

# Active conda
if [ -f "${HOME}/anaconda3/bin/activate" ]; then
  source ${HOME}/anaconda3/bin/activate
fi

# Add andorid sdk for expo
if [ -d "${HOME}/Library/Android/sdk" ]; then
  export ANDROID_SDK=${HOME}/Library/Android/sdk
  export PATH=${HOME}/Library/Android/sdk/platform-tools:$PATH
fi

# Add flutter
if [ -d "${HOME}/dev/flutter/bin" ]; then
  export PATH=${HOME}/dev/flutter/bin:$PATH
fi
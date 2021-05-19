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

zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma/fast-syntax-highlighting \
    zdharma/history-search-multi-word \
 blockf \
    zsh-users/zsh-completions \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

zinit snippet OMZ::lib/key-bindings.zsh
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/git.zsh
zinit snippet OMZ::lib/completion.zsh

# Preverse history
# https://unix.stackexchange.com/questions/389881/history-isnt-preserved-in-zsh
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=1000
setopt APPEND_HISTORY

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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

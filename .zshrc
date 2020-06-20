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

mcd() { mkdir -p $1; cd $1 }
cdl() { cd $1; ls}
alias ll='ls -l'
update() {
  # Check if the cmd exists
  # https://stackoverflow.com/a/677212/2563765
  if command -v zinit >/dev/null 2>&1; then
    zinit update
  fi
  if command -v brew >/dev/null 2>&1; then
    brew upgrade
    brew update
    brew cask upgrade
  fi
  if command -v npm >/dev/null 2>&1; then
    npm install -g npm
  fi
}

# Active conda
source ${HOME}/anaconda3/bin/activate

# Add andorid sdk for expo
export ANDROID_SDK=/Users/stevenguh/Library/Android/sdk
export PATH=/Users/stevenguh/Library/Android/sdk/platform-tools:$PATH

# Add flutter
export PATH=/Users/stevenguh/dev/flutter/bin:$PATH

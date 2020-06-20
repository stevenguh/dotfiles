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
zinit ice depth=1; zinit light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ${HOME}/.p10k.zsh.
[[ -f ${HOME}/.p10k.zsh ]] && source ${HOME}/.p10k.zsh

zinit ice wait lucid
zinit light zdharma/history-search-multi-word

zinit ice wait"0" blockf
zinit light zsh-users/zsh-completions

zinit ice wait"0" atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

zinit ice wait"0" atinit"zpcompinit; zpcdreplay"
zinit light zdharma/fast-syntax-highlighting

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

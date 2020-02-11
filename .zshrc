# Install `zplugin` if not installed
if [ ! -d "${HOME}/.zplugin" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
fi

# Load `zplugin`
source "${HOME}/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

############
# Plug-ins # 
############
zplugin snippet OMZ::lib/key-bindings.zsh
zplugin snippet OMZ::lib/clipboard.zsh
zplugin snippet OMZ::lib/git.zsh
zplugin snippet OMZ::lib/completion.zsh

zplugin ice wait lucid
zplugin light zdharma/history-search-multi-word

zplugin ice wait"0" blockf
zplugin light zsh-users/zsh-completions

zplugin ice wait"0" atload"_zsh_autosuggest_start"
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait"0" atinit"zpcompinit; zpcdreplay"
zplugin light zdharma/fast-syntax-highlighting

zplugin ice depth=1; zplugin light romkatv/powerlevel10k
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ${HOME}/.p10k.zsh ]] && source ${HOME}/.p10k.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Active conda
source ~/anaconda3/bin/activate

# Alias vs code to avoid duplicate icon on mac
# https://github.com/microsoft/vscode/issues/60579
alias code='open -b com.microsoft.VSCode "$@"'
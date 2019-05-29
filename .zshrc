module_path+=( "/home/jakob/.zplugin/bin/zmodules/Src" )
zmodload zdharma/zplugin


### Added by Zplugin's installer
source '/home/jakob/.zplugin/bin/zplugin.zsh'
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

zplugin ice wait"1" from"gh-r" as"program" mv"docker* -> docker-compose" lucid
zplugin light docker/compose

zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

zplugin ice wait"0" blockf lucid
zplugin light zsh-users/zsh-completions

zplugin ice wait"0" atload"_zsh_autosuggest_start" lucid
zplugin light zsh-users/zsh-autosuggestions

zplugin ice wait"0" atinit"zpcompinit; zpcdreplay" lucid
zplugin light zdharma/fast-syntax-highlighting

zplugin ice wait"0" lucid
zplugin snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zplugin ice wait"0" lucid
zplugin snippet OMZ::plugins/docker-compose/docker-compose.plugin.zsh

zplugin ice svn lucid pick"" multisrc"{history,clipboard,correction,directories,functions,misc}.zsh" 
zplugin snippet OMZ::lib

zplugin ice pick"shell/key-bindings.zsh" 
zplugin load junegunn/fzf



# executes commands from fzf history directly
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

zle     -N     fzf-history-widget-accept
bindkey '^R' fzf-history-widget
bindkey '^ ' autosuggest-execute
alias ls='ls --color=auto'
alias  text-size='gsettings set org.gnome.desktop.interface text-scaling-factor '

export NPM_PACKAGES="~/.npm-packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules${NODE_PATH:+:$NODE_PATH}"
export PATH="$NPM_PACKAGES/bin:$PATH"


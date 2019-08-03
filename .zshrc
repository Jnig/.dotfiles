module_path+=( "$HOME/.zplugin/bin/zmodules/Src" )
zmodload zdharma/zplugin


### Added by Zplugin's installer
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin
### End of Zplugin's installer chunk

### programs
zplugin ice wait"1" from"gh-r" as"program" bpick"*linux_amd64*" lucid
zplugin light junegunn/fzf-bin

zplugin ice wait"1" from"gh-r" as"program" mv"docker* -> docker-compose" lucid
zplugin light docker/compose

zplugin ice wait"1" from"gh-r" as"program" mv"cli-hasura-linux-amd64 -> hasura" lucid
zplugin light hasura/graphql-engine

zplugin ice wait"1" pick"kubectl" as"program" lucid
zplugin snippet https://storage.googleapis.com/kubernetes-release/release/v1.14.0/bin/linux/amd64/kubectl

zplugin ice wait"1" atclone"tar xfz helm*" pick"linux-amd64/helm" as"program" lucid
zplugin snippet https://storage.googleapis.com/kubernetes-helm/helm-v2.14.0-linux-amd64.tar.gz

zplugin ice wait"1" atclone"unzip -x terraform*" pick"terraform" as"program" lucid
zplugin snippet https://releases.hashicorp.com/terraform/0.12.5/terraform_0.12.5_linux_amd64.zip

zplugin ice wait"1" pick"kubens" as"program" lucid
zplugin snippet https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens

zplugin ice wait"1" pick"kubectx" as"program" lucid
zplugin snippet https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx

zplugin ice wait"1" from"gh-r" as"program" mv"fx-linux -> fx" lucid
zplugin light antonmedv/fx
###

#zplugin ice pick"async.zsh" src"pure.zsh"
#zplugin light sindresorhus/pure
zplugin snippet ~/.dotfiles/purepower 

zplugin ice from"gh"
zplugin load romkatv/powerlevel10k


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
zplugin light junegunn/fzf

export ZSH_CACHE_DIR="${TMPDIR:-/tmp}"
zplugin ice wait"" svn lucid atinit"zpcompinit; zpcdreplay" silent
zplugin snippet OMZ::plugins/kubectl


# executes commands from fzf history directly
fzf-history-widget-accept() {
  fzf-history-widget
  zle accept-line
}

zle     -N     fzf-history-widget-accept
bindkey '^R' fzf-history-widget
bindkey '^ ' autosuggest-execute
alias ls='ls --color=auto'
alias scp='noglob scp'
alias text-size='gsettings set org.gnome.desktop.interface text-scaling-factor '

export PATH="$HOME/.npm/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

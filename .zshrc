module_path+=( "/home/jakob/.zplugin/bin/zmodules/Src" )
zmodload zdharma/zplugin


### Added by Zplugin's installer
source '/home/jakob/.zplugin/bin/zplugin.zsh'
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
zplugin snippet https://releases.hashicorp.com/terraform/0.12.0/terraform_0.12.0_linux_amd64.zip

zplugin ice wait"1" pick"kubens" as"program" lucid
zplugin snippet https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens

zplugin ice wait"1" pick"kubectx" as"program" lucid
zplugin snippet https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
###

#zplugin ice pick"async.zsh" src"pure.zsh"
#zplugin light sindresorhus/pure
zplugin ice from"gh"
zplugin load denysdovhan/spaceship-prompt
SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
#  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
#  node          # Node.js section
#  ruby          # Ruby section
#  elixir        # Elixir section
#  xcode         # Xcode section
#  swift         # Swift section
#  golang        # Go section
#  php           # PHP section
#  rust          # Rust section
#  haskell       # Haskell Stack section
#  julia         # Julia section
#  docker        # Docker section
#  aws           # Amazon Web Services section
#  venv          # virtualenv section
#  conda         # conda virtualenv section
#  pyenv         # Pyenv section
#  dotnet        # .NET section
#  ember         # Ember.js section
#  kubecontext   # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)




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


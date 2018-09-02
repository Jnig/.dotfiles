source ~/.zplug/init.zsh

alias ls='ls --color=auto'

zplug "junegunn/fzf-bin", \
    from:gh-r, \
    as:command, \
    rename-to:fzf, \
    use:"*linux*amd64*"

zplug zsh-users/zsh-syntax-highlighting, as:plugin, from:github
zplug zsh-users/zsh-autosuggestions, as:plugin, from:github
zplug "plugins/vscode", from:oh-my-zsh
zplug "plugins/terraform", from:oh-my-zsh
zplug "plugins/yarn", from:oh-my-zsh
zplug "plugins/helm", from:oh-my-zsh
zplug "plugins/kubectl", from:oh-my-zsh
zplug "plugins/docker-compose", from:oh-my-zsh
zplug "plugins/git", from:oh-my-zsh
zplug "lib/history", from:oh-my-zsh
zplug "plugins/vi-mode", from:oh-my-zsh
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug junegunn/fzf, use:"shell/*.zsh"

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load

bindkey '^R' fzf-history-widget

# ctrl + space for auto suggest
bindkey '^ ' autosuggest-accept

# enable ..<tab>
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'

export PATH=~/.yarn/bin/:$PATH


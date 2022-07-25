function zcompile-many() {
  local f
  for f; do zcompile -R -- "$f".zwc "$f"; done
}

# Clone and compile to wordcode missing plugins.
if [[ ! -e ~/.zsh/fast-syntax-highlighting ]]; then
  git clone --depth=1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git ~/.zsh/fast-syntax-highlighting
  mv -- ~/.zsh/fast-syntax-highlighting/{'→chroma','tmp'}
  zcompile-many ~/.zsh/fast-syntax-highlighting/{fast*,.fast*,**/*.ch,**/*.zsh}
  mv -- ~/.zsh/fast-syntax-highlighting/{'tmp','→chroma'}
fi
if [[ ! -e ~/.zsh/zsh-autosuggestions ]]; then
  git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions.git ~/.zsh/zsh-autosuggestions
  zcompile-many ~/.zsh/zsh-autosuggestions/{zsh-autosuggestions.zsh,src/**/*.zsh}
fi
if [[ ! -e ~/.zsh/powerlevel10k ]]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.zsh/powerlevel10k
  make -C ~/.zsh/powerlevel10k pkg
fi

if [[ ! -e ~/.zsh/fzf-zsh-plugin ]]; then
  git clone --depth=1 git@github.com:unixorn/fzf-zsh-plugin.git ~/.zsh/fzf-zsh-plugin
fi

# Activate Powerlevel10k Instant Prompt. 
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable the "new" completion system (compsys).
autoload -Uz compinit && compinit
[[ ~/.zcompdump.zwc -nt ~/.zcompdump ]] || zcompile-many ~/.zcompdump
unfunction zcompile-many

ZSH_AUTOSUGGEST_MANUAL_REBIND=1

# Load plugins.
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/powerlevel10k/powerlevel10k.zsh-theme
source ~/.p10k.zsh
source ~/.zsh/fzf-zsh-plugin/fzf-zsh-plugin.plugin.zsh


# custom
bindkey '^ ' autosuggest-accept
export _JAVA_AWT_WM_NONREPARENTING=1
export XDG_CONFIG_HOME="$HOME/.config"
export DOCKER_BUILDKIT=1
export POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true

export PNPM_HOME="/home/jakob/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"


# Add flags to existing aliases.
alias ls="${aliases[ls]:-ls} -A"


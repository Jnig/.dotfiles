# ==========================================================================
# Powerlevel10k instant prompt (keep at the top; nothing that prints above it)
# ==========================================================================
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==========================================================================
# Environment
# ==========================================================================
# Linuxbrew (macOS Homebrew is set up in ~/.zprofile)
if [[ -d /home/linuxbrew/.linuxbrew ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

export XDG_CONFIG_HOME="$HOME/.config"
export LC_ALL="en_US.UTF-8"
export EDITOR="nvim"
export VISUAL="nvim"
export DOCKER_BUILDKIT=1
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/bin:$HOME/.local/bin:$PNPM_HOME:$PATH"
[[ -d /opt/nvim-linux-x86_64/bin ]] && export PATH="/opt/nvim-linux-x86_64/bin:$PATH"

# Inside tmux, use the stable agent symlink that `dev` refreshes on every connect,
# so SSH agent forwarding keeps working after reconnects.
[[ -n $TMUX && -L $HOME/.ssh/agent.sock ]] && export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"

# ==========================================================================
# History & options
# ==========================================================================
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE

bindkey -e
WORDCHARS=${WORDCHARS//[\/]}   # word jumps stop at /

# ==========================================================================
# Zinit (plugin manager), installs itself on first run
# ==========================================================================
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
if [[ ! -d "$ZINIT_HOME" ]]; then
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone --depth=1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "$ZINIT_HOME/zinit.zsh"

# ==========================================================================
# Prompt
# ==========================================================================
zinit ice depth=1
zinit light romkatv/powerlevel10k
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# ==========================================================================
# Plugins (turbo mode: loaded right after the prompt appears)
# ==========================================================================
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down; bindkey '^P' history-substring-search-up; bindkey '^N' history-substring-search-down" \
    zsh-users/zsh-history-substring-search \
  atload"_zsh_autosuggest_start; bindkey '^ ' autosuggest-accept" \
    zsh-users/zsh-autosuggestions \
  blockf atpull"zinit creinstall -q ." \
    zsh-users/zsh-completions

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select

# fzf: Ctrl+R history, Ctrl+T files, Alt+C cd
(( $+commands[fzf] )) && source <(fzf --zsh)

# ==========================================================================
# Aliases
# ==========================================================================
alias ls="eza"
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"

# Connect to the dev VM and attach to (or create) its tmux session "main".
# Reconnects automatically when the connection drops; detach (prefix d) to stop.
# Usage: dev [session]
dev() {
  local session=${1:-main} rc
  while true; do
    ssh -t -o ServerAliveInterval=5 -o ServerAliveCountMax=3 -o ConnectTimeout=10 dev \
      "[ -S \"\$SSH_AUTH_SOCK\" ] && ln -sfn \"\$SSH_AUTH_SOCK\" ~/.ssh/agent.sock;
       PATH=/home/linuxbrew/.linuxbrew/bin:\$PATH tmux new -A -s $session"
    rc=$?
    (( rc == 255 )) || return $rc   # 255 = connection error; anything else = detached
    print -P "%F{yellow}dev: connection lost, reconnecting in 3s (Ctrl+C to stop)%f"
    sleep 3
  done
}

# ==========================================================================
# Dotfiles update check
# ==========================================================================
# Fetches ~/.dotfiles in the background (at most every 6h) and prints a notice
# right after the first prompt when there are commits to pull/push or uncommitted changes.
alias dotup='git -C ${DOTFILES:-$HOME/.dotfiles} pull --ff-only'

_dotfiles_check() {
  local dir=${DOTFILES:-$HOME/.dotfiles} stamp=${XDG_CACHE_HOME:-$HOME/.cache}/dotfiles-fetch
  [[ -d $dir/.git ]] || return

  # Background fetch; never prompt for passwords
  local -a stale=($stamp(N.mh+6))
  if [[ ! -e $stamp || -n $stale ]]; then
    mkdir -p ${stamp:h} && touch $stamp
    ( GIT_TERMINAL_PROMPT=0 GIT_SSH_COMMAND="ssh -o BatchMode=yes" \
        git -C $dir fetch -q &>/dev/null ) &!
  fi

  # Compare with the last fetched state (no network)
  local counts behind=0 ahead=0 dirty
  counts=$(git -C $dir rev-list --left-right --count HEAD...@{u} 2>/dev/null) \
    && read ahead behind <<< $counts
  local -a changes=(${(f)"$(git -C $dir status --porcelain 2>/dev/null)"})
  dirty=$#changes
  (( behind || ahead || dirty )) || return
  zle && zle -I   # print above the prompt without garbling it
  (( behind )) && print -P "%F{yellow}dotfiles: $behind commit(s) behind, run %Bdotup%b%f"
  (( ahead ))  && print -P "%F{yellow}dotfiles: $ahead commit(s) not pushed%f"
  (( dirty ))  && print -P "%F{yellow}dotfiles: $dirty uncommitted change(s)%f"
}
# Run 1s after startup, once the prompt is up (avoids p10k instant-prompt warnings)
zmodload zsh/sched && sched +1 _dotfiles_check

# Machine-specific settings and secrets (not in git)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

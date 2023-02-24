# start ssh agent
ssh-add -l &> /dev/null
if [ $? -eq 1 ]; then
  ssh-add
fi

# create stable ssh_auth_sock location for tmux
if  [[ -n "$SSH_AUTH_SOCK" ]] && [[ "$SSH_AUTH_SOCK" != *ssh_auth_sock ]]; then
  ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock

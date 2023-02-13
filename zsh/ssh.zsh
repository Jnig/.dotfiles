# start ssh agent
ssh-add -l &> /dev/null
if [ $? -eq 1 ]; then
  ssh-add
fi

# create stavble ssh_auth_sock location for tmux
if test "$SSH_AUTH_SOCK" ; then
  ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
fi

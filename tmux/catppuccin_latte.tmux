# Catppuccin latte colours for tmux (loaded by tmux.conf on light/dark switch)

set -g mode-style "fg=#1e66f5,bg=#ccd0da"

set -g message-style "fg=#1e66f5,bg=#ccd0da"
set -g message-command-style "fg=#1e66f5,bg=#ccd0da"

set -g pane-border-style "fg=#ccd0da"
set -g pane-active-border-style "fg=#1e66f5"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#1e66f5,bg=#e6e9ef"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#eff1f5,bg=#1e66f5,bold] #S #[fg=#1e66f5,bg=#e6e9ef,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#eff1f5,bg=#1e66f5,bold] #h "

setw -g window-status-activity-style "underscore,fg=#6c6f85,bg=#e6e9ef"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#6c6f85,bg=#e6e9ef"
setw -g window-status-format "#[fg=#e6e9ef,bg=#e6e9ef,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#e6e9ef,bg=#e6e9ef,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#e6e9ef,bg=#ccd0da,nobold,nounderscore,noitalics]#[fg=#1e66f5,bg=#ccd0da,bold] #I  #W #F #[fg=#ccd0da,bg=#e6e9ef,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#df8e1d]#[bg=#e6e9ef]#[fg=#e6e9ef]#[bg=#df8e1d]"
set -g @prefix_highlight_output_suffix ""

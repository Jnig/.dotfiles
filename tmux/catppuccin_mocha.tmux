# Catppuccin mocha colours for tmux (loaded by tmux.conf on light/dark switch)

set -g mode-style "fg=#89b4fa,bg=#313244"

set -g message-style "fg=#89b4fa,bg=#313244"
set -g message-command-style "fg=#89b4fa,bg=#313244"

set -g pane-border-style "fg=#313244"
set -g pane-active-border-style "fg=#89b4fa"

set -g status "on"
set -g status-justify "left"

set -g status-style "fg=#89b4fa,bg=#181825"

set -g status-left-length "100"
set -g status-right-length "100"

set -g status-left-style NONE
set -g status-right-style NONE

set -g status-left "#[fg=#11111b,bg=#89b4fa,bold] #S #[fg=#89b4fa,bg=#181825,nobold,nounderscore,noitalics]"
set -g status-right "#[fg=#11111b,bg=#89b4fa,bold] #h "

setw -g window-status-activity-style "underscore,fg=#a6adc8,bg=#181825"
setw -g window-status-separator ""
setw -g window-status-style "NONE,fg=#a6adc8,bg=#181825"
setw -g window-status-format "#[fg=#181825,bg=#181825,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#181825,bg=#181825,nobold,nounderscore,noitalics]"
setw -g window-status-current-format "#[fg=#181825,bg=#313244,nobold,nounderscore,noitalics]#[fg=#89b4fa,bg=#313244,bold] #I  #W #F #[fg=#313244,bg=#181825,nobold,nounderscore,noitalics]"

# tmux-plugins/tmux-prefix-highlight support
set -g @prefix_highlight_output_prefix "#[fg=#f9e2af]#[bg=#181825]#[fg=#181825]#[bg=#f9e2af]"
set -g @prefix_highlight_output_suffix ""

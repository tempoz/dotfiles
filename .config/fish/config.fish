test -z $TMUX; and tmux new -A -s '♠'
set -gx PATH $PATH /usr/local/go/bin ~/go/bin
set -gx TERM xterm-256color-italic

theme_gruvbox dark medium

set -l fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup

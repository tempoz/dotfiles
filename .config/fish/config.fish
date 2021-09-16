if test -z "$TMUX"
	and status --is-interactive
	tmux new -A -s '♠'
end
for i in /usr/local/go/bin ~/go/bin ~/bin
	if not contains $i $PATH
		set -gx PATH $PATH $i
	end
end
set -gx TERM xterm-256color-italic
set -gx GOPATH ~/go/
set -gx MANPAGER less

# COLORIZE THE OUTPUT OF "LESS" TO MAKE MANPAGES MORE READABLE
set -gx LESS_TERMCAP_mb \e'[01;31m'
set -gx LESS_TERMCAP_md \e'[01;31m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_so \e'[01;44;33m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_us \e'[01;32m'

# TWEAKING OTHER "LESS" PARAMETERS
set -gx LESSCHARSET 'utf-8'
set -gx LESS '-c -i -n -w -z-4 -g -M -R -P%t?f%f :stdin .?pb%pb\%:?lbLine %lb:?bbByte %bb:-...'

alias bazel bazelisk
alias bb "cd ~/src/bb/buildbuddy"

test -z "$VIM_TERMINAL"; and theme_gruvbox dark medium

set -l fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
if status --is-interactive
	source /usr/share/powerline/bindings/fish/powerline-setup.fish
	powerline-setup
end

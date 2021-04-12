test -z "$TMUX"; and tmux new -A -s '♠'
set -gx PATH $PATH /usr/local/go/bin ~/go/bin
set -gx TERM xterm-256color-italic

function vim --wraps vim --description 'alias vim to disable use in vim terminal'
	if test -n "$VIM_TERMINAL"
		echo 'Don\'t nest vim sessions!'
		return 1
	else
		set -l vimcmd (which vim)
		$vimcmd $argv
	end
end

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


theme_gruvbox dark medium

set -l fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
source /usr/share/powerline/bindings/fish/powerline-setup.fish
powerline-setup

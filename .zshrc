# Uncomment this line and add zprof at the bottom for startup time profiling
# zmodload zsh/zprof

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -v

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/marco/.zshrc'

autoload -Uz compinit
#compinit -C
# https://gist.github.com/ctechols/ca1035271ad134841284
setopt extendedglob
if [[ -n ${ZDOTDIR:-${HOME}}/.zcompdump(#qN.mh+24) ]]; then
	compinit;
    # Also compile it into a zwc file for faster loading
    # zcompile "${ZDOTDIR:-${HOME}}/.zcompdump"
else
	compinit -C;
fi;
setopt noextendedglob

setopt histignorespace
setopt histignoredups

PROMPT="%F{4}[%F{6}%n@%m%F{4}](%F{6}%~%F{4})%f
%(?..%F{1})%#%f "

# Aliases

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias pyac="source bin/activate"
alias pysr="python3 -m http.server"

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias za='zathura --fork >/dev/null 2>&1'
alias ytdl='youtube-dl'

alias sc='systemctl'
alias scu='systemctl --user'
alias jc='journalctl'
alias jcu='journalctl --user'

alias sudo='sudo '
alias s='sudo '

alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"

alias aptup='sudo apt update'
alias aptug='sudo untildone apt upgrade -y'
alias aptuu='sudo apt update && sudo untildone apt -y upgrade'
alias aptrm='sudo apt remove'
alias aptar='sudo apt remove --autoremove'
alias aptl='apt list'
alias aptlu='apt list -u'
alias aptli='apt list -i'
alias aptin='sudo untildone apt install -y'
alias aptse='apt search'
alias apts='apt show'

alias untildone='untildone '
alias ud='untildone '

alias a2='aria2c'

alias pmpv='mpv --no-cache --no-video --save-position-on-quit'
alias vmpv='mpv --quiet'
alias mpva='ud mpv --ytdl-format=bestaudio'
alias mpvap='ud mpv --ytdl-format=bestaudio --pause'

alias ytba='ud youtube-dl -f bestaudio -o "%(title)s.%(ext)s"'

alias nb='newsboat'
alias ncm='ncmpcpp'

# End of aliases

mkcd()
{
    mkdir -p "$1" && cd "$1"
}

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh || true

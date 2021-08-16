# Uncomment this line and add zprof at the bottom for startup time profiling
# zmodload zsh/zprof

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -v

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/marco/.zshrc'

# Initialize completion and avoid regenerating cache unless older than 24h
# Also zcompile it for a little faster loading
autoload -Uz compinit

Zcompdump="${ZDOTDIR:-${HOME}}/.zcompdump"

# This is a slightly modified version of
# https://gist.github.com/ctechols/ca1035271ad134841284
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-3109177
() {
    if [[ -n "$1" || ! -e "$Zcompdump.zwc" ]]; then
        echo "Regenerating completion cache"
        compinit
        compdump
        zcompile "$Zcompdump"
        clear
    else
        compinit -C;
    fi;
} "$Zcompdump"(N.mh+24)

setopt histignorespace histignoredups

PROMPT="%F{12}[%F{14}%n@%m%F{12}](%F{14}%~%F{12})%f
%(?..%F{9})%#%f "

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
alias mpvw='ud mpv --ytdl-format=worst'
alias mpvwp='ud mpv --ytdl-format=worst --pause'

alias ytba='ud youtube-dl -f bestaudio -o "%(title)s.%(ext)s"'

alias nb='newsboat'
alias nbr='newsboat -x reload'
alias nbdp='newsboat-download-podcast'
alias ncm='ncmpcpp'

alias hc='herbstclient'

# End of aliases

mkcd()
{
    mkdir -p "$1" && cd "$1"
}

uni()
{
    unidir="$HOME/doc/uni/cur"
    target="$(find "$unidir/" -mindepth 1 -type d -printf '%P\n' |
        fzf --height 40% --preview="ls --color=always $unidir/{}" || return 0)"
    [ "$target" ] || return 0
    cd "$unidir/$target"
}

# Make a temporal test directory and switch to it
mktest()
{
    testdir="$(mktemp -d)"
    cd "$testdir"
}

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true
[ -f /usr/share/fzf/shell/key-bindings.zsh ] && source /usr/share/fzf/shell/key-bindings.zsh || true

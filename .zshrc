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

# Ignore lines from including them in history
# See zshmisc(1), SPECIAL FUNCTIONS section
zshaddhistory()
{
    # return 1 is like a space at the beginning, not saved and stays until the
    # next command, return 2 saves it to memory but not to the file

    # $1 is the entered command, including newlines, so I'll strip the last one
    # And also strip out trailing whitespace
    line=${1%%$'\n'}
    line=${line%% }

    case "$line" in
        # ls and aliases without arguments
        (l|l[s.al])
            return 2
            ;;
        # Common programs and aliases (without any arguments)
        (nb|nbr|nbdp|pysr|htop|nnn|exit|ncm|ncmpcpp|uni|pw-top|nettest|nvim| \
         mktest|reboot|poweroff)
            return 2
            ;;
        ("vq -"[de])
            return 2
            ;;
        # Ignore cd to parent and cd to home
        ("cd .."|cd|"cd ~")
            return 2
            ;;
    esac
}

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

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

# This is a modified version of
# https://gist.github.com/ctechols/ca1035271ad134841284
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-3109177

if [ "$Zcompdump"(N.mh+24) ]; then
    printf "Regenerating completion cache"
    compinit
    compdump
    zcompile "$Zcompdump"
    printf "\r"
else
    compinit -C;
fi

setopt histignorespace histignoredups
setopt histreduceblanks
setopt correct

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info; }

zstyle ':vcs_info:git:*' formats '%F{12}{%F{14}%b%F{12}}%f'
 
setopt PROMPT_SUBST

PROMPT='%F{12}[%F{14}%n@%m%F{12}](%F{14}%~%F{12})%f${vcs_info_msg_0_}
%(?..%F{9})%#%f '
#RPROMPT='%(?;;[%F{red}%B%?%b%f])'

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
alias mpvap='mpva --pause'
alias mpvw='ud mpv --ytdl-format="worst[ext!=3gp]"'
alias mpvwp='mpvw --pause'
alias mpvp='mpv --pause'

alias ytba='ud yt-dlp -f bestaudio -o "%(title)s.%(ext)s"'

alias nb='newsboat'
alias nbr='newsboat -x reload'
alias nbdp='newsboat-download-podcast'
alias ncm='ncmpcpp'

alias hc='herbstclient'

# Please, shut up
alias ffmpeg='ffmpeg -hide_banner'
alias ffprobe='ffprobe -hide_banner'
alias ffplay='ffplay -hide_banner'

# End of aliases

# Bindings

# Make zsh's vi mode better
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line            

# Ignore lines from including them in history
# See zshmisc(1), SPECIAL FUNCTIONS section
zshaddhistory()
{
    # return 1 is like a space at the beginning, not saved and stays until the
    # next command, return 2 saves it to memory but not to the file

    # $1 is the entered command, including newlines, so I'll strip the last one
    # And also strip out trailing whitespace
    local line
    line=${1%%$'\n'}

    # To strip trailing whitespace nicely, we can use the `##` glob operator,
    # which works like a `+` in a regex. It is only available with extendedglob
    # so I'll enable it temporarily and then restore to the previous state
    local extglob_state="${options[extendedglob]}"
    setopt extendedglob
    line="${line%% ##}"
    options[extendedglob]="$extglob_state"

    # TODO: What about using `set --`, so the arguments are put in $1..$n
    case "$line" in
        # Common programs and aliases (without any arguments)
        (nb|nbr|nbdp|pysr|htop|nnn|exit|ncm|ncmpcpp|uni|pw-top|nettest|nvim| \
         mktest|reboot|poweroff|reset|xev|rehash|make|unattended-watch|l|l[s.al])
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
    if ! command -v xdg-user-dir >/dev/null; then
        echo "xdg-user-dir is not installed" >&2
        return 1
    fi

    local unidir="$(xdg-user-dir DOCUMENTS)/uni/cur"
    if ! [ -d "$unidir" ]; then
        cat <<ERRMSG >&2
\$unidir ($unidir) doesn't exist. Check:
* Is the DOCUMENTS xdg directory defined?
* \$unidir exists and is a directory or link to a directory
ERRMSG
        return 2
    fi

    local target="$(find "$unidir/" -mindepth 1 -type d -printf '%P\n' |
        fzf --height 40% --preview="ls --color=always $unidir/{}" || return 0)"
    [ "$target" ] || return 0
    cd "$unidir/$target"
}

# Make a temporal test directory and switch to it
mktest()
{
    local testdir="$(mktemp -d)"
    cd "$testdir"
}

# Wrapper enabling cd-on-quit
nnn()
{
    # Run the real nnn and forward args
    command nnn "$@"
    # Store nnn's status code, to be later returned
    local nnn_exit="$?"

    # Glob the cd-on-quit file
    #  N = Nullglob, return nothing on failed glob instead of error
    #  . = Plain files
    #  m = Modification time
    #  s = seconds
    # -1 = 1 second or earlier
    # Using an array, since globs aren't expanding when setting as a string
    local nnn_cdfile=("$HOME/.config/nnn/.lastd"(N.ms-1))
    if [ "$nnn_cdfile" ]; then
        . "$nnn_cdfile"
    fi
    return "$nnn_exit"
}

#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh || true
[ -f /usr/share/fzf/shell/key-bindings.zsh ] &&
    source /usr/share/fzf/shell/key-bindings.zsh || true

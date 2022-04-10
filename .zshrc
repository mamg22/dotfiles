# Uncomment this line and add zprof at the bottom for startup time profiling
# zmodload zsh/zprof

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
bindkey -v

zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle :compinstall filename '/home/marco/.zshrc'
zstyle ':completion:*' use-cache true

# Initialize completion and avoid regenerating cache unless older than 24h
# Also zcompile it for a little faster loading
#
# This is a modified version of
# https://gist.github.com/ctechols/ca1035271ad134841284
# https://gist.github.com/ctechols/ca1035271ad134841284#gistcomment-3109177

autoload -Uz compinit

() {
    local zcompdump="${ZDOTDIR:-${HOME}}/.zcompdump"
    local regen_msg="Regenerating completion cache"
    if [ "$zcompdump"(N.mh+24) ]; then
        printf "%s" "$regen_msg"
        compinit
        compdump
        zcompile "$zcompdump"
        printf "\r%s\r" "${regen_msg//?/ }"
    else
        compinit -C;
    fi
}

setopt hist_ignore_space hist_ignore_dups hist_ignore_all_dups
setopt hist_reduce_blanks
setopt correct

# Reduce wait after <Esc> (maybe other keys) is pressed
# This makes <Esc><any key> work when typed quickly
KEYTIMEOUT=1

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info; }

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%B%F{green} %b%f%%b'
 
setopt PROMPT_SUBST
setopt TRANSIENT_RPROMPT

# Setup prompt
# Anonymous function for scoping
() {
    local userhost='%B%F{red}%n%F{white}@%F{red}%m%f%b'
    local dir='%B%F{yellow}%~%f%b'
    local vcs='${vcs_info_msg_0_}'
    local symbol='%(?..%B%F{9})%#%b%f'
    
    local nnn="%F{yellow}${NNNLVL:+nnn:$NNNLVL }%f"

PROMPT="$userhost $dir $nnn$vcs
$symbol "
}

# Setup rprompt
() {
    local mode='${_zmode:+ $_zmode}'
    local exitcode='%(?;;[%F{red}%B%?%b%f])'

    RPROMPT="$exitcode$mode"
    RPROMPT2="$exitcode$mode"
}

# Show vi mode in prompt

function zle-line-init zle-keymap-select {
    local mode
    local color
    case "$KEYMAP" in
        (vicmd)
            mode="COMMAND"
            color="green"
            ;;
        (main|viins)
            if [[ "$ZLE_STATE" == *overwrite* ]]; then
                mode="REPLACE"            
                color="red"
            else
                mode="INSERT"            
                color="blue"
            fi
            ;;
            # TODO: Figure out a way to show VISUAL too
            # There's $MARK, but the number remains even after ending visual
            # selection (maybe wrap the visual mode functions?)
            #
            # $NUMERIC is a nice one to have too, but haven't figured a way to
            # have it without messing up the prompt position because of
            # multiple `zle reset-prompt`
        (*)
            mode="$KEYMAP"
            color="yellow"
            ;;
    esac
    _zmode="[%B%F{$color}$mode%f%b]"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# WIP: Show count in prompt

#function update-zcount {
#    local format="[%B%F{magenta}$NUMERIC%f%b]"
#    _zcount="${NUMERIC:+$format}"
#}
#
#function my-digit-argument {
#    zle .digit-argument
#    update-zcount
#    zle reset-prompt
#}
#
#function my-vi-digit-or-beginning-of-line {
#    zle .vi-digit-or-beginning-of-line
#    update-zcount
#    zle reset-prompt
#}
#zle -N my-digit-argument
#zle -N my-vi-digit-or-beginning-of-line
#
#bindkey -R -M vicmd 1-9 my-digit-argument
#bindkey -M vicmd 0 my-vi-digit-or-beginning-of-line

# Aliases

alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias pyac="source bin/activate"
alias pysr="python3 -m http.server"

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

alias kdec='kdeconnect-cli -d "$(kdeconnect-get-device)"'
alias kdes='kdeconnect-send'

alias dnfdlup='sudo untildone dnf upgrade --downloadonly -y'
alias dnfc='dnf -C'

# End of aliases

# Bindings

# Make zsh's vi mode better
bindkey "^?" backward-delete-char
bindkey "^W" backward-kill-word 
bindkey "^H" backward-delete-char
bindkey "^U" backward-kill-line            

# Allow shift-Tab to go back in completion
bindkey "^[[Z" reverse-menu-complete

# Search through hitory with current text
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# Named directories
hash -d -- uni=~/Documentos/uni
hash -d -- cur=~uni/cur
hash -d -- t1=~uni/t1
hash -d -- t2=~uni/t2
hash -d -- t3=~uni/t3
hash -d -- t4=~uni/t4

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
    local mindepth=1
    local maxdepth=9999
    local trayecto
    while getopts swt: name; do
        case "$name" in
            (s) # Subject
                maxdepth=1
            ;;
            (w) # Work
                mindepth=2
                maxdepth=2
            ;;
            (t)
                # Trayecto (year)
                trayecto="$OPTARG"
                if [ "$trayecto" -lt 0 ] || [ "$trayecto" -gt 4 ]; then
                    echo >&2 "Invalid trayecto"
                    return 4
                fi
                # I prefix them with a "t"
                trayecto="t$trayecto"
                ;;
            (?)
                return 3
        esac
    done
    shift $((OPTIND - 1))

    local query="$1"

    # TODO: Cambiar el comando por un array y desenrollarlo in line
    # ademas de construirlo con mas detalles (excluir?)

    if ! command -v xdg-user-dir >/dev/null; then
        echo "xdg-user-dir is not installed" >&2
        return 1
    fi

    local unidir="$(xdg-user-dir DOCUMENTS)/uni/${trayecto:-cur}"
    if ! [ -d "$unidir" ]; then
        echo >&2 "\
\$unidir ($unidir) doesn't exist. Check:
* Is the DOCUMENTS xdg directory defined?
* \$unidir exists and is a directory or link to a directory"
        return 2
    fi

    local findcmd=(
        find "$unidir/" -mindepth "$mindepth" -maxdepth "$maxdepth" 
        -type d -printf '%P\n'
    )

    local fzfcmd=(
        fzf --height 40% --preview="ls --color=always $unidir/{}"
        -q "$query"
    )


    local target="$("${findcmd[@]}" | "${fzfcmd[@]}" || return 0)"
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
    # cd-on-quit file location
    local nnn_cdfile="$HOME/.config/nnn/.lastd"

    # Run the real nnn and forward args
    command nnn "$@"
    # Store nnn's status code, to be later returned
    local nnn_exit="$?"

    # Glob the cd-on-quit file with these flags:
    #  N = Nullglob, return nothing on failed glob instead of error
    #  . = Plain files
    #  m = Modification time
    #  s = seconds
    # -1 = 1 second or earlier
    #
    # Succesfull glob will return the filename, proving true
    # Failed glob returns nothing, ending up as `[ ]`, which is false
    if [ "$nnn_cdfile"(N.ms-1) ]; then
        . "$nnn_cdfile"
    fi
    return "$nnn_exit"
}

# Fetch/Pull pull requests
gprfetch() {
    git fetch upstream "refs/pull/$1/head:pr$1"
}

gprpull() {
    git pull upstream "refs/pull/$1/head:pr$1"
}

() {
    local fzf_file="/usr/share/fzf/shell/key-bindings.zsh"
    [ -f "$fzf_file" ] && source "$fzf_file" || true
}

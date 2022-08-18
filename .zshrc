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
        printf "%s" "$regen_msg" >&2
        compinit
        compdump
        zcompile "$zcompdump"
        printf "\r%s\r" "${regen_msg//?/ }" >&2
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
    local ncdu="%F{yellow}${NCDU_LEVEL:+ncdu:$NCDU_LEVEL }%f"

PROMPT="$userhost $dir $nnn$ncdu$vcs
$symbol "
}

# Setup rprompt
() {
    local mode='${_zmode:+ $_zmode}'
    local exitcode='%(?;;[%F{red}%B%?%b%f])'

    RPROMPT="$exitcode$mode"
    RPROMPT2="$exitcode$mode"
}


# Aliases
source ~/.zsh/aliases.zsh

# Functions
source ~/.zsh/functions.zsh

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
hash -d -- kdec=~/Descargas/kdeconnect


() {
    local fzf_file="/usr/share/fzf/shell/key-bindings.zsh"
    [ -f "$fzf_file" ] && source "$fzf_file" || true
}

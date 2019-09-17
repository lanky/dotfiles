# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions

function __get_venv() {
    if [ -n "${VIRTUAL_ENV}" ]; then
        echo -n "(${VIRTUAL_ENV##*/})${*}"
    else
        echo -n "${*}"
    fi
}

function pathmunge() {
    case ":${PATH}:" in
        *:"${1}":*)
            ;;
        *)
            if [ "$2" = "after" ] ; then
                PATH=$PATH:$1
            else
                PATH=$1:$PATH
            fi
    esac
}

if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
    source /usr/share/git-core/contrib/completion/git-prompt.sh
    export GIT_PROMPT_ONLY_IN_REPO=1
    export GIT_PS1_SHOWDIRTYSTATE=1
    export GIT_PS1_SHOWUNTRACKEDFILES=1
    export GIT_PS1_SHOWCOLORHINTS=1
    export GIT_PS1_SHOWUPSTREAM=git
    export GIT_PS1_SHOWSTASHSTATE=1
    export MY_PS1="\e[1;34m\u\e[0m@\e[33m\h\e[0m:\e[31m\W\e[0m"
    # export PROMPT_COMMAND='__git_ps1 "\u@\h:\W" "\n\\\$ "'
    if [ -n "${VIRTUAL_ENV}" ]; then
        export PP="(${VIRTUAL_ENV##*/})"
    fi
    export PROMPT_COMMAND='__git_ps1 "${MY_PS1}" "\n$(__get_venv)\\\$ "'
fi

pathmunge ${HOME}/bin after


export PATH

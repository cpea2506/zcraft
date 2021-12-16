# use to call function and get time command execution
source $ZDOTDIR/functions.zsh

setopt nopromptbang prompt{cr,percent,sp,subst}
setopt prompt_subst

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz colors && colors

add-zsh-hook preexec time_preexec
add-zsh-hook precmd time_precmd
add-zsh-hook chpwd prompt_chpwd
add-zsh-hook precmd prompt_precmd
precmd_functions+=( precmd_vcs_info )

zstyle -e ':completion:*:default' \
	list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==02=01}:${(s.:.)LS_COLORS}")';
zstyle ':vcs_info:*' enable git 
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:*' check-for-staged-changes true
zstyle ':vcs_info:*+pre-get-data:*' hooks pre-get-data
zstyle -e ':vcs_info:git:*' \
	check-for-changes 'estyle-cfc && reply=( true ) || reply=( false )'

function estyle-cfc() {
	local d
	local -a cfc_dirs
	cfc_dirs=(
		$HOME/Code/*(/)
		$HOME/.config/*(/)
	)

	for d in ${cfc_dirs}; do
		d=${d%/##}
		[[ $PWD == $d(|/*) ]] && return 0
	done
	return 1
}

FORCE_RUN_VCS_INFO=1

+vi-pre-get-data() {
    [[ $vcs != git ]] && return

    if [[ -n $FORCE_RUN_VCS_INFO ]]; then
        FORCE_RUN_VCS_INFO=
        return
    fi

    # If we got to this point, running vcs_info was not forced, so now we
    # default to not running it and selectively choose when we want to run
    # it (ret=0 means run it, ret=1 means don't).
    ret=1
    # If a git command was run then run vcs_info as the status might
    # need to be updated.
    case "$(fc -ln $(($HISTCMD-1)))" in
        git*)
            ret=0
            ;;
    esac
}

function prompt_precmd {
	vcs_info
	
	PS1='$(_current_language) %F{4}%1~%f' 
	if [[ -n $vcs_info_msg_0_ ]]; then
		UNTRACKED=$(git ls-files --other --exclude-standard --directory --no-empty-directory| sed q)
		UNSTAGED=$(git diff --name-only | sed q)
		STAGED=$(git diff --cached --name-only | sed q)
		COMMIT=$(git log --no-decorate --single-worktree --ignore-missing origin/$vcs_info_msg_0_..$vcs_info_msg_0_ -q | sed q)

		if [[ -n $UNSTAGED || $UNTRACKED ]]; then
			PS1+=' %F{#f33}$vcs_info_msg_0_ ✗'
		elif [[ -n $STAGED || $COMMITED ]]; then
			PS1+=' %F{3}$vcs_info_msg_0_ ±'
		else
			PS1+=' %F{2}$vcs_info_msg_0_ '
		fi
	fi
	PS1+=' %(?.%F{2} .%F{#f63} )%f: '
	RPS1='%F{cyan}$prompt_elapsed_time%f'
}

function prompt_chpwd {
	FORCE_RUN_VCS_INFO=1
}

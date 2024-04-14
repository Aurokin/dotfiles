#!/bin/bash

tmux_running=$(pgrep tmux)
tmux_active=$(echo $TMUX)
is_kill="";
if [[ $1 == "k" ]]; then
    is_kill=true;
fi

if [[ -z $tmux_active ]]; then
    if [[ $tmux_running ]]; then
        $(tmux a);
    else
        $(tmux new -s default);
    fi
fi

if [[ $tmux_running ]]; then
    current_session=$(tmux display-message -p '#S')

    if [[ $current_session != "twigsmux" ]]; then
        if tmux has-session -t=$current_session > /dev/null; then
            tmux new-session -ds twigsmux -c ~
        fi
        tmux switch-client -t twigsmux

        if [[ $is_kill = true ]]; then
            tmux send-keys -t twigsmux "source ~/.zsh_scripts/twigsmux.sh k" enter
        else
            tmux send-keys -t twigsmux "source ~/.zsh_scripts/twigsmux.sh" enter
        fi
        return;
    fi

    s=$(tmux ls | awk '{print $1}' | fzf --print-query | tail -1)

    if [[ -z $s ]]; then
        return;
    fi

    s_cut=$(echo $s | rg -o -m 1 "^\w*")

    if [[ -z $is_kill ]]; then
        if ! tmux has-session -t=$s_cut 2> /dev/null; then
            tmux new-session -ds $s_cut -c ~
        fi

        tmux switch-client -t $s_cut
    else
        if tmux has-session -t=$s_cut 2> /dev/null; then
            tmux kill-session -t $s_cut
        fi
    fi

    tmux kill-session -t twigsmux
fi
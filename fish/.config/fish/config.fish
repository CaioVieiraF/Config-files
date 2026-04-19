if status is-interactive
    # Commands to run in interactive sessions can go here
end

if set -q TMUX
    sed 's/\x1b\]11;#[^ ]*//g; s/\x1b\]708;#[^ ]*//g' ~/.cache/wal/sequences > /dev/tty
else if test -e ~/.cache/wal/sequences
    cat ~/.cache/wal/sequences
end

if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
end

zoxide init fish | source

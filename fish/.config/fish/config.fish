if status is-interactive
    # Commands to run in interactive sessions can go here
end

cat /home/v/.cache/wal/sequences

if type -q tmux
    if not test -n "$TMUX"
        tmux attach-session -t default; or tmux new-session -s default
    end
end


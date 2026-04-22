if status is-interactive
    if test -z "$FASTFETCH_DONE"
        set -gx FASTFETCH_DONE 1
        fastfetch
    end
end

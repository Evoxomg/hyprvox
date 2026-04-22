function fish_prompt
    set_color brblue
    echo -n "╭─ "

    set_color cyan
    echo -n (whoami)

    set_color white
    echo -n "@"

    set_color brblue
    echo -n (hostname)

    set_color cyan
    echo -n " 󰣇"

    set_color white
    echo -n " "

    set_color yellow
    echo -n (prompt_pwd)

    echo

    set_color brblue
    echo -n "╰─"

    set_color green
    echo -n "❯ "

    set_color normal
end

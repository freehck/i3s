function i3s_ram {
    RAM_SHORT_NAME=${RAM_SHORT_NAME:-"RAM: "}
    RAM_FULL_NAME=${RAM_FULL_NAME:-"Memory: "}

    RAM_NORMAL_COLOR=${RAM_NORMAL_COLOR:-"$DEFAULT_COLOR"}
    RAM_MEDIUM_COLOR=${RAM_MEDIUM_COLOR:-"#ff7f00"} # orange
    RAM_HIGH_COLOR=${RAM_HIGH_COLOR:-"#ff0000"} # red

    RAM_MEDIUM_PERCENT=${RAM_MEDIUM_PERCENT:-60}
    RAM_HIGH_PERCENT=${RAM_HIGH_PERCENT:-85}

    RAM_HIDE_LABEL=${RAM_HIDE_LABEL:-""}
    if [ -n "$RAM_HIDE_LABEL" ]; then
	RAM_SHORT_NAME=
	RAM_FULL_NAME=
    fi

    
    read total used < <(free | awk '/^Mem:/{printf "%d ", $2} /^-/{print $3}')
    let "percent = used * 100 / total"

    color=
    if [ $percent -lt $RAM_MEDIUM_PERCENT ]; then
	color=$RAM_NORMAL_COLOR
    elif [ $percent -lt $RAM_HIGH_PERCENT ]; then
	color=$RAM_MEDIUM_COLOR
    else
	color=$RAM_HIGH_COLOR
    fi

    short_text="$RAM_SHORT_NAME$percent%"
    full_text="$RAM_FULL_NAME$percent%"

    printf '{"name": "ram", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"
}

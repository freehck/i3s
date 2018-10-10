i3s_layout() {
    LAYOUT_SHORT_NAME=${LAYOUT_SHORT_NAME:-"Lang"}
    LAYOUT_FULL_NAME=${LAYOUT_SHORT_NAME:-"Language"}

    lang=`xkblayout-state print '%s'`

    color=$(eval "echo \$$(echo LAYOUT_COLOR_$(to_upper "lang"))")
    color=${color:-$DEFAULT_COLOR}
    
    short_text="$LAYOUT_SHORT_NAME: $lang"
    full_text="$LAYOUT_FULL_NAME: $lang"
    
    printf '{"name": "layout", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"
}

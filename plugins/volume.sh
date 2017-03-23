function i3s_volume {
    VOLUME_SHORT_NAME=${VOLUME_SHORT_NAME:-"♪"}
    VOLUME_FULL_NAME=${VOLUME_FULL_NAME:-"Volume"}
    VOLUME_MUTED_COLOR=${VOLUME_MUTED_COLOR:-"$DEFAULT_COLOR"}
    VOLUME_COLOR=${VOLUME_COLOR:-"$DEFAULT_COLOR"}

    VOLUME_HIDE_PERCENT=${VOLUME_HIDE_PERCENT:-""}
    VOLUME_HIDE_DECIBEL=${VOLUME_HIDE_DECIBEL:-""}

    VOLUME_HIDE_MUTED_TEXT=${VOLUME_HIDE_MUTED_TEXT:-""}
    VOLUME_MUTED_TEXT=${VOLUME_MUTED_TEXT:-"[M]"}
    
    data=`amixer sget Master | tail -1`
    
    color="$VOLUME_COLOR"
    muted=
    if echo "$data" | grep -q off
    then
	color="$VOLUME_MUTED_COLOR"
	if [ -z "$VOLUME_HIDE_MUTED_TEXT" ]; then muted=" $VOLUME_MUTED_TEXT"; fi
    fi

    percent=
    decibel=
    if [ -z "$VOLUME_HIDE_PERCENT" ]; then percent=" "`echo "$data" | grep -oE '[0-9]+%'`; fi
    if [ -z "$VOLUME_HIDE_DECIBEL" ]; then decibel=" "`echo "$data" | grep -oE '[0-9.]+dB'`; fi

    short_text="$VOLUME_SHORT_NAME:$percent$decibel$muted"
    full_text="$VOLUME_FULL_NAME:$percent$decibel$muted"
    
    printf '{"name": "volume", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"
    
}

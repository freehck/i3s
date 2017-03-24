VOLUME_SHORT_NAME=${VOLUME_SHORT_NAME:-"♪"}
VOLUME_FULL_NAME=${VOLUME_FULL_NAME:-"Volume"}
VOLUME_SEPARATOR=": "
VOLUME_MUTED_COLOR=${VOLUME_MUTED_COLOR:-"$DEFAULT_COLOR"}
VOLUME_COLOR=${VOLUME_COLOR:-"$DEFAULT_COLOR"}

VOLUME_MUTED_TEXT=${VOLUME_MUTED_TEXT:-"[M]"}
    
if [ -n "$VOLUME_HIDE_LABEL" ]; then
    VOLUME_SHORT_NAME=
    VOLUME_FULL_NAME=
    VOLUME_SEPARATOR=
fi


function i3s_volume {
    unset data color muted sep percent decibel short_text full_text

    data=`amixer sget Master | tail -1`

    if echo "$data" | grep -q off
    then
	color="$VOLUME_MUTED_COLOR"
	if [ -z "$VOLUME_HIDE_MUTED_TEXT" ]; then muted=" $VOLUME_MUTED_TEXT"; fi
    else
	color="$VOLUME_COLOR"
    fi

    [ -z "$VOLUME_HIDE_PERCENT" ] && percent=`echo "$data" | grep -oE '[0-9]+%'`
    [ -z "$VOLUME_HIDE_DECIBEL" ] && decibel=`echo "$data" | grep -oE '[0-9.]+dB'`
    [ -z "$VOLUME_HIDE_PERCENT" ] && [ -z "$VOLUME_HIDE_DECIBEL" ] && sep=" "
    short_text="${VOLUME_SHORT_NAME}${VOLUME_SEPARATOR}${percent}${sep}${decibel}${muted}"
    full_text="${VOLUME_FULL_NAME}${VOLUME_SEPARATOR}${percent}${sep}${decibel}${muted}"
    
    printf '{"name": "volume", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"

}

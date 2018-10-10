TIME_TIMEOUT=1
TIME_SHORT_NAME=${TIME_SHORT_NAME:-""}
TIME_FULL_NAME=${TIME_FULL_NAME:-"Time: "}
TIME_COLOR=${TIME_COLOR:-"$DEFAULT_COLOR"}
TIME_FORMAT=${TIME_FORMAT:-"%d %b %Y, %T"}
TIME_HIDE_LABEL=${TIME_HIDE_LABEL:-""}
if [ -n "$TIME_HIDE_LABEL" ]; then
    TIME_SHORT_NAME=
    TIME_FULL_NAME=
fi

i3s_time() {
    data=`date +"$TIME_FORMAT"`
    color="$TIME_COLOR"
    short_text="$TIME_SHORT_NAME$data"
    full_text="$TIME_FULL_NAME$data"
    
    printf '{"name": "time", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"
    
}

MPD_TIMEOUT=5
function i3s_mpd {
    MPD_SHORT_NAME=${MPD_SHORT_NAME:-"MPD"}
    MPD_FULL_NAME=${MPD_FULL_NAME:-"MPD"}
    MPD_OFF_COLOR=${MPD_OFF_COLOR:-"$DEFAULT_COLOR"}
    MPD_PLAYING_COLOR=${MPD_PLAYING_COLOR:-"$DEFAULT_COLOR"}
    MPD_OFF_MESSAGE=${MPD_OFF_MESSAGE:-"off"}

    mpd_status="$MPD_OFF_MESSAGE"
    mpd_color="$MPD_OFF_COLOR"
    if mpc | grep -q playing
    then
	mpd_status=`mpc -f '%artist% - %title%' | head -1`
	mpd_color="$MPD_PLAYING_COLOR"
    fi

    mpd_short_text="$MPD_SHORT_NAME: $mpd_status"
    mpd_full_text="$MPD_FULL_NAME: $mpd_status"
    
    printf '{"name": "mpd", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$mpd_short_text" "$mpd_full_text" "$mpd_color"
}

LOAD_TIMEOUT=10
LOAD_CPU_CORES=`grep -c ^processor /proc/cpuinfo`

percentize() {
    echo "$1 * 100 / 1" | bc
}

i3s_load() {
    LOAD_SHORT_NAME="LA:";
    LOAD_FULL_NAME="Load:";

    LOAD_MEDIUM=${LOAD_MEDIUM:-`echo "scale=2; $LOAD_CPU_CORES * 2 / 3" | bc`}
    LOAD_HIGH=${LOAD_HIGH:-$LOAD_CPU_CORES}

    LOAD_MEDIUM_PERCENT=${LOAD_MEDIUM_PERCENT:-`percentize $LOAD_MEDIUM`}
    LOAD_HIGH_PERCENT=${LOAD_HIGH_PERCENT:-`percentize $LOAD_HIGH`}

    LOAD_NORMAL_COLOR=${LOAD_NORMAL_COLOR:-$DEFAULT_COLOR}
    LOAD_MEDIUM_COLOR=${LOAD_MEDIUM_COLOR:-$ORANGE}
    LOAD_HIGH_COLOR=${LOAD_HIGH_COLOR:-$RED}

    LOAD_HIDE_LABEL=${LOAD_HIDE_LABEL:-""}
    LOAD_HIDE_LA1=${LOAD_HIDE_LA1:-""}
    LOAD_HIDE_LA5=${LOAD_HIDE_LA5:-""}
    LOAD_HIDE_LA15=${LOAD_HIDE_LA15:-""}

    read la1 la5 la15 _ _ < /proc/loadavg
    la1p=`percentize $la1`
    la5p=`percentize $la5`
    la15p=`percentize $la15`

    color=
    if [ $la1p -lt $LOAD_MEDIUM_PERCENT ]; then
	color=$LOAD_NORMAL_COLOR
    elif [ $la1p -lt $LOAD_HIGH_PERCENT ]; then
	color=$LOAD_MEDIUM_COLOR
    else
	color=$LOAD_HIGH_COLOR
    fi

    if [ -z $LOAD_HIDE_LA1 ]; then la1=" $la1"; else unset la1; fi
    if [ -z $LOAD_HIDE_LA5 ]; then la5=" $la5"; else unset la5; fi
    if [ -z $LOAD_HIDE_LA15 ]; then la15=" $la15"; else unset la15; fi
    
    short_text="${LOAD_SHORT_NAME}${la1}${la5}${la15}"
    full_text="${LOAD_FULL_NAME}${la1}${la5}${la15}"

    printf '{"name": "load", "short_text": "%s", "full_text": "%s", "color": "%s"}' \
	   "$short_text" "$full_text" "$color"
}

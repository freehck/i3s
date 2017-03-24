#!/bin/bash

# DEFAULTS
GLOBAL_CONFIG_PATH="/etc/i3s.conf"
USER_CONFIG_PATH="$HOME/.i3s.conf"

PLUGINS_DIR=${PLUGINS_DIR:-"/home/freehck/prog/status-bar/plugins"}
USE_PLUGINS=${USE_PLUGINS:-"memory load time"}

# color aliases
WHITE="#ffffff"
ORANGE="#ff7f00"
RED="#ff0000"
YELLOW="#ffff00"
GREEN="#00ff00"
GREEN_LIGHT="#99ff99"
GRAY="#999999"

DEFAULT_COLOR=$WHITE
REFRESH_TIMEOUT=1 # in seconds

# IMPLEMENTATION
# value of reference variable (containing
function refval {
    echo $(eval "echo \$$1")
}

# config timeouts
function config_timeout_var {
    echo "${1^^}_TIMEOUT"
}

function get_config_timeout {
    timeout=
    timeout=$(refval $(config_timeout_var $1))
    if [ -z "$timeout" ]; then
	echo "$REFRESH_TIMEOUT"
    else
	echo "$timeout"
    fi
}

# timeouts (checking if refresh time for this plugin is out)
function timeout_var {
    echo "I3S_${1^^}_TIMEOUT"
}

function get_timeout {
    echo $(refval $(timeout_var $1))
}

function set_timeout {
    eval "$(timeout_var $1)=$2"
}

function check_expired {
    return `bc <<< "$1 > 0"`
}

# texts
function text_var {
    echo "i3s_$1_text"
}

function get_text {
    echo $(refval $(text_var $1))
}

function set_text {
    eval "$(text_var $1)='$2'"
}

# other
function plugin_file {
    echo "$1.sh"
}

function plugin_command {
    echo "i3s_$1"
}

# LOAD CONFIGURATION
[ -e "$GLOBAL_CONFIG_PATH" ] && source "$GLOBAL_CONFIG_PATH"
[ -e "$USER_CONFIG_PATH" ] && source "$USER_CONFIG_PATH"

for module in $USE_PLUGINS; do
    file="$PLUGINS_DIR/$(plugin_file "$module")"
    [ -e "$file" ] && source "$file" && set_timeout "$module" 0
done

# RUN
echo '{"version": 1}'
echo '['

while true
do
    text=$'[\n'
    comma=" "
    for module in $USE_PLUGINS
    do
	timeout=$(get_timeout "$module")
	new_timeout=`bc <<< "$timeout - $REFRESH_TIMEOUT"`
	if check_expired "$new_timeout"; then
	    plugin_text=$($(plugin_command "$module"))
	    set_text "$module" "$plugin_text"
	    set_timeout "$module" $(get_config_timeout "$module")
	else
	    plugin_text=$(get_text "$module")
	    set_timeout "$module" "$new_timeout"
	fi
	text+=" $comma$plugin_text"$'\n'
	comma=","
    done
    text+=$'],'
    echo "$text"
    sleep $REFRESH_TIMEOUT
done



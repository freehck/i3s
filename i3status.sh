#!/bin/bash

CONFIG_PATH="$HOME/.i3s.conf"
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

source "$CONFIG_PATH"

plugin_funcs=

function plugin_file {
    echo "$1.sh"
}

function plugin_command {
    echo "i3s_$1"
}

function plugin_text_var {
    echo "i3s_$1_text"
}

function load_plugins {
    for module in $USE_PLUGINS
    do
	if source "$PLUGINS_DIR"/`plugin_file "$module"`
	then
            plugin_funcs+=`plugin_command "$module"`" "
	fi
    done
}

load_plugins



echo '{"version": 1}'
echo '['

while true
do
    text=$'[\n'
    comma=" "
    for func in $plugin_funcs
    do
	text+=" $comma"`$func`$'\n'
	comma=","
    done
    text+=$'],\n'
    echo "$text"
    sleep 1
done



#!/usr/bin/env bash

# from https://github.com/dylanaraps/pure-bash-bible

# STRINGS

trim_string() {
    # Trim leading and trailing white-space from string
    # Usage: trim_string "   example   string    "
    # trim_string "    Hello,  World    "
    # Hello,  World
    # name="   John Black  "
    # trim_string "$name"
    # John Black

    : "${1#"${1%%[![:space:]]*}"}"
    : "${_%"${_##*[![:space:]]}"}"
    printf '%s\n' "$_"
}

# shellcheck disable=SC2086,SC2048
trim_all() {
    # Trim all white-space from string and truncate spaces
    # Usage: trim_all "    Hello,    World    "
    # Hello, World
    # Usage: name="   John   Black  is     my    name.    "
    # trim_all "$name"
    # John Black is my name.

    set -f
    set -- $*
    printf '%s\n' "$*"
    set +f
}

regex() {
    # Use regex on a string
    # Usage: Trim leading white-space.
    # regex '    hello' '^\s*(.*)'
    # hello

    # Validate a hex color.
    # $ regex "#FFFFFF" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
    # #FFFFFF

    # Validate a hex color (invalid).
    # regex "red" '^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$'
    # no output (invalid)
    
    [[ $1 =~ $2 ]] && printf '%s\n' "${BASH_REMATCH[1]}"
}

is_hex_color() {
    # Check if it is a hex color
    # Usage is_hex_color "$color" || color="#FFFFFF"

    if [[ $1 =~ ^(#?([a-fA-F0-9]{6}|[a-fA-F0-9]{3}))$ ]]; then
        printf '%s\n' "${BASH_REMATCH[1]}"
    else
        printf '%s\n' "error: $1 is an invalid color."
        return 1
    fi
}

split() {
    # Split a string on a delimiter
    # Usage: split "apples,oranges,pears,grapes" ","
    # apples
    # oranges
    # pears
    # grapes
    # Multi char delimiters work too!
    # split "hello---world---my---name---is---john" "---"
    # hello
    # world
    # my
    # name
    # is
    # john

    IFS=$'\n' read -d "" -ra arr <<< "${1//$2/$'\n'}"
    printf '%s\n' "${arr[@]}"
}

lower() {
    # Change a string to lowercase
    # Usage: lower "HELLO"
    # hello
    printf '%s\n' "${1,,}"
}

upper() {
    # Change a string to uppercase
    # upper "hello"
    # HELLO
    printf '%s\n' "${1^^}"
}

reverse_case() {
    # Reverse a string case
    # Usage: reverse_case "HeLlO"
    # hElLo
    printf '%s\n' "${1~~}"
}

trim_quotes() {
    # Trim quotes from a string
    # Usage: 
    # var="'Hello', \"World\""
    # trim_quotes "$var"
    # Hello, World
    
    : "${1//\'}"
    printf '%s\n' "${_//\"}"
}

strip_all() {
    # Strip all instances of pattern from string
    # Usage: strip_all "string" "pattern"
    # strip_all "The Quick Brown Fox" "[aeiou]"
    # Th Qck Brwn Fx

    # strip_all "The Quick Brown Fox" "[[:space:]]"
    # TheQuickBrownFox

    # strip_all "The Quick Brown Fox" "Quick "
    # The Brown Fox
    printf '%s\n' "${1//$2}"
}

strip() {
    # Strip first occurrence of pattern from string
    # Usage: 
    # strip "The Quick Brown Fox" "[aeiou]"
    # Th Quick Brown Fox

    # strip "The Quick Brown Fox" "[[:space:]]"
    # TheQuick Brown Fox

    printf '%s\n' "${1/$2}"
}

lstrip() {
    # Strip pattern from start of string
    # Usage: lstrip "The Quick Brown Fox" "The "
    # Quick Brown Fox

    printf '%s\n' "${1##$2}"
}

rstrip() {
    # Strip pattern from end of string
    # Usage: rstrip "The Quick Brown Fox" " Fox"
    # The Quick Brown
    printf '%s\n' "${1%%$2}"
}

urlencode() {
    # Percent-encode a string
    # Usage: urlencode "https://github.com/dylanaraps/pure-bash-bible"
    # https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible

    local LC_ALL=C
    for (( i = 0; i < ${#1}; i++ )); do
        : "${1:i:1}"
        case "$_" in
            [a-zA-Z0-9.~_-])
                printf '%s' "$_"
            ;;

            *)
                printf '%%%02X' "'$_"
            ;;
        esac
    done
    printf '\n'
}

urldecode() {
    # Decode a percent-encoded string
    # Usage: urldecode "string"
    # urldecode "https%3A%2F%2Fgithub.com%2Fdylanaraps%2Fpure-bash-bible"
    # https://github.com/dylanaraps/pure-bash-bible

    : "${1//+/ }"
    printf '%b\n' "${_//%/\\x}"
}

reverse_array() {
    # Reverse an array
    # Usage: reverse_array 1 2 3 4 5
    # 5
    # 4
    # 3
    # 2
    # 1
    # arr=(red blue green)
    # reverse_array "${arr[@]}"
    # green
    # blue
    # red
    shopt -s extdebug
    f()(printf '%s\n' "${BASH_ARGV[@]}"); f "$@"
    shopt -u extdebug
}

remove_array_dups() {
    # Remove duplicate array elements
    # Usage: remove_array_dups "array"
    # remove_array_dups 1 1 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5 5
    # 1
    # 2
    # 3
    # 4
    # 5
    # arr=(red red green blue blue)
    # remove_array_dups "${arr[@]}"
    # red
    # green
    # blue
    declare -A tmp_array

    for i in "$@"; do
        [[ $i ]] && IFS=" " tmp_array["${i:- }"]=1
    done

    printf '%s\n' "${!tmp_array[@]}"
}

random_array_element() {
    # Random array element
    # Usage: array=(red green blue yellow brown)
    # random_array_element "${array[@]}"
    # yellow

    # Multiple arguments can also be passed.
    # random_array_element 1 2 3 4 5 6 7
    # 3

    local arr=("$@")
    printf '%s\n' "${arr[RANDOM % $#]}"
}

head() {
    # Get the first N lines of a file
    # Usage: head 2 ~/.bashrc
    # Prompt
    # PS1='➜ '

    # head 1 ~/.bashrc
    # Prompt

    mapfile -tn "$1" line < "$2"
    printf '%s\n' "${line[@]}"
}

tail() {
    # Get the last N lines of a file
    # Usage: tail 2 ~/.bashrc
    # Enable tmux.
    # [[ -z "$TMUX"  ]] && exec tmux

    # tail 1 ~/.bashrc
    # [[ -z "$TMUX"  ]] && exec tmux

    mapfile -tn 0 line < "$2"
    printf '%s\n' "${line[@]: -$1}"
}

lines() {
    # Get the number of lines in a file
    # Usage: lines ~/.bashrc
    # 48

    # lines_loop ~/.bashrc
    # 48

    mapfile -tn 0 lines < "$1"
    printf '%s\n' "${#lines[@]}"
}

count() {
    # Count files or directories in directory
    # Usage: count /path/to/dir/*
    #        count /path/to/dir/*/
    # Count all files in dir.
    # count ~/Downloads/*
    # 232

    # Count all dirs in dir.
    # count ~/Downloads/*/
    # 45

    # Count all jpg files in dir.
    # count ~/Pictures/*.jpg
    # 64

    printf '%s\n' "$#"
}

extract() {
    # Extract lines between two markers
    # Usage: 
    # Extract code blocks from MarkDown file.
    # extract ~/projects/pure-bash/README.md '```sh' '```'
    # Output here...

    while IFS=$'\n' read -r line; do
        [[ $extract && $line != "$3" ]] &&
            printf '%s\n' "$line"

        [[ $line == "$2" ]] && extract=1
        [[ $line == "$3" ]] && extract=
    done < "$1"
}


dirname() {
    # Get the directory name of a file path
    # Usage: dirname ~/Pictures/Wallpapers/1.jpg
    # /home/black/Pictures/Wallpapers

    # dirname ~/Pictures/Downloads/
    # /home/black/Pictures

    local tmp=${1:-.}

    [[ $tmp != *[!/]* ]] && {
        printf '/\n'
        return
    }

    tmp=${tmp%%"${tmp##*[!/]}"}

    [[ $tmp != */* ]] && {
        printf '.\n'
        return
    }

    tmp=${tmp%/*}
    tmp=${tmp%%"${tmp##*[!/]}"}

    printf '%s\n' "${tmp:-/}"
}


# basename() {
#     # Get the base-name of a file path
#     # Usage: basename "path" ["suffix"]
#     # basename ~/Pictures/Wallpapers/1.jpg
#     # 1.jpg

#     # basename ~/Pictures/Wallpapers/1.jpg .jpg
#     # 1

#     # basename ~/Pictures/Downloads/
#     # Downloads

#     local tmp

#     tmp=${1%"${1##*[!/]}"}
#     tmp=${tmp##*/}
#     tmp=${tmp%"${2/"$tmp"}"}

#     printf '%s\n' "${tmp:-/}"
# }


get_window_size() {
    # Get the terminal size in pixels
    # Usage: 
    # Output: WIDTHxHEIGHT
    # get_window_size
    # 1200x800

    # Output (fail):
    # get_window_size
    # x

    printf '%b' "${TMUX:+\\ePtmux;\\e}\\e[14t${TMUX:+\\e\\\\}"
    IFS=';t' read -d t -t 0.05 -sra term_size
    printf '%s\n' "${term_size[1]}x${term_size[2]}"
}

get_cursor_pos() {
    # Get the current cursor position
    # Usage: 
    # Output: X Y
    # get_cursor_pos
    # 1 8

    IFS='[;' read -p $'\e[6n' -d R -rs _ y x _
    printf '%s\n' "$x $y"
}

hex_to_rgb() {
    # Convert a hex color to RGB
    # Usage: hex_to_rgb "#FFFFFF"
    # 255 255 255

    : "${1/\#}"
    ((r=16#${_:0:2},g=16#${_:2:2},b=16#${_:4:2}))
    printf '%s\n' "$r $g $b"
}

rgb_to_hex() {
    # Convert an RGB color to hex
    # Usage: rgb_to_hex "255" "255" "255"
    # #FFFFFF

    printf '#%02x%02x%02x\n' "$1" "$2" "$3"
}

date() {
    # Get the current date using strftime
    # Usage: date "format"
    # See: 'man strftime' for format.
    # Using above function.
    # date "%a %d %b  - %l:%M %p"
    # Fri 15 Jun  - 10:00 AM

    # Using printf directly.
    # printf '%(%a %d %b  - %l:%M %p)T\n' "-1"
    # Fri 15 Jun  - 10:00 AM

    # Assigning a variable using printf.
    # printf -v date '%(%a %d %b  - %l:%M %p)T\n' '-1'
    # printf '%s\n' "$date"
    # Fri 15 Jun  - 10:00 AM

    printf "%($1)T\\n" "-1"
}


uuid() {
    # Generate a UUID V4
    # Usage:
    # uuid
    # d5b6c731-1310-4c24-9fe3-55d556d44374

    C="89ab"

    for ((N=0;N<16;++N)); do
        B="$((RANDOM%256))"

        case "$N" in
            6)  printf '4%x' "$((B%16))" ;;
            8)  printf '%c%x' "${C:$RANDOM%${#C}:1}" "$((B%16))" ;;
            3|5|7|9)
                printf '%02x-' "$B"
            ;;
            *)
                printf '%02x' "$B"
            ;;
        esac
    done
    printf '\n'
}


bar() {
    # Progress bars
    # Usage: bar 1 10
    #            ^----- Elapsed Percentage (0-100).
    #               ^-- Total length in chars.
    # for ((i=0;i<=100;i++)); do
    # Pure bash micro sleeps (for the example).
    # (:;:) && (:;:) && (:;:) && (:;:) && (:;:)

    # Print the bar.
    # bar "$i" "10"
    # done

    # printf '\n'

    ((elapsed=$1*$2/100))

    # Create the bar with spaces.
    printf -v prog  "%${elapsed}s"
    printf -v total "%$(($2-elapsed))s"

    printf '%s\r' "[${prog// /-}${total}]"
}


# get_functions() {
#     # Get the list of functions in a script
#     # Usage: get_functions
#     IFS=$'\n' read -d "" -ra functions < (declare -F)
#     printf '%s\n' "${functions[@]//declare -f }"
# }


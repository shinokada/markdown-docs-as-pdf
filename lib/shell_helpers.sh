#!/bin/sh

# from https://github.com/dylanaraps/pure-sh-bible

# STRINGS
lstrip() {
    # Strip pattern from start of string
    # Usage: lstrip "string" "pattern"
    # lstrip "The Quick Brown Fox" "The "
    # Quick Brown Fox

    printf '%s\n' "${1##$2}"
}

rstrip() {
    # Strip pattern from end of string
    # Usage: rstrip "string" "pattern"
    # rstrip "The Quick Brown Fox" " Fox"
    # The Quick Brown

    printf '%s\n' "${1%%$2}"
}

trim_string() {
    # Trim leading and trailing white-space from string
    # Usage: trim_string "    Hello,  World    "
    # Hello,  World
    # Usage: name="   John Black  "
    # trim_string "$name"
    # John Black

    # Remove all leading white-space.
    # '${1%%[![:space:]]*}': Strip everything but leading white-space.
    # '${1#${XXX}}': Remove the white-space from the start of the string.
    trim=${1#${1%%[![:space:]]*}}

    # Remove all trailing white-space.
    # '${trim##*[![:space:]]}': Strip everything but trailing white-space.
    # '${trim%${XXX}}': Remove the white-space from the end of the string.
    trim=${trim%${trim##*[![:space:]]}}

    printf '%s\n' "$trim"
}

# shellcheck disable=SC2086,SC2048
trim_all() {
    # Trim all white-space from string and truncate spaces
    # Usage:  trim_all "    Hello,    World    "
    # Hello, World
    # Usage : name="   John   Black  is     my    name.    "
    # trim_all "$name"
    # John Black is my name.

    # Disable globbing to make the word-splitting below safe.
    set -f

    # Set the argument list to the word-splitted string.
    # This removes all leading/trailing white-space and reduces
    # all instances of multiple spaces to a single ("  " -> " ").
    set -- $*

    # Print the argument list as a string.
    printf '%s\n' "$*"

    # Re-enable globbing.
    set +f
}

split() {
    # Split a string on a delimiter
    # Usage: split "apples,oranges,pears,grapes" ","
    # apples
    # oranges
    # pears
    # grapes

    # Usage: split "1, 2, 3, 4, 5" ", "
    # 1
    # 2
    # 3
    # 4
    # 5

    # Disable globbing.
    # This ensures that the word-splitting is safe.
    set -f

    # Store the current value of 'IFS' so we
    # can restore it later.
    old_ifs=$IFS

    # Change the field separator to what we're
    # splitting on.
    IFS=$2

    # Create an argument list splitting at each
    # occurance of '$2'.
    #
    # This is safe to disable as it just warns against
    # word-splitting which is the behavior we expect.
    # shellcheck disable=2086
    set -- $1

    # Print each list value on its own line.
    printf '%s\n' "$@"

    # Restore the value of 'IFS'.
    IFS=$old_ifs

    # Re-enable globbing.
    set +f
}

trim_quotes() {
    # Trim quotes from a string
    # Usage: var="'Hello', \"World\""
    # trim_quotes "$var"
    # Hello, World

    # Disable globbing.
    # This makes the word-splitting below safe.
    set -f

    # Store the current value of 'IFS' so we
    # can restore it later.
    old_ifs=$IFS

    # Set 'IFS' to ["'].
    IFS=\"\'

    # Create an argument list, splitting the
    # string at ["'].
    #
    # Disable this shellcheck error as it only
    # warns about word-splitting which we expect.
    # shellcheck disable=2086
    set -- $1

    # Set 'IFS' to blank to remove spaces left
    # by the removal of ["'].
    IFS=

    # Print the quote-less string.
    printf '%s\n' "$*"

    # Restore the value of 'IFS'.
    IFS=$old_ifs

    # Re-enable globbing.
    set +f
}

# FILES
head() {
    # Get the first N lines of a file
    # Usage: head "n" "file"
    # head 2 ~/.bashrc
    # Prompt
    # PS1='➜ '

    while IFS= read -r line; do
        printf '%s\n' "$line"
        i=$((i + 1))
        [ "$i" = "$1" ] && return
    done <"$2"

    # 'read' used in a loop will skip over
    # the last line of a file if it does not contain
    # a newline and instead contains EOF.
    #
    # The final line iteration is skipped as 'read'
    # exits with '1' when it hits EOF. 'read' however,
    # still populates the variable.
    #
    # This ensures that the final line is always printed
    # if applicable.
    [ -n "$line" ] && printf %s "$line"
}

lines() {
    # Get the number of lines in a file
    # Usage: lines "file"
    # lines ~/.bashrc
    # 48

    # '|| [ -n "$line" ]': This ensures that lines
    # ending with EOL instead of a newline are still
    # operated on in the loop.
    #
    # 'read' exits with '1' when it sees EOL and
    # without the added test, the line isn't sent
    # to the loop.
    while IFS= read -r line || [ -n "$line" ]; do
        lines=$((lines + 1))
    done <"$1"

    printf '%s\n' "$lines"
}

count() {
    # Count files or directories in directory
    # Usage: count /path/to/dir/*
    #        count /path/to/dir/*/
    #  count ~/Downloads/*
    # 232

    [ -e "$1" ] &&
        printf '%s\n' "$#" ||
        printf '%s\n' 0
    # find "$@" -type f | wc -l
}

# FILE PATHS
dirname() {
    # Get the directory name of a file path
    # Usage: dirname "path"
    # dirname $HOME/Pictures/Wallpapers/1.jpg
    # $HOME/Pictures/Wallpapers

    # Usage: dirname $HOME/Pictures/Downloads/
    # $HOME/Pictures
    
    # If '$1' is empty set 'dir' to '.', else '$1'.
    dir=${1:-.}

    # Strip all trailing forward-slashes '/' from
    # the end of the string.
    #
    # "${dir##*[!/]}": Remove all non-forward-slashes
    # from the start of the string, leaving us with only
    # the trailing slashes.
    # "${dir%%"${}"}": Remove the result of the above
    # substitution (a string of forward slashes) from the
    # end of the original string.
    dir=${dir%%"${dir##*[!/]}"}

    # If the variable *does not* contain any forward slashes
    # set its value to '.'.
    [ "${dir##*/*}" ] && dir=.

    # Remove everything *after* the last forward-slash '/'.
    dir=${dir%/*}

    # Again, strip all trailing forward-slashes '/' from
    # the end of the string (see above).
    dir=${dir%%"${dir##*[!/]}"}

    # Print the resulting string and if it is empty,
    # print '/'.
    printf '%s\n' "${dir:-/}"
}

basename() {
    # Get the base-name of a file path
    # Usage: basename "path" ["suffix"]
    # basename ~/Pictures/Wallpapers/1.jpg
    # 1.jpg
    # basename ~/Pictures/Wallpapers/1.jpg .jpg
    # 1
    # basename ~/Pictures/Downloads/
    # Downloads

    # Strip all trailing forward-slashes '/' from
    # the end of the string.
    #
    # "${1##*[!/]}": Remove all non-forward-slashes
    # from the start of the string, leaving us with only
    # the trailing slashes.
    # "${1%%"${}"}:  Remove the result of the above
    # substitution (a string of forward slashes) from the
    # end of the original string.
    dir=${1%${1##*[!/]}}

    # Remove everything before the final forward-slash '/'.
    dir=${dir##*/}

    # If a suffix was passed to the function, remove it from
    # the end of the resulting string.
    dir=${dir%"$2"}

    # Print the resulting string and if it is empty,
    # print '/'.
    printf '%s\n' "${dir:-/}"
}

# NUMBERS

is_float() {
    # Check if a number is a float
    # Usage: is_float "number"
    # is_float 1 && echo true
    # (error exit)
    # is_float 1.1 && echo true
    # true

    # The test checks to see that the input contains
    # a '.'. This filters out whole numbers.
    [ -z "${1##*.*}" ] &&
        printf %f "$1" >/dev/null 2>&1
}

is_int() {
    # Check if a number is an integer
    # usage: is_int "number"
    # is_int 1 && echo true
    # true
    # is_int 1.1 && echo true
    # (error exit)

    printf %d "$1" >/dev/null 2>&1
}

#!/usr/bin/env bash

set -e

master_key_path=./master_key
editor=${EDITOR:-"vim"}
master_key=$MASTER_KEY
command=$1
file=$2
tmpfile=`mktemp`

function usage() {
    echo 'credentials-edit 0.0.1'
    echo 'copyright @acro5piano'
    echo ''
    echo 'Usage: credentials-edit COMMAND FILE'
    echo ''
    echo 'Available commands:'
    echo '    create - create encrypted file from non-encrypted file'
    echo '    edit - decrypt file, edit, then encrypt again'
    echo '    print - decrypt file and print the content'

    exit 1
}

function create() {
    backupfile=`mktemp`
    openssl aes-256-cbc -a -e -k $master_key -in $file -out $tmpfile
    cp $file $backupfile
    cp $tmpfile $file
    echo "backup file is: $backupfile"
}

function edit() {
    openssl aes-256-cbc -a -d -k $master_key -in $file -out $tmpfile
    $editor $tmpfile
    openssl aes-256-cbc -a -e -k $master_key -in $tmpfile -out $file
}

function print() {
    openssl aes-256-cbc -a -d -k $master_key -in $file -out /dev/stdout
}


if [ -z "$command" ]; then
    usage
fi

if [ -z "$file" ]; then
    echo 'Error: No file specified.' 1>&2
    usage
fi

if [ -z "$master_key" ]; then
    if [ ! -e $master_key_path ]; then
        echo Error: Master key not found. please create $master_key_path or set $MASTER_KEY environemt variable.
        exit 2
    fi
    master_key=`cat master_key`
fi

case $1 in
    'create') create;;
    'edit') edit;;
    'print') print;;
    '*') usage 1>&2;
esac

#! /bin/bash

function viajesProlog () {

    if [[ -e 'viajes.exe' ]]; then
        echo 'Removing old "viajes" executable.'
        rm viajes.exe
    fi
    echo 'Compiling prolog...'
    swipl -O -g solve --stand_alone=true -o viajes.exe -c viajes.pl
    echo 'Running "viajes" problem'
    ./viajes.exe

}

function usage () {

    echo 'Usage: script.sh option problem_name'
    echo 'available options:'
    echo '  -p  solve viajes problem'
    echo '  -h  display this help '
    echo ''
    echo 'available problems:'
    echo '  viajes.pl'

}

while getopts "hp:" opt; do
    case $opt in
    p)
        viajesProlog
        ;;
    h)
        usage
        exit 0
        ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
    esac
done

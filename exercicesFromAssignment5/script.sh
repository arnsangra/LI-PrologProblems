#! /bin/bash

function viajes_prolog () {

    if [[ -e 'viajes.exe' ]]; then
        echo 'Removing old "viajes" executable.'
        rm viajes.exe
    fi
    echo 'Compiling prolog...'
    swipl -O -g solve --stand_alone=true -o viajes.exe -c viajes.pl
    echo 'Running "viajes" problem'
    ./viajes.exe

}

function viajes_picosat () {
    if [[ -e 'viajes_picosat.exe' ]]; then
        echo 'Removing old "viajes_picosat" executable.'
        rm viajes_picosat.exe
    fi
    echo 'Compiling prolog...'
    echo 'Running "viajes_picosat" problem, make sure to have picosat installed'
    swipl -O -g main --stand_alone=true -o viajes_picosat.exe -c viajes_picosat.pl
    ./viajes_picosat.exe

}

function usage () {

    echo 'Usage: script.sh option problem_name'
    echo 'available options:'
    echo '  -p  solve viajes problem'
    echo '  -h  display this help '
    echo ''
    echo 'available problems:'
    echo '  viajes.pl'
    echo '  viajes_picosat.pl'

}

while getopts "hp:" opt; do
    case $opt in
    p)
        if[[ $opt =~ "viajes.pl"]]; then
            viajes_prolog
        elif [[ $opt =~ "viajes_picosat.pl" ]]; then
            viajes_picosat
        else
            echo "unknown problem"
            exit 1
        fi
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

#! /bin/bash

# this script is intended to assist the compilation and execution of the different practices
# for the 3 first problems, it merges the core file with the specific predicate for the problem.



function prob_apart_A () {

    echo $1
    if [[ -e 'run.pl' ]]; then
	echo 'Removing old source and executable.'
	rm run.pl a.out
    fi

    echo 'Merging source files..'
    cat core.pl >> run.pl
    cat $1 >> run.pl

    echo 'Compiling prolog...'
    swipl -O -g solucionOptima --stand_alone=true -o a.out -c run.pl
    echo "Running prolog --> run.pl with instance $1"
    ./a.out

}

function prob_apart_B () {

    if [[ -e 'run.pl' ]]; then
	echo 'Removing old talks executable.'
	rm talks.exe
    fi
    echo 'Compiling prolog...'
    swipl -O -g solve --stand_alone=true -o talks.exe -c talks.pl
    echo 'Running talks problem'
    ./talks.exe

}

function usage () {

    echo 'Usage: script.sh option problem_name'
    echo ''
    echo 'available options:'
    echo '	-p 	solve problem'
    echo '	-h	display this help '
    echo ''
    echo 'available problems:'
    echo '	do_water.pl'
    echo '	bridge.pl'
    echo '	canoe.pl'
    echo '	talks.pl'

}

while getopts "hp:" opt; do
    case $opt in
	p)
	    echo $OPTARG
	    if [[ $OPTARG =~ 'do_water.pl' || $OPTARG =~ 'brigde.pl' || $OPTARG =~ 'canoe.pl' ]]; then
		prob_apart_A $OPTARG
	    else
		prob_apart_B
	    fi
	    ;;
	h)
	    usage
	    exit 0
	    ;;
	\?)
	    echo \?
	    usage
	    exit 0
	    ;;
    esac
done


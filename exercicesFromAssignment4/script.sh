#! /bin/bash

if [[ $# -ne 1 ]]; then
	echo "Usage: script.sh problem_name"
else
	if [[ -e "run.pl" ]]; then
		echo 'Removing old source and executable.'
		rm run.pl a.out
	fi
	echo 'Merging source files..'
	cat core.pl >> run.pl
	cat $1 >> run.pl
	echo 'Compiling prolog...'
	swipl -O -g solucionOptima --stand_alone=true -o a.out -c run.pl
	echo 'Running prolog --> run.pl'
	./a.out
fi
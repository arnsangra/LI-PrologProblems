#! /bin/bash

if [[ $# -ne 1 ]]; then
	echo "Usage:"
else
	if [[ -e "run.pl" ]]; then
		rm run.pl a.out
	fi
	cat core.pl >> run.pl
	cat $1 >> run.pl
	# subl run.pl
	swipl -O -g solucionOptima --stand_alone=true -o a.out -c run.pl
	./a.out
fi
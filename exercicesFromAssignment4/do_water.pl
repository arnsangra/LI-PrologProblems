% mandatory commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

%% *********************************************************************************************** %
%%                                                                                                 *
%%                                       Lògica a la Informàtica                                   *
%%    \_____________________________________________________________________________________/      *
%%    /                                                                                     \      *
%%                                        DO_WATER 4th ASSIGN.                                     *
%%                                      07/05/2015, Qm Primavera                                   *
%%                                                                                                 *
%%                                                                                                 *
%% *************************************************************************************************
%%                                                                                                 *
%%                                        Arnau Sangrà Rocamora                                    *
%%                                                                                                 *
%% *********************************************************************************************** %


%%%%%%%%%%%%%%%%%%%%%%%%%%%

% set bucket capacity:
smallBucketFilled(5).
bigBucketFilled(8).

% small bucket fill
unPaso([_,RB], [LB,RB]):-
	smallBucketFilled(LB).

% big bucket fill
unPaso([LB,_], [LB,RB]):-
	bigBucketFilled(RB).

% empty bucket
unPaso([_,RB], [0,RB]).
unPaso([LB,_], [LB,0]).

% pour all LB to RB bucket
unPaso([LB,RB], [0,RBfilled]):-
	RBfilled is LB + RB,
	bigBucketFilled(MaxRB),
	RBfilled =< MaxRB.

% pour some LB to RB
unPaso([LB,RB], [RemainingLB,RBfilled]):-
	bigBucketFilled(RBfilled),
	LB + RB > RBfilled,
	Poured is RBfilled - RB,
	RemainingLB is LB - Poured.

% pour all RB to LB bucket
unPaso([LB,RB], [LBfilled,0]):-
	LBfilled is LB + RB,
	smallBucketFilled(MaxLB),
	LBfilled =< MaxLB.

% pour some RB to LB
unPaso([LB,RB], [LBfilled,RemainingRB]):-
	smallBucketFilled(LBfilled),
	LB + RB > LBfilled,
	Poured is LBfilled - LB,
	RemainingRB is RB - Poured.

solucionOptima:-
	nat(N),
	camino([0,0],[0,4],[[0,0]],C),
	length(C,N),
	write('Minimum steps: '), write(N), nl,
	write(C), nl,
	halt.

%%%%%%%%%%%%%%%%%%%

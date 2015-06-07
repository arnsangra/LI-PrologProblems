% mandatory commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

%% *********************************************************************************************** %
%%                                                                                                 *
%%                                       Lògica a la Informàtica                                   *
%%    \_____________________________________________________________________________________/      *
%%    /                                                                                     \      *
%% 		                                   EXERCICES 2nd ASSIG.                                    *
%%                                      07/05/2015, Qm Primavera                                   *
%%                                                                                                 *
%%                                                                                                 *
%% *************************************************************************************************
%%                                                                                                 *
%%                                        Arnau Sangrà Rocamora                                    *
%%                                                                                                 *
%% *********************************************************************************************** %

% 2
prod([],1).
prod([H|L],P):-
	prod(L, Accum),
	P is Accum * H.

% 3
pescalar([],[],0).
pescalar([L1H|L1T],[L2H|L2T],P):-
	pescalar(L1T,L2T, Esc),
	P is Esc + (L1H * L2H).

% 4, sets: union & intersection
intersection([],_,[]).
intersection([L1H|L1T],L2, [L1H|I]):-
	member(L1H,L2),!,
	intersection(L1T, L2, I).
intersection([_|L1T],L2, I):-
	intersection(L1T, L2, I).

union([],[],[]).

% 5 last & reverse list using concat
concat([],L,L).
concat([X|L1],L2,[X|L3]):-
	concat(L1,L2,L3).

last([A],A).
last([A|LT],T):-
	last(LT,T).

last2(L,X):-
	concat(_,[X],L).

reverse(L,RL):-
	concat( , , )


% 6 fib
fib(0,1).
fib(1,1).
fib(N,F):-
	N > 1,
	N1 is N - 1,
	N2 is N - 2,
	fib(N1,F1),
	fib(N2,F2),!,
	F is F1 + F2.


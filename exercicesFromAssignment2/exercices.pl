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
intersection([L1H|L1T],L2, [L1H|I]):-An FPT Algorithm for Set Splitting
	member(L1H,L2),!,
	intersection(L1T, L2, I).
intersection([_|L1T],L2, I):-
	intersection(L1T, L2, I).

union([],[],[]).

% 5 last & reverse list using concat
last([A],A).
last([A|LT],T):-
	last(LT,T).


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


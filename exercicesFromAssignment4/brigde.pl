% mandatory prolog commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

bridgeCapacity(2).

people([1,2,5,8]).

mysubset([], []).
mysubset([E|Tail], [E|NTail]):-
  mysubset(Tail, NTail).
mysubset([_|Tail], NTail):-
  mysubset(Tail, NTail).

mywrite([]):- nl.
mywrite([X|XS]):-
	write(X),nl,
	mywrite(XS).


move(LsrcB,LdstB,Cb,LsrcA,LdstA,Ca):-
	bridgeCapacity(MaxBridge),
	between(1,MaxBridge,K),
	mysubset(LsrcB,S),
	length(S,K),
	subtract(LsrcB,S,LsrcA),
	append(LdstB,S,LdstA),
	max_list(S,Slowest),
	Ca is Cb + Slowest.

% from left to right
unPaso([0,Lb,Rb,Cb,N],[1,La,Ra,Ca,N]):-
	move(Lb,Rb,Cb,La,Ra,Ca),
	Ca =< N.

% from
unPaso([1,Lb,Rb,Cb,N],[0,La,Ra,Ca,N]):-
	move(Rb,Lb,Cb,Ra,La,Ca),
	Ca =< N.

solucionOptima:-
	nat(N),
	people(Li),
	camino([0,Li,[],0,N],[1,[],_,C,N],[[0,Li,[],0,N]],L),
	mywrite(L), nl,
	halt.

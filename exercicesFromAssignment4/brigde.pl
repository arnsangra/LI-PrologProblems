%%%%%%%%%%%%%%%%%%%%%%%%%

bridgeCapacity(2).

people([1,2,5,8]).

move(LsrcB,LdstB,Cb,LsrcA,LdstA,Ca):-
	bridgeCapacity(MaxBridge),
	between(1,MaxBridge,K),
	subset(LsrcB,S),
	length(S,K),
	subtract(LsrcB,S,LsrcA),
	append(LdstB,S,LdstA),
	sum(S,Sum),
	Ca is Cb + Sum.

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
	write(L), nl,
	halt.

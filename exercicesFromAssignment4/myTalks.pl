getList(0,_,[]).
getList(Length,Number,List):-
	Length > 0,
	L is Length - 1,
	getList(L,Number,L2),
	append(L2,[Number],List).



getPermutation(0,0,0,[]):-!.

getPermutation(K,K2,K3,L):-
	K > 0,
	NK is K - 1,
	getPermutation(NK,K2,K3,LR),
	append([1],LR,L).
getPermutation(K,K2,K3,L):-
	K2 > 0,
	NK is K2 - 1,
	getPermutation(K,NK,K3,LR),
	append([2],LR,L).

getPermutation(K,K2,K3,L):-
	K3 > 0,
	NK is K3 - 1,
	getPermutation(K,K2,NK,LR),
	append([3],LR,L).



possibilities(LRES):-
	between(0,9,K),
	MAX2 is 9 - K,
	between(0,MAX2,K2),
	MAX3 is 9 - K - K2,
	between(0,MAX3,K3),
	getPermutation(K3,K2,K,LRES),
	length(LRES,9).


mysubset([], []).
mysubset([E|Tail], [E|NTail]):-
  mysubset(Tail, NTail).
mysubset([_|Tail], NTail):-
  mysubset(Tail, NTail).






magicAppend(K,SS,N,L2,L):-
	member(K,SS),
	!,
	append([N],L2,L).
magicAppend(K,SS,_,L2,L2):-
	\+member(K,SS).



distribution([],[],[],[],[]).
distribution([N|NS],[X|XS],A,B,C):-
	distribution(NS,XS,A2,B2,C2),
	mysubset([1,2,3],SS),
	length(SS,X),
	magicAppend(1,SS,N,A2,A),
	magicAppend(2,SS,N,B2,B),
	magicAppend(3,SS,N,C2,C).

assignments(A,B,C):-
	possibilities(L),
	distribution([1,2,3,4,5,6,7,8,9],L,A,B,C),
	fail.
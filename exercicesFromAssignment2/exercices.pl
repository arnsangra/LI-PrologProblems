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





%% *********************************************************************************************** %
%% **********************************	UTILS:

pert(X,[X|_]).
pert(X,[_|L]):- pert(X,L).

pert_con_resto(X,L,Resto):-
	concat(L1,[X|L2],L),
	concat(L1,L2,Resto).

sumaLista([], S):- S is 0.
sumaLista([H | Tail], S):-
	sumaLista(Tail, Tmp),
	S is Tmp + H.

permutacion([],[]).
permutacion(L,[X|P]) :- pert_con_resto(X,L,R), permutacion(R,P).

mySubset([], []).
mySubset([ Head | Tail], [ Head | NTail]):-
  mySubset(Tail, NTail).
mySubset([ _ | Tail], NTail):-
  mySubset(Tail, NTail).

%% *********************************************************************************************** %
%% **********************************	EXERCICES:

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

union([],L,L).
union([X|L1],L2,   L3 ):-
	pert(X,L2),!,
	union(L1,L2,L3).
union([X|L1],L2,[X|L3]):-
	union(L1,L2,L3).

% 5 last & reverse list using concat
concat([],L,L).
concat([X|L1],L2,[X|L3]):-
	concat(L1,L2,L3).

last([A],A).
last([_|LT],T):-
	last(LT,T).

myReverse([], []).
myReverse([H | Tail], RL):-
	myReverse(Tail, Tmp),
	concat(Tmp, [H], RL).

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

% 7 dados
dados(0,0,[]).
dados(P,N,[X | L]):-
	N > 0,
	between(1,6,X),
	R is P - X,
	M is N -1,
	dados(R,M,L).

% 8 suma demas
sumaDemas(L):-
	pert_con_resto(X, L, R),
	sumaLista(R,X),
	write(X), write(' puede ser obtenido mediante la suma de los demas'), !.

% 9 suma anteriores
sumaAnteriores(L):-
	concat(L1, [ X| _], L),
	sumaLista(L1, X),
	write(X), write(' puede ser obtenido mediante la suma de los anteriores'), !.

% 10 card, cardinalidad
card(L):-
	cardinalidad(L,C),
	write(C).

cardinalidad([],[]).
cardinalidad([X|L], [ [X, N1] | Cr] ):-
	cardinalidad(L, C),
	pert_con_resto([X, N], C, Cr),!,
	N1 is N + 1.

cardinalidad([X | L] , [ [X,1] | C] ):-
	cardinalidad(L,C).


% 11 esta ordenada
estaOrdenada([]).
estaOrdenada([_]):- !.
estaOrdenada([H,H_1|Tail]):-
	H =< H_1,
	estaOrdenada([H_1|Tail]).


% 12 ordenacion por selecion
ordenacionSeleccion(L1,L2):-
	permutation(L1,L2),
	estaOrdenada(L2).

% 13 coste:
% el coste de ordenacion es n! dado que el numero total de permutaciones es n!, esto estaOrdenada
% en el peor de los casos tendremos que generarlas todas. El coste de estaOrdenada es lineal,
% por lo que O(n!) > O(n), el coste del algoritmo es O(n!).

% 14 ordenacion por Insercion
ordenacionInsercion([], []).
ordenacionInsercion([X | Tail], Ordenada):-
  ordenacionInsercion(Tail, Tmp),
  insercion(X, Tmp, Ordenada),!.

insercion(X, [], [ X ]).
insercion(X, [ Y | L], [ X, Y | L]):-
  X =< Y.
insercion(X, [ Y | L], [ Y | LL]):-
  X > Y,
  insercion(X, L, LL).

% 15 coste:
% ordenacion por insercion tiene un coste n^2,
% dado que si insertamos un elemento en una lista ordenada, como maximo recorremos tantos elementos
% como tiene la lista. ademas la ordenacion por insercion va insertando primero en una lista vacia, luego
% en una lista con un elemento y asi sucesivamente, por lo que O( (n*(n-1))/2 ) === O(n^2).

% 16 merge sort
split([],[],[]):-!.
split(Lista,Izquierda,Derecha):-
    concat(Izquierda,Derecha,Lista),
    length(Izquierda,ElemIzda),
    length(Derecha,ElemDcha),
    ElemIzda = ElemDcha, !.
split(Lista,Izquierda,Derecha):-
    concat(Izquierda,Derecha,Lista),
    length(Izquierda,ElemIzda),
    length(Derecha,ElemDcha),
    ElemDcha1 is ElemDcha + 1,
    ElemIzda = ElemDcha1, !.

merge(L, [], L):- !.
merge([], L, L):- !.
merge([HL | L], [HR | R], [HL | Ordenada]):-
    HL =< HR, !,
    merge(L, [HR | R], Ordenada).
merge([HL | L], [HR | R], [HR | Ordenada]):-
    merge([HL | L], R, Ordenada).

mergeSort([],[]):- !.
mergeSort([X],[X]):- !.
mergeSort(Lista,ListaOrdenada):-
    split(Lista,L,R),
    mergeSort(L,LL),
    mergeSort(R,RR),
    merge(LL,RR,ListaOrdenada).

% 17 diccionario
diccionario(L, N):-
	findWords(L, N, Word),
	write(Word), write(' '), fail.

findWords(_, 0, []):- !.
findWords(L, N, [X | Word]):-
	member(X,L),
	N1 is N-1,
	findWords(L, N1, Word).

% 18
listaPalindromo([]).
listaPalindromo([_]):- !.
listaPalindromo([X|L]):- concat(L1,[X],L), listaPalindromo(L1).

palindromos(L):-
	setof(P,(permutation(L,P), listaPalindromo(P)),S),
	write(S).

% 19
% no se com fer-lo.


% 20
deriva(X,X,1):-!.
deriva(C,_,0):- number(C).
deriva(A+B,X,DA+DB):-         deriva(A,X,DA),deriva(B,X,DB).
deriva(A-B,X,DA-DB):-         deriva(A,X,DA),deriva(B,X,DB).
deriva(A*B,X,A*DB+B*DA):-     deriva(A,X,DA),deriva(B,X,DB).
deriva(sin(A),X,cos(A)*DA):-  deriva(A,X,DA).
deriva(cos(A),X,-sin(A)*DA):- deriva(A,X,DA).
deriva(eˆA,X,DA*eˆA):-        deriva(A,X,DA).
deriva(ln(A),X,DA*1/A):-      deriva(A,X,DA).


% 21 --> exercice canoe.pl from 4th assignment.
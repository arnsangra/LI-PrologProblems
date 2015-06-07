%

students( [[1,2,6],[1,6,7],[2,3,8],[6,7,9],[6,8,9],[1,2,4],[3,5,6],[3,5,7],
[5,6,8],[1,6,8],[4,7,9],[4,6,9],[1,4,6],[3,6,9],[2,3,5],[1,4,5],
[1,6,7],[6,7,8],[1,2,4],[1,5,7],[2,5,6],[2,3,5],[5,7,9],[1,6,8]] ).

nat(0).
nat(N):-
    nat(M),
    N is M+1.


solve:-
    students(Students),
    nat(N),
    genera(Students, N, [], [], [], A, B, C),
    display(A,B,C),
    halt.

genera([], _, A, B, C, A,B, C).
genera([Student | Tail], N, A, B, C, AF, BF, CF):-
    permutation(Student, P),
    inserted(P, A, B, C, Atemp, Btemp, Ctemp),
    cost(Atemp, Btemp, Ctemp, Cost),
    Cost =< N,
    genera(Tail, N, Atemp, Btemp, Ctemp, AF, BF, CF).

cost(A, B, C, Cost):-
    length(A, LA),
    length(B, LB),
    length(C, LC),
    Cost is LA + LB + LC.

inserted([X,Y,Z], A, B, C, Atemp, Btemp, Ctemp):-
    insert(X, A, Atemp),
    insert(Y, B, Btemp),
    insert(Z, C, Ctemp).

insert(Elem, L, L):-
    member(Elem, L),!.
insert(Elem, L, LF):-
    append([Elem], L, LF).

displayHead(Head):-
    write(Head).

displayTail([]).
displayTail([H | T]):-
    write(', '), write(H),
    displayTail(T).

displayList([]).
displayList([Head | Tail]):-
    displayHead(Head),
    displayTail(Tail).

display(A,B,C):-
    write('Slot A: '), displayList(A), nl,
    write('Slot B: '), displayList(B), nl,
    write('Slot C: '), displayList(C), nl.


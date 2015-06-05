students( [[1,2,6],[1,6,7],[2,3,8],[6,7,9],[6,8,9],[1,2,4],[3,5,6],[3,5,7],
[5,6,8],[1,6,8],[4,7,9],[4,6,9],[1,4,6],[3,6,9],[2,3,5],[1,4,5],
[1,6,7],[6,7,8],[1,2,4],[1,5,7],[2,5,6],[2,3,5],[5,7,9],[1,6,8]] ).

slotA([7, 6, 3, 1]).
slotB([5, 9, 6, 2]).
slotC([5, 4, 8, 7, 6]).

checkSolution([],_,_,_).
checkSolution([Student | Tail], A, B, C):-
    write('The student: '), write(Student),
    checkStudent(Student, A,B,C),
    checkSolution(Tail, A, B, C).

checkStudent([C1, C2, C3], A, B, C):-
    slot(C1, A, B, C, S1),
    slot(C2, A, B, C, S2),
    slot(C3, A, B, C, S3),
    S1 \= S2,
    S1 \= S3,
    S2 \= S3,!,
    write(' will attend to '), nl,
    write('  meeting '), write(C1), write(' on slot '), write(S1), nl,
    write('  meeting '), write(C2), write(' on slot '), write(S2), nl,
    write('  meeting '), write(C3), write(' on slot '), write(S3), nl.
checkStudent(_,_,_,_):- fail.

slot(Talk, A, _, _, a):-
    member(Talk, A).

slot(Talk, _, B, _, b):-
    member(Talk, B).

slot(Talk, _, _, C, c):-
    member(Talk, C).

slot(_, _, _, _, _):- fail.

main:-
    students(S),
    slotA(A),
    slotB(B),
    slotC(C),
    display(A, B, C),
    checkSolution(S, A, B, C),
    write('everything is OK, dont worry'), nl,
    halt.

main:-
    write('GO BACK TO SCHOOL, L00ser!'), nl,
    halt.


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
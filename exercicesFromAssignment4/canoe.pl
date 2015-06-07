% mandatory commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

%% *********************************************************************************************** %
%%                                                                                                 *
%%                                       Lògica a la Informàtica                                   *
%%    \_____________________________________________________________________________________/      *
%%    /                                                                                     \      *
%%                                          CANOE 4th ASSIGN.                                      *
%%                                      07/05/2015, Qm Primavera                                   *
%%                                                                                                 *
%%                                                                                                 *
%% *************************************************************************************************
%%                                                                                                 *
%%                                        Arnau Sangrà Rocamora                                    *
%%                                                                                                 *
%% *********************************************************************************************** %


% set the number of missionaries and cannibals and canoe capacity
missionary(3).
cannibal(3).
canoe(2).

alive(0,_).
alive(M,C):-
	M >= C.

% *Mra ~ Missionaries Right_side After...*
% canoe from left to right
unPaso([l,Mlb,Clb,Mrb,Crb],[r,Mla,Cla,Mra,Cra]):-
	canoe(Kmax),
	between(0,Mlb,Km),
	between(0,Clb,Kc),

	K is Km + Kc, 		% canoe passengers are the sum of M and C picked from left
	K >= 1,				% check canoe passengers capacity
	K =< Kmax,
	%% ensure nextState constraints
	Mla is Mlb - Km,
	Cla is Clb - Kc,
	alive(Mla,Cla),
	Mra is Mrb + Km,
	Cra is Crb + Kc,
	alive(Mra, Cra).

unPaso([r,Mlb,Clb,Mrb,Crb],[l,Mla,Cla,Mra,Cra]):-
	canoe(Kmax),
	between(0,Mrb,Km),
	between(0,Crb,Kc),

	K is Km + Kc, 		% canoe passengers are the sum of M and C picked from left
	K >= 1,				% check canoe passengers capacity
	K =< Kmax,
	%% ensure nextState constraints
	Mra is Mrb - Km,
	Cra is Crb - Kc,
	alive(Mra,Cra),
	Mla is Mlb + Km,
	Cla is Clb + Kc,
	alive(Mla,Cla).

solucionOptima:-
	nat(N),
	missionary(M),
	cannibal(C),
	camino([l,M,C,0,0],[r,0,0,M,C],[[l,M,C,0,0]],Ca),
	length(Ca,N),
	write(N),nl, write(Ca), nl,
	halt.

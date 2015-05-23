nat(0).
nat(N):-
	nat(M),
	N is M+1.	

camino(E,E, C,C).

camino(EstadoActual, EstadoFinal, CaminoHastaAhora, CaminoTotal):-
	unPaso(EstadoActual, EstadoSiguiente),
	\+member(EstadoSiguiente,CaminoHastaAhora),
	camino(EstadoSiguiente,EstadoFinal,[EstadoSiguiente|CaminoHastaAhora],CaminoTotal).

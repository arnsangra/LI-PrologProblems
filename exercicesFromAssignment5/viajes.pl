# Hay que resolver de dos maneras el siguiente problema:

# A) totalmente en Prolog
# B) mediante picosat


# Una família, de cara a planificar els propers viatges a realitzar, ha
# recopilat una llista de ciutats que els agradaria visitar. Per tal de
# decidir a quines viatjaran, han confeccionat una llista dels atractius
# que més valoren d'una ciutat: paisatges, gastronomia, cultura, etc..,
# i saben quins d'aquests atractius té cada ciutat.

# Donada tota aquesta informació, volen trobar el conjunt més petit de
# ciutats tals que cadascun dels possibles atractius estigui present en
# almenys una d'aquestes ciutat.

# Datos de entrada:

ciutats([paris,bangkok,montevideo,windhoek,male,delhi,reunion,lima,banff]).

interessos([paisatges,cultura,etnies,gastronomia,esport,relax]).

atractius( paris,     [cultura,gastronomia]      ).
atractius( bangkok,   [paisatges,relax,esport]   ).
atractius( montevideo,[gastronomia,relax]        ).
atractius( windhoek,  [etnies,paisatges]         ).
atractius( male,      [paisatges,relax,esport]   ).
atractius( delhi,     [cultura,etnies]           ).
atractius( reunion,   [esport,relax,gastronomia] ).
atractius( lima,      [paisatges,esport,cultura] ).
atractius( banff,     [esport,paisatges]         ).


solve:-
	ciutats(C),
	interessos(I),



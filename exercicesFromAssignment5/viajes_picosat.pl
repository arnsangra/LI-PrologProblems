% mandatory commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

%% *********************************************************************************************** %
%%                                                                                                 *
%%                                       Lògica a la Informàtica                                   *
%%    \_____________________________________________________________________________________/      *
%%    /                                                                                     \      *
%%                                       VIAJES (PICOSAT VERSION):                                 *
%%                                      07/05/2015, Qm Primavera                                   *
%%                                                                                                 *
%%                                                                                                 *
%% *************************************************************************************************
%%                                                                                                 *
%%                                        Arnau Sangrà Rocamora                                    *
%%                                                                                                 *
%% *********************************************************************************************** %

:-dynamic(varNumber/3).
:-dynamic(maxCities/1).
symbolicOutput(0).

destinations([paris,bangkok,montevideo,windhoek,male,delhi,reunion,lima,banff]).

travelRequirements([paisatges,cultura,etnies,gastronomia,esport,relax]).

cityAttractions( paris,     [cultura,gastronomia]      ).
cityAttractions( bangkok,   [paisatges,relax,esport]   ).
cityAttractions( montevideo,[gastronomia,relax]        ).
cityAttractions( windhoek,  [etnies,paisatges]         ).
cityAttractions( male,      [paisatges,relax,esport]   ).
cityAttractions( delhi,     [cultura,etnies]           ).
cityAttractions( reunion,   [esport,relax,gastronomia] ).
cityAttractions( lima,      [paisatges,esport,cultura] ).
cityAttractions( banff,     [esport,paisatges]         ).


writeClauses:-
    numberCitiesBounded,
    interestsBounded.

%-------------------------------------------------------------------------------
%-------------------------------    CONSTRAIN DESTINATIONS

% set limit over number of cities visitable
numberCitiesBounded:-
    destinations(Cities),
    maxNumCities(MaxCities),
    atMostK(Cities, MaxCities).

% given a list of cities, writes a clause contraining AMK.
atMostK(LCities, K) :-
    KMax is K + 1,
    mySubset(LCities, S),
    length(S,KMax),
    findall(\+Dest, member(Dest,S), Clause),
    writeClause(Clause),
    fail.
atMostK(_,_).

%-------------------------------------------------------------------------------
%-------------------------------    CONSTRAIN INTERESTS

% set limit to ensure all interests are accomplished
interestsBounded:-
    travelRequirements(Requirements),
    requirementsEnsured(Requirements).

% given a list of requirements, writes a clause ALO among cities that have such.
requirementsEnsured([]).
requirementsEnsured([Head | Tail]):-
    requirementsEnsured(Tail),
    destinations(Destinations),
    destinationHasInterest(Head, Destinations, Dest),
    writeClause(Dest).

% iterate over cities to find those with feature, add these to a DestinationsWithRequirement.
destinationHasInterest(_, [], []).
destinationHasInterest(Feature, [ City | Tail ], DestinationsWithRequirement):-
    destinationHasInterest(Feature, Tail, Tmp),
    cityAttractions(City, CityFeatures),
    member(Feature, CityFeatures),!,
    append([City], Tmp, DestinationsWithRequirement).
destinationHasInterest(Feature, [ _ | Tail ], DestinationsWithRequirement):-
    destinationHasInterest(Feature, Tail, DestinationsWithRequirement).


%-------------------------------------------------------------------------------
%-------------------------------    AUXILIARY PREDICATES:

% iterator, increase maxNumCities allowed
nat(0).
nat(N):-
    nat(X),
    N is X + 1.

% generate all possible subsets of a given set.
mySubset([], []).
mySubset([ Head | Tail], [ Head | NTail]):-
  mySubset(Tail, NTail).
mySubset([ _ | Tail], NTail):-
  mySubset(Tail, NTail).

% prepare clauses, execute picosat with the different constraints over maxNumCities
execution:-
    retractall(numClauses(_)),
    assert(numClauses(0)),
    tell(clauses), writeClauses, told,
    tell(header),  writeHeader,  told,
    unix('cat header clauses > infile.cnf'),
    unix('picosat -v -o model infile.cnf').

% read model from picosat execution
loadModel(M):-
    unix('rm header'), unix('rm clauses'), unix('rm infile.cnf'),
    see(model),readModel(M), seen,
    unix('rm model'), !.

% checks picosat's model correctness
modelValidation([]):-
    maxNumCities(K),
    retract(maxNumCities(K)),
    write('Empty model -> solution not found with only '), write(K), write(' cities.'), nl,
    fail.
modelValidation(M):-
    length(M,L),
    L > 0,
    maxNumCities(K),
    write('Solution found with '), write(K), write(' cities!'), nl,
    displaySol(M).

displaySol([]).
displaySol([H | Tail]):-
destinations(Destinations),
    nth1(H,Destinations, City),
    write('   -'), write(City), nl,
    displaySol(Tail).



%% ============================================================================= %%
% ================== No need to change the following: =============================

main:- symbolicOutput(1), !, writeClauses, halt. % escribir bonito, no ejecutar
main:-
    assert(numClauses(0)),
    assert(numVars(0)),

    nat(N),
    assert(maxNumCities(N)),

    execution,
    loadModel(Model),

    modelValidation(Model),
    halt.

var2num(T,N):- hash_term(T,Key), varNumber(Key,T,N),!.
var2num(T,N):- retract(numVars(N0)), N is N0+1, assert(numVars(N)), hash_term(T,Key),
    assert(varNumber(Key,T,N)), assert( num2var(N,T) ), !.

writeHeader:- numVars(N),numClauses(C),write('p cnf '),write(N), write(' '),write(C),nl.

countClause:-  retract(numClauses(N)), N1 is N+1, assert(numClauses(N1)),!.
writeClause([]):- symbolicOutput(1),!, nl.
writeClause([]):- countClause, write(0), nl.
writeClause([Lit|C]):- w(Lit), writeClause(C),!.
w( Lit ):- symbolicOutput(1), write(Lit), write(' '),!.
w(\+Var):- var2num(Var,N), write(-), write(N), write(' '),!.
w(  Var):- var2num(Var,N),           write(N), write(' '),!.
unix(Comando):-shell(Comando),!.
unix(_).

readModel(L):- get_code(Char), readWord(Char,W), readModel(L1), addIfPositiveInt(W,L1,L),!.
readModel([]).

addIfPositiveInt(W,L,[N|L]):- W = [C|_], between(48,57,C), number_codes(N,W), N>0, !.
addIfPositiveInt(_,L,L).

readWord(99,W):- repeat, get_code(Ch), member(Ch,[-1,10]), !, get_code(Ch1), readWord(Ch1,W),!.
readWord(-1,_):-!, fail. %end of file
readWord(C,[]):- member(C,[10,32]), !. % newline or white space marks end of word
readWord(Char,[Char|W]):- get_code(Char1), readWord(Char1,W), !.
%========================================================================================

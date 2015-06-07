% mandatory commented line to ensure vim's proper syntax highlighting, DO NOT REMOVE

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

nat(0).
nat(N):-
    nat(X),
    N is X + 1.


subsetFeatures([], []).
subsetFeatures([City | Tail], Features):-
    cityAttractions(City, CityFeatures),
    subsetFeatures(Tail, TailFeatures),
    union(CityFeatures, TailFeatures, Features).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% generate all possible subsets of a given list,
% by either picking the head of the list or not.
mySubset([], []).
mySubset([ Head | Tail], [ Head | NTail]):-
  mySubset(Tail, NTail).
mySubset([ _ | Tail], NTail):-
  mySubset(Tail, NTail).

solve:-
    destinations(Cities),
    travelRequirements(Requirements),
    nat(NCities),
    mySubset(Cities, SelectedCities),
    length(SelectedCities, NCities),

    subsetFeatures(SelectedCities, FeaturesSelectedCities),

    % True if all elements of SubSet belong to Set as well.
    subset(Requirements, FeaturesSelectedCities),

    write('Solution found with '), write(NCities), write(' cities.'), nl,
    write('Interests Demanded: '), write(Requirements), nl,
    write('Selected Cities: '), write(SelectedCities), nl,
    halt.
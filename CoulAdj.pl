:- initialization(main, main).

:- use_module(library(clpfd)).


% In the swi-prolog...
% This works as expected:
% ?- pixel(R1, C1, _, _, _, Al1), pixel(R2, C2, _, _, _, Al2), \+ Al1 #= Al2, R1 #= R2, C2 #= C1+1.

diff_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    Red1 #\= Red2 ;
    Gre1 #\= Gre2 ;
    Blu1 #\= Blu2 ;
    Alp1 #\= Alp2.

% This "works", but also writes an output to say that some combination of
%   of variables failed?
% ?- pixel(R1, C1, Red1,Gre1,Blu1,Al1), pixel(R2, C2,Red2,Gre2,Blu2,Al2), diff_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), R1 #= R2, C2 #= C1+1.

same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    Red1 #= Red2,
    Gre1 #= Gre2,
    Blu1 #= Blu2,
    Alp1 #= Alp2.

% This one works, and also doesn't write an output for failures:
% ?- pixel(R1, C1, Red1,Gre1,Blu1,Al1), pixel(R2, C2,Red2,Gre2,Blu2,Al2), \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), R1 #= R2, C2 #= C1+1.


is_topLeft(R1, C1, R2, C2) :-
    R2 #= R1 - 1,
    C2 #= C1 - 1.

is_topCent(R1, C1, R2, C2) :-
    R2 #= R1 - 1,
    C2 #= C1.

is_topRigh(R1, C1, R2, C2) :-
    R2 #= R1 - 1,
    C2 #= C1 + 1.

is_midLeft(R1, C1, R2, C2) :-
    R2 #= R1,
    C2 #= C1 - 1.

is_midRigh(R1, C1, R2, C2) :-
    R2 #= R1,
    C2 #= C1 + 1.

is_botLeft(R1, C1, R2, C2) :-
    R2 #= R1 + 1,
    C2 #= C1 - 1.

is_botCent(R1, C1, R2, C2) :-
    R2 #= R1 + 1,
    C2 #= C1.

is_botRigh(R1, C1, R2, C2) :-
    R2 #= R1 + 1,
    C2 #= C1 + 1.


% Also works:
% ?- pixel(R1, C1, Red1,Gre1,Blu1,Al1), pixel(R2, C2,Red2,Gre2,Blu2,Al2), \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), is_midRigh(R1,C1,R2,C2).

is_neighbour(R1, C1, R2, C2) :-
    is_midRigh(R1, C1, R2, C2).

% Also works:
% ?- pixel(R1, C1, Red1,Gre1,Blu1,Al1), pixel(R2, C2,Red2,Gre2,Blu2,Al2), \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), is_neighbour(R1,C1,R2,C2).

is_neigh(R1, C1, R2, C2) :-
    is_topLeft(R1, C1, R2, C2);
    is_topCent(R1, C1, R2, C2);
    is_topRigh(R1, C1, R2, C2);
    is_midLeft(R1, C1, R2, C2);
    is_midRigh(R1, C1, R2, C2);
    is_botLeft(R1, C1, R2, C2);
    is_botCent(R1, C1, R2, C2);
    is_botRigh(R1, C1, R2, C2).

% Also works:
% ?- pixel(R1, C1, Red1,Gre1,Blu1,Al1), pixel(R2, C2,Red2,Gre2,Blu2,Al2), \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), is_neigh(R1,C1,R2,C2).


is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    pixel(R1, C1, Red1, Gre1, Blu1, Alp1),
    pixel(R2, C2, Red2, Gre2, Blu2, Alp2),
    \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2),
    is_neigh(R1, C1, R2, C2).

% Works!!!
% ?- is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2).

% Seems to work?
% ?- bagof(adjacency(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies).

% ?- bagof([Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies).
% AllAdjacencies = [[210, 220, 30, 242, 210, 20, 230, 244], [210, 220, 30, 242, 210, 20, 230|...], [210, 20, 230, 244, 210, 220|...], [210, 20, 230, 244, 210|...], [210, 20, 30, 246|...], [210, 20, 30|...], [210, 220|...], [210|...], [...|...]|...].

% Looks better?!
% ?- setof(adjacency(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies).
% Looks better, but it's not sorting the atoms

% Might sort correctly, but output isn't shown:
% ?- setof([Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies).

% Donne des résultats vérifiables:
% ?- setof([Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies), maplist(portray_clause, AllAdjacencies).

% Prints the content with a space instead of a tab
% ?- setof([Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), AllAdjacencies), maplist(format('~w ~w ~w ~w ~w ~w ~w ~w ~n'), AllAdjacencies).


print_TSV_file(Filename, AllAdjacencies) :-
    Header = ['r', 'g', 'b', 'a', 'adj_r', 'adj_g', 'adj_b', 'adj_a'],
    tell(Filename),
    writef('%w\t%w\t%w\t%w\t%w\t%w\t%w\t%w\n', Header),
    maplist(format('~w\t~w\t~w\t~w\t~w\t~w\t~w\t~w~n'), AllAdjacencies),
    told.

% Gives the correct TSV output!! :
main :- 
    current_prolog_flag(argv, [TSV_filename]),
    setof(
        [Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], 
        is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), 
        AllAdjacencies
    ), 
    print_TSV_file(TSV_filename, AllAdjacencies).
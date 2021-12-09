:- initialization(main, main).

:- use_module(library(clpfd)).

main :- 
    current_prolog_flag(argv, [TSV_filename]),
    setof(
        [Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2], 
        is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2), 
        AllAdjacencies
    ), 
    print_TSV_file(TSV_filename, AllAdjacencies).

is_adjColour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    pixel(Row1, Col1, Red1, Gre1, Blu1, Alp1),
    pixel(Row2, Col2, Red2, Gre2, Blu2, Alp2),
    \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2),
    is_neighbour(Row1, Col1, Row2, Col2).

same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    Red1 #= Red2,
    Gre1 #= Gre2,
    Blu1 #= Blu2,
    Alp1 #= Alp2.

is_neighbour(R1, C1, R2, C2) :-
    % Top
    (R2 #= R1 - 1, C2 #= C1 - 1); % Left
    (R2 #= R1 - 1, C2 #= C1    ); % Cent
    (R2 #= R1 - 1, C2 #= C1 + 1); % Righ

    % Mid
    (R2 #= R1    , C2 #= C1 - 1); % Left
    (R2 #= R1    , C2 #= C1 + 1); % Righ

    % Bot
    (R2 #= R1 + 1, C2 #= C1 - 1); % Left
    (R2 #= R1 + 1, C2 #= C1    ); % Cent
    (R2 #= R1 + 1, C2 #= C1 + 1). % Righ

print_TSV_file(Filename, AllAdjacencies) :-
    Header = ['r', 'g', 'b', 'a', 'adj_r', 'adj_g', 'adj_b', 'adj_a'],
    tell(Filename),
    writef('%w\t%w\t%w\t%w\t%w\t%w\t%w\t%w\n', Header),
    maplist(format('~w\t~w\t~w\t~w\t~w\t~w\t~w\t~w~n'), AllAdjacencies),
    told.
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
    pixel(R1, C1, Red1, Gre1, Blu1, Alp1),
    pixel(R2, C2, Red2, Gre2, Blu2, Alp2),
    \+ same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2),
    is_neigh(R1, C1, R2, C2).

same_colour(Red1, Gre1, Blu1, Alp1, Red2, Gre2, Blu2, Alp2) :-
    Red1 #= Red2,
    Gre1 #= Gre2,
    Blu1 #= Blu2,
    Alp1 #= Alp2.

is_neigh(R1, C1, R2, C2) :-
    is_topLeft(R1, C1, R2, C2);
    is_topCent(R1, C1, R2, C2);
    is_topRigh(R1, C1, R2, C2);
    is_midLeft(R1, C1, R2, C2);
    is_midRigh(R1, C1, R2, C2);
    is_botLeft(R1, C1, R2, C2);
    is_botCent(R1, C1, R2, C2);
    is_botRigh(R1, C1, R2, C2).

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


print_TSV_file(Filename, AllAdjacencies) :-
    Header = ['r', 'g', 'b', 'a', 'adj_r', 'adj_g', 'adj_b', 'adj_a'],
    tell(Filename),
    writef('%w\t%w\t%w\t%w\t%w\t%w\t%w\t%w\n', Header),
    maplist(format('~w\t~w\t~w\t~w\t~w\t~w\t~w\t~w~n'), AllAdjacencies),
    told.
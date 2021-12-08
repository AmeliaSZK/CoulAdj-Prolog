% pixel(Row, Col, Red, Gre, Blu, Alp)
pixel(    0,   0, 210, 220,  30, 242).
pixel(    0,   1, 210, 220,  30, 242).
pixel(    0,   2, 210,  20, 230, 244).
pixel(    0,   3, 210,  20, 230, 244).
pixel(    0,   4, 210,  20,  30, 246).
pixel(    1,   0, 210, 220,  30, 242).
pixel(    1,   1, 210, 220,  30, 242).
pixel(    1,   2, 210,  20, 230, 244).
pixel(    1,   3, 210,  20, 230, 244).
pixel(    1,   4, 210,  20, 230, 244).
pixel(    2,   0, 210, 220,  30, 242).
pixel(    2,   1, 210, 220,  30, 242).
pixel(    2,   2,  10, 220, 230, 248).
pixel(    2,   3,  10, 220, 230, 248).
pixel(    2,   4, 210,  20, 230, 244).
pixel(    3,   0,  10, 220,  30, 250).
pixel(    3,   1,  10, 220,  30, 250).
pixel(    3,   2,  10,  20, 230, 252).
pixel(    3,   3,  10,  20, 230, 252).
pixel(    3,   4, 210,  20, 230, 244).
pixel(    4,   0,  10, 220,  30, 250).
pixel(    4,   1,  10, 220,  30, 250).
pixel(    4,   2,  10,  20, 230, 252).
pixel(    4,   3,  10,  20, 230, 252).
pixel(    4,   4, 210,  20, 230, 244).
pixel(    5,   0,  10, 220,  30, 250).
pixel(    5,   1, 210,  20,  30, 246).
pixel(    5,   2, 210,  20,  30, 246).
pixel(    5,   3,  10,  20, 230, 252).
pixel(    5,   4, 210,  20, 230, 244).

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

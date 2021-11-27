isAdjPixel(Row1, Col1, Row2, Col2) :-
    (Row1 =\= Row2) # (Col1 =\= 2).

isAdjacent( pixel(Row1, Col1, Red1, Gre1, Blu1, Alp1),
            pixel(Row2, Col2, Red2, Gre2, Blu2, Alp2)) :-
    isAdjPixel(Row1, Col1, Row2, Col2).

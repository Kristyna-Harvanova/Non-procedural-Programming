man(david).
man(thomas).

woman(emma).
woman(stella).

person(O) :- man(O); woman(O).

across(A, B) :- ((man(A), man(B)); (woman(A), woman(B))), A \= B.

distinct(A, B, C, D) :-
    person(A), person(B), person(C), person(D),
    A \= B, A \= C, A \= D, B \= C, B \= D, C \= D.

solve(Dumplings, Pasta, Soup, Trout) :-
    distinct(Dumplings, Pasta, Soup, Trout),
    distinct(Beer, Cider, IcedTea, Wine),
    across(Cider, Trout),
    Dumplings = Beer,
    Soup = Cider,
    across(Pasta, Beer),
    IcedTea \= david,
    Wine = emma,
    Dumplings \= stella.

% addBit(A, B, CarryIn, R, CarryOut)
addBit(zero, zero, zero, zero, zero).
addBit(one, zero, zero, one, zero).
addBit(zero, one, zero, one, zero).
addBit(zero, zero, one, one, zero).
addBit(one, one, zero, zero, one).
addBit(one, zero, one, zero, one).
addBit(zero, one, one, zero, one).
addBit(one, one, one, one, one).

add(X3, X2, X1, X0, Y3, Y2, Y1, Y0, Z4, Z3, Z2, Z1, Z0) :-
    addBit(X0, Y0, zero, Z0, C0),
    addBit(X1, Y1, C0, Z1, C1),
    addBit(X2, Y2, C1, Z2, C2),
    addBit(X3, Y3, C2, Z3, Z4).

%alokace(+Alokovat, +Obsazeno, -Umisteni, -NoveObsazeno)
alokace(Xs, O, U, NewO) :-
    alokace(Xs, O, [], NewO, Rev_U),
    reverse(Rev_U, U).

alokace(Xs, [], U, NewO) :-
alokace(Xs, [0-0], U, NewO),
    !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

alokace([], O, U, O, U).
alokace([X|Xs], O, Uin, FinalO, Uout) :-
    alocate(X, O, U1, NewO, []),
    alokace(Xs, NewO, [U1|Uin], FinalO, Uout).


alocate(X, [S1-L1,S2-L2|Os], U, NewO, A) :-
    X < S2 - (S1+L1),
    XL is S1+L1,
    U = X-XL,
    reverse(A, Rev_A),
    NewL is L1 + X,
    append([Rev_A, [S1-NewL, S2-L2|Os]], NewO),
    !.

alocate(X, [S1-L1,S2-L2|Os], U, NewO, A) :-
    X =:= S2 - (S1+L1),
    XL is S1+L1,
    U = X-XL,
    reverse(A, Rev_A),
    NewL is L1+X+L2,
    append([Rev_A, [S1-NewL|Os]], NewO),
    !.

alocate(X, [S1-L1,S2-L2|Os], U, NewO, A) :-
    alocate(X, [S2-L2|Os], U, NewO, [S1-L1|A]),
    !.

alocate(X, [S1-L1], U, NewO, A) :-
    XL is S1+L1,
    U = X-XL,
    reverse(A, Rev_A),
    NewL is L1 + X,
    append([Rev_A, [S1-NewL]], NewO),
    !.
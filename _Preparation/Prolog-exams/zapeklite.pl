%pocet(+X, +Xs, ?N)

pocet(_, [], 0).
pocet(X, [Y|Ys], N) :-
    (X == Y ->
        pocet(X, Ys, N1),
        N is N1 + 1;

        pocet(X, Ys, N)
    ).


%pocet(0, [2,1,2,0,0], 2).
%pocet(0, [2,1,2,0,0], 2).


%zp(+Xs) Xs je zapeklita

generateXs(N, Xs, Xs) :- 
    length(Xs, N), !.
    
generateXs(N, Xs, R) :-
    length(Xs, L),
    L < N,
    N1 is N - 1,
    between(0, N1, X),
    generateXs(N, [X|Xs], R).

zp(Xs) :- 
    length(Xs, L),
    generateXs(L, [], Xs),
    zp_(Xs, Xs, 0).

zp_(_, [], _).
zp_(Xs, [Y|Ys], N) :-
    pocet(N, Xs, Y),
    N1 is N + 1,
    zp_(Xs, Ys, N1).

%zp([6,2,1,0,0,0,1,0,0,0]).


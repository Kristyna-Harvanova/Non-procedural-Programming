test(X, Y) :- integer(X), !, L is X-1, H is X+1, between(L, H, Y).
test(X, Y) :- integer(Y),    L is Y-1, H is Y+1, between(L, H, X).

hladky1([]).
hladky1([_]).
hladky1([X1,X2|Xs]) :- test(X1, X2), hladky1([X2|Xs]).

hladky(Xs) :-
    append(Ls, [R|Rs], Xs),
    integer(R),
    reverse(Ls, RevLs),
    !,
    hladky1([R|Rs]),
    hladky1([R|RevLs]).

head([H|_], H).
tail([_|T], T).

sloupec(S, Mat) :- maplist(head, Mat, S).
sloupec(S, Mat) :- maplist(tail, Mat, Mat1), sloupec(S, Mat1).

hladka(Mat) :-
    [R1|Radky] = Mat,
    hladky(R1),
    bagof(S, sloupec(S, Mat), Sloupce),
    maplist(hladky, Sloupce),
    maplist(hladky, Radky).

% ~1h

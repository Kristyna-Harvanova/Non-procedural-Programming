










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% A
% pocet(+X, +Xs, ?N)
% pocet(0, [2,1,2,0,0], 2). -> true
% pocet(0, [2,1,2,0,0], N). -> N = 2
pocet(_, [], 0).
pocet(X, [X|Xs], N) :-
    pocet(X, Xs, NewN),
    N is NewN + 1.

pocet(X, [Y|Xs], N) :-
    Y \= X,
    pocet(X, Xs, N).

% B
% zp(+Xs)
% zp([6,2,1,0,0,0,1,0,0,0]). -> true
zp(Xs) :-
    length(Xs, Len),
    maplist(between(0,Len), Xs),
    zp_(Xs, Xs, 0).

zp_(_, [], _).
zp_(List, [X|Xs], N) :-
    pocet(N, List, X),
    NewN is N + 1,
    zp_(List, Xs, NewN).

% C
% length(Xs, 4), zp(Xs).
% Xs = [1,2,1,0] ;
% Xs = [2,0,2,0] 
% revLen(Len, L) = length(L, Len).
%%% NOT YET DONE %%%

% maptree(+P, ?T)

maptree(_, nil) :- !.

maptree(P, b(T1, V, T2)) :-
    call(P, V),
    maptree(P, T1),
    maptree(P, T2).


% size(-Tree, +Number_of_nodes, +Height)

size(nil, 0, _):- !.
% size(b(nil, _, nil), 1, 1):- !.
%

size(b(T1, _, T2), N, H1) :-
    N > 0,
    H1 > -1,
    NN is N-1,
    N > H1,
    between(0, NN, V),
    H2 is H1 - 1,
    V1 is NN - V,
    size(T2, V1, H2),
    size(T1, V, H2).

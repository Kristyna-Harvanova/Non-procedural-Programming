sublist(L, M) :-
    M = [_|_],
    append(_, Suffix, L),
    append(M, _, Suffix).

subseq([], []).
subseq([X|L], [X|M]) :- subseq(L, M).
subseq([_|L], M) :- subseq(L, M).

disjoint([], [], []).
disjoint([X|L], [X|M], N) :- disjoint(L, M, N).
disjoint([X|L], M, [X|N]) :- disjoint(L, M, N).

rotate([], []).
rotate(L, M) :- same_length(L, M), append(A, [X|B], L), append([X|B], A, M).
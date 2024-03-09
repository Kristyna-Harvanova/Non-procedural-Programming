% When we rotate a list by one position to the left, the first element moves to the end of the list.
% Similarly, when we rotate to the right, the last element moves to the beginning.

% Write a Prolog predicate rotate(?L, ?M) that is true if L can be rotated by any number of positions (including zero) to form M. 
% Your predicate should work in both directions.

% rotate(?L, +M)
rotate(L, M) :-
    nonvar(M),
    append(B, A, M),
    append(A, B, L).

% rotate(+L, ?M)
rotate(L, M) :-
    nonvar(L),
    append(A, B, L),
    append(B, A, M).

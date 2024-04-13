flip(lit, out).
flip(out, lit).

flip3(A, B) :-
    same_length(A, B),
    ( append(Prev, [X,Y,Z|Next], A), append(Prev, [X1,Y1,Z1|Next], B)
    ; Next = [_|_], append([Z|Next], [X,Y], A), append([Z1|Next], [X1,Y1], B)
    ; Next = [_|_], append([Y,Z|Next], [X], A), append([Y1,Z1|Next], [X1], B)
    ),
    flip(X, X1),
    flip(Y, Y1),
    flip(Z, Z1).

prepend(Path, State, [State|Path]).

bfs([[State|Prev]|_], _, [State|Prev]) :- maplist(=(out), State), !.
bfs([[State|Prev]|Queue], Visited, Result) :-
    findall(NewState, flip3(State, NewState), NewStates),
    subtract(NewStates, Visited, Unexplored),
    append(Visited, Unexplored, Visited2),
    maplist(prepend([State|Prev]), Unexplored, NewPaths),
    append(Queue, NewPaths, NewQueue),
    bfs(NewQueue, Visited2, Result).

pumpkin(Init, Path) :- bfs([[Init]], [Init], P), reverse(P, Path).


pos(P) :- member(P, [a,b,c,d]).

next(go(P), [M, Box1, Box2, B], [P, Box1, Box2, B]) :- pos(M), pos(P).
next(stack, [M, M, M, B], [M, box2, M, B]).
next(unstack, [M, box2, M, B], [M, M, M, B]).
next(push(box1, P), [M, M, Box2, B], [P, P, Box2, B]) :- pos(P).
next(push(box2, P), [M, Box1, M, B], [P, Box1, P, B]) :- pos(P).
next(climb_on_1, [M, Box1, Box2, B], [box1, Box1, Box2, B]) :- M = Box1; Box1 = box2, M = Box2.
next(climb_off_1, [box1, Box1, Box2, B], [M, Box1, Box2, B]) :- pos(Box1), M = Box1; Box1 = box2, M = Box2.
next(grab, [box1, box2, B, B], [box1, box2, B, hand]).

solve([_, _, _, hand], _, []).
solve(S, Vis, [A|P]) :- next(A, S, NewS), \+ member(NewS, Vis), solve(NewS, [NewS|Vis], P).

solve(P) :- solve([a,b,c,d], [[a,b,c,d]], P).
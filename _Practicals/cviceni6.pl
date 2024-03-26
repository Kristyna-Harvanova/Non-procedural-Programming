
% genModel a eval v cviceni5.pl

move(jug(C1, I1), jug(C2, I2), jug(C1, O1), jug(C2, O2)) :-
    Free is min(I1, C2 - I2),
    Free > 0,
    O1 is I1 - Free,
    O2 is I2 + Free.

moveAny(Jugs, JugsNew) :-
    select(Jug1, Jugs, Rest1),
    select(Jug2, Rest1, Rest2),
    move(Jug1, Jug2, Jug1New, Jug2New),
    sort([Jug1New, Jug2New | Rest2], JugsNew).

start([jug(3, 0), jug(5, 0), jug(8, 8)]).
end([jug(3, 0), jug(5, 4), jug(8, 4)]).

bfs([[State|Prev] | _], _, [State|Prev]) :- end(State).
bfs([[State|Prev] | Queue], Visited, Result) :-
    findall([NewState, State|Prev], (moveAny(State, NewState), \+ member(NewState, Visited)), NewPaths),
    append(Queue, NewPaths, NewQueue),
    bfs(NewQueue, [State|Visited], Result).

% findall(X-Y, (member(X, [1, 2, 3]), member(Y, [a, b])), R).
% R = [1-a, 1-b, 2-a, 2-b, 3-a, 3-b].

% On Halloween evening you are walking in a dark forest and come to a clearing with a circle of jack- o'-lanterns.

% Some of the jack-o'-lanterns are lit, others are dark. When you touch any jack-o'-lantern, its state will toggle (from lit to dark, or from dark to lit), 
% and its neighbors on the left and right will toggle as well. Your goal is to extinguish all the jack-o'-lanterns. 
% If any are still lit at midnight, you yourself will turn into a pumpkin! :)

% a) 
% Write a predicate flip3(S, T) that takes a list S of the current states of the pumpkins, each of which is 'out' or 'lit'. 
% It should succeed once for every possible next state T that can be reached by flipping the state of 3 adjacent pumpkins. 
% Recall that the pumpkins are in a circle, so 3 adjacent pumpkins might wrap past the end of the list back to the beginning.

% flip3 must succeed exactly once for every successor state T. Furthermore, it must generate the successor states in a particular order, 
% namely from left to right as illustrated below. It must work correctly and terminate in both directions.

% ?- flip3([out, out, out, out, out], T).
% T = [lit, lit, lit, out, out] ;
% T = [out, lit, lit, lit, out] ;
% T = [out, out, lit, lit, lit] ;
% T = [lit, out, out, lit, lit] ;
% T = [lit, lit, out, out, lit]

% ?- flip3([out, out, lit], T).
% T = [lit, lit, out]

% ?- flip3(S, [out, out, lit]).
% S = [lit, lit, out]

% ?- flip3(S, [out, out, lit, lit]).
% S = [lit, lit, out, lit] ;
% S = [out, lit, out, out] ;
% S = [lit, out, out, out] ;
% S = [lit, lit, lit, out]

% b)
% Write a Prolog predicate that can determine the shortest sequence of moves needed to extinguish all the pumpkins. 
% Your predicate pumpkin(+Initial, -Path) will take a list of initial states, each of which is l (lit) or o (out, i.e. unlit). 
% It should return the shortest path that leads to a state where all pumpkins are unlit:

% ?- pumpkin([out, lit, out, out, out, lit, out], P), maplist(writeln, P).
% [out,lit,out,out,out,lit,out]
% [lit,lit,out,out,out,out,lit]
% [out,out,out,out,out,out,out]
% P = [[out, lit, out, out, out, lit, out], [lit, lit, out, out, out, out, lit], [out, out, out, out, out, out|...]] 

% Iterative deepening will be too slow for some of the test cases; use a breadth-first search.

% (Technically, many shortest paths may be possible; you should return the one that is first discovered by a breadth-first search 
% that considers successor states in the order returned by flip3).

% Defining the help flip function
flip(lit, out). 
flip(out, lit).

% Defining the flip3(+S, ?T) function
flip3(S, T) :-
    nonvar(S),                              % Ensuring that S is a non-variable.
    append([[First], _, [Last]], S),        % Extracting the first and last elements of the list.
    append([[Last], S, [First]], HelpS),    % Pad the list with the last and first element to make it circular.
    append([Rest1, [A, B, C], Rest2], HelpS),       % Split the list into 3 adjacent elements (including the circularity).
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[_], NewRest1], Rest1),         % Removing the paddings.
    append([NewRest2, [_]], Rest2),
    append([NewRest1, [NewA, NewB, NewC], NewRest2], T).    % Constructing the new list with the 3 flipped elements.

flip3(S, T) :-
    nonvar(S),
    append([[C], Rest, [A, B]], S),         % Extracting the wanted 3 elements of the list.
    Rest \= [],
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[NewC], Rest, [NewA, NewB]], T).% Constructing the new list with the 3 flipped elements.

flip3(S, T) :-
    nonvar(S),
    append([[B, C], Rest, [A]], S),         % Extracting the wanted 3 elements of the list.
    Rest \= [],
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[NewB, NewC], Rest, [NewA]], T).% Constructing the new list with the 3 flipped elements.

% Defining the flip3(?S, +T) function
flip3(S, T) :-
    nonvar(T),                              % Ensuring that T is a non-variable.
    append([[First], _, [Last]], T),        % Extracting the first and last elements of the list.
    append([[Last], T, [First]], HelpT),    % Pad the list with the last and first element to make it circular.
    append([Rest1, [A, B, C], Rest2], HelpT),       % Split the list into 3 adjacent elements (including the circularity).
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[_], NewRest1], Rest1),         % Removing the paddings.
    append([NewRest2, [_]], Rest2),
    append([NewRest1, [NewA, NewB, NewC], NewRest2], S).    % Constructing the new list with the 3 flipped elements.

flip3(S, T) :-
    nonvar(T),
    append([[C], Rest, [A, B]], T),         % Extracting the wanted 3 elements of the list.
    Rest \= [],
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[NewC], Rest, [NewA, NewB]], S).% Constructing the new list with the 3 flipped elements.

flip3(S, T) :-
    nonvar(T),
    append([[B, C], Rest, [A]], T),         % Extracting the wanted 3 elements of the list.
    Rest \= [],
    flip(A, NewA),                          % Flipping the elements.
    flip(B, NewB),
    flip(C, NewC),
    append([[NewB, NewC], Rest, [NewA]], S).% Constructing the new list with the 3 flipped elements.

% Defining the genEnd(+N, -End) help function. 
genEnd(1, [out]).
genEnd(N, [out|Rest]) :-
    N1 is N-1, N1 > 0,
    genEnd(N1, Rest).

% Defining the end(+State) function (Not used in the final implementation)
end([out]).
end([State|Rest]) :-    % All of the elements must be out.
    State = out,    
    end(Rest).  

% Defining the bfs(+Queue, +Visited, -Path) function
bfs([[State|Prev] | _], _, [State|Prev], End) :- State == End, !.  % If the end state is reached, return the path.
bfs([[State|Prev] | Queue], Visited, Result, End) :-
    findall([NewState, State|Prev], (flip3(State, NewState), \+ member(NewState, Visited)), NewPaths),  % Generate all possible paths.
    append(Queue, NewPaths, NewQueue),  % Append the new paths to the queue.
    bfs(NewQueue, [State|Visited], Result, End). % Continue the search.

% Defining the pumpkin(+Initial, -Path) function
pumpkin(Initial, Path) :-
    length(Initial, N),     % Getting the length of the initial list.
    genEnd(N, End),         % Generating the end state.
    bfs([[Initial]], [], PathRev, End),
    reverse(PathRev, Path).     % Reversing the path to get the correct order.

% % Enhanced BFS to ensure no state is queued more than once.
% bfs([[State|Prev] | RestQueue], Visited, Path) :-
%     (   end(State)
%     ->  reverse([State|Prev], Path)  % Found a solution, reverse the path to the correct order.
%     ;   findall(
%             [NewState, State|Prev],
%             (   flip3(State, NewState),
%                 \+ memberchk(NewState, Visited)  % Only consider NewState if not in Visited.
%             ),
%             NewPaths),
%         append(Visited, [State], NewVisited),  % Add current state to Visited.
%         append(RestQueue, NewPaths, NewQueue),  % Enqueue new states.
%         bfs(NewQueue, NewVisited, Path)  % Recursive call with updated queue and visited list.
%     ).

% % Modified pumpkin/2 predicate to initiate BFS with an empty visited list.
% pumpkin(Initial, Path) :-
%     bfs([[Initial]], [Initial], Path).  % Start BFS with Initial state already marked as visited.
%     %reverse(PathRev, Path).
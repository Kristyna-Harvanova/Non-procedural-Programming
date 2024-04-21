
% :- include('moves.pl').
% :- include('examples.pl').

:- module(id, [solve/1, find_moves_from_to/2, measure_time/3, iterative_deepening/4]).

:- use_module(cube).
:- use_module(moves).

%%% Iterative deepening approach to solve the Rubik's cube. %%%

% Generate all possible moves from a cube state
successors(Cube, NewCube, Move) :-
    (up(Cube, NewCube), Move = 'Up') ;
    (up(NewCube, Cube), Move = 'Up\'') ;
    (front(Cube, NewCube), Move = 'Front') ;
    (front(NewCube, Cube), Move = 'Front\'') ;
    (right(Cube, NewCube), Move = 'Right') ;
    (right(NewCube, Cube), Move = 'Right\'') ;
    (back(Cube, NewCube), Move = 'Back') ;
    (back(NewCube, Cube), Move = 'Back\'') ;
    (left(Cube, NewCube), Move = 'Left') ;
    (left(NewCube, Cube), Move = 'Left\'') ;
    (down(Cube, NewCube), Move = 'Down') ;
    (down(NewCube, Cube), Move = 'Down\'').


% Find a path from the start state to the goal state

% Some useful definitions and information about search methods:
% b - branching factor
% d - depth of solution

% Method   memory      time
% BFS      O(b^d)      O(b^d)
% DFS      O(d)        up to infinity
% ID       O(d)        O(b^(d+1))      (iterative deepening: DFS to depth 1, then to depth 2 etc.)


% Iterative deepening

% Find a path from the start state to the goal state with a depth limit
find_path(_, Cube, Cube, _, [], _).                                     % Base case to stop when the goal is reached
find_path(MovePred, Current, Goal, Visited, [Move | Moves], Depth) :-   % Recursive case to explore moves depth-limited
    Depth > 0,
    call(MovePred, Current, Next, Move),                                % Generate the next state via a particular move                     
    \+ member(Next, Visited),                                           % Ensure the next state was not visited before in order to avoid loops
    NewDepth is Depth - 1,                                              
    find_path(MovePred, Next, Goal, [Next | Visited], Moves, NewDepth). % Recur with the next state and reduced depth

% Iteratively increase the depth limit until a solution is found
iterate_depth(Depth, MovePred, Start, Goal, Solution) :-
    find_path(MovePred, Start, Goal, [Start], Solution, Depth) ;        % Try to find a solution with the current depth limit
    NewDepth is Depth + 1,                                              % If no solution found, increase the depth limit
    iterate_depth(NewDepth, MovePred, Start, Goal, Solution).           % Recur with the new depth limit

% Iterative deepening search
iterative_deepening(MovePred, Start, Goal, Solution) :-
    iterate_depth(1, MovePred, Start, Goal, Solution).                  % Start with depth limit 1 and increase iteratively


% Solve the cube
solve(InitialName) :-
    writeln('Starting iterative deepening search...'),
    const(InitialName, Initial),    % Get the initial state by its const name defined in cube.pl
    const(solved, Solved),          % Get the solved state (also defined in cube.pl)
    iterative_deepening(successors, Initial, Solved, Solution, _), 
    write("For the initial state: "), writeln(Initial),
    write("Solution found: "), writeln(Solution).

% Solve the cube
find_moves_from_to(InitialName, FinalName) :-
    writeln('Starting iterative deepening search...'),
    const(InitialName, Initial),    % Get the initial state by its const name defined in cube.pl
    const(FinalName, Final),          % Get the solved state (also defined in cube.pl)
    iterative_deepening(successors, Initial, Final, Solution, _), 
    write("For the initial state: "), writeln(Initial),
    write("Solution found: "), writeln(Solution).
    
    
% Measure the time taken to solve the cube
measure_time(Computation, Minutes, Seconds) :-
    statistics(walltime, [Start|_]),
    Computation,
    statistics(walltime, [End|_]),
    Time is End - Start,
    Minutes is Time div 60000,
    Seconds is (Time mod 60000) div 1000.

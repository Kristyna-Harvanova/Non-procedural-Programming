
:- include('cube.pl').
:- include('moves.pl').

%%% Iterative deepening approach to solve the Rubik's cube. %%%

% Generate all possible moves from a cube state
successors(Cube, NewCube, Move) :-
    %findall((Move, NewCube), (
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
    %), Successors).


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
    iterative_deepening(successors, Initial, Solved, Solution), 
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
















% % Human approach to solving the cube in stages
% solve_human(Cube, Moves) :-
%     solve_human_stage1(Cube, State1),
%     solve_human_stage2(State1, State2),
%     solve_human_stage3(State2, State3),
%     solve_human_stage4(State3, State4),
%     extract_solution(State4, [], Moves).

% % Define the stages, each represented by starting a BFS with specific moves and goals
% solve_human_stage1(Cube, FinalState) :-
%     start_bfs(Cube, is_human_stage1, FinalState).

% solve_human_stage2(State, FinalState) :-
%     % Assuming `State` is the current cube configuration
%     cube_state(State, CurrentCube),
%     start_bfs(CurrentCube, is_human_stage2, FinalState).

% % Add more stages similarly...

% % Define conditions for each human approach stage, e.g.,
% is_human_stage1(Cube) :- true.
%     % Check the specific condition for stage 1

% % Define moves as dynamic predicates
% :- dynamic move/2.
% move(u, Cube, ModifiedCube) :- true. % Define how move 'u' modifies the Cube
% move(r, Cube, ModifiedCube) :- true.% Define how move 'r' modifies the Cube
% % Add more moves...

% % Load or define basic moves and human approach specific moves
% :- include('moves.pl').

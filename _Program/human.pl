
:- include('id.pl').
:- include('moves_compound.pl').
:- include('human_moves2.pl').
% TODO: popsat, ze umi vygenerovat ruzna reseni - proto neni ukonceno rezem.


%%% Human approach to solve the Rubik's cube. %%%

% Define other successor functions for different parts of algorithm solving the cube.

successors4middle(Cube, NewCube, Moves) :-
    (move2middle1a(Cube, NewCube, Moves)) ;
    (move2middle1b(Cube, NewCube, Moves)) ;
    (move2middle2a(Cube, NewCube, Moves)) ;
    (move2middle2b(Cube, NewCube, Moves)) ;
    (move2middle3a(Cube, NewCube, Moves)) ;
    (move2middle3b(Cube, NewCube, Moves)) ;
    (move2middle4a(Cube, NewCube, Moves)) ;
    (move2middle4b(Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

successors4yellow(MainMove, Cube, NewCube, Moves) :-
    (call(MainMove, Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

successors4yellow1(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow1, Cube, NewCube, Moves).

successors4yellow2(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow2, Cube, NewCube, Moves).

successors4yellow3(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow3, Cube, NewCube, Moves).


% Define the main function to solve the cube in steps.
% solve_step(MovePred, Initial, Final) :-
%     iterative_deepening(MovePred, Initial, Final, Solution).
%     %write("For the initial state: "), writeln(Initial),
%     %write("For the final state: "), writeln(Final),
%     %write("Solution found: "), writeln(Solution).

solve_step(MovePred, Initial, Final, Solution) :-
    iterative_deepening(MovePred, Initial, Final, Solution).
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    %write("Solution found: "), writeln(Solution).


% Define the functions to solve the cube in main stages.

solve_white_cross(Initial, Final, Solution) :-
    white_cross_1(State1),
    white_cross_2(Final),
    solve_step(successors, Initial, State1, Solution1),
    solve_step(successors, State1, Final, Solution2),
    append(Solution1, Solution2, Solution).

solve_white_corners(Initial, Final, Solution) :-
    white_corners_1(State1),
    white_corners_2(State2),
    white_corners_3(State3),
    white_corners_4(Final),
    solve_step(successors, Initial, State1, Solution1),
    solve_step(successors, State1, State2, Solution2),
    solve_step(successors, State2, State3, Solution3),
    solve_step(successors, State3, Final, Solution4),
    append(Solution1, Solution2, Temp1),
    append(Temp1, Solution3, Temp2),
    append(Temp2, Solution4, Solution).

solve_middle_layer(Initial, Final, Solution) :-
    middle_layer_2b(State1),
    middle_layer_4b(Final),
    solve_step(successors4middle, Initial, State1, Solution1),
    solve_step(successors4middle, State1, Final, Solution2),
    append(Solution1, Solution2, Solution).

solve_yellow_cross(Initial, Final, Solution) :-
    yellow_cross_1(State1),
    yellow_cross_2(Final),
    solve_step(successors, Initial, State1, Solution1),
    solve_step(successors, State1, Final, Solution2),
    append(Solution1, Solution2, Solution).

solve_yellow_corners(Initial, Final, Solution) :-
    yellow_corners_1(State1),
    yellow_corners_2(Final),
    solve_step(successors4yellow1, Initial, State1, Solution1),
    solve_step(successors4yellow2, State1, Final, Solution2),
    append(Solution1, Solution2, Solution).

solve_yellow_edges(Initial, Final, Solution) :-
    yellow_edges(Final),
    solve_step(successors4yellow3, Initial, Final, Solution).


% Human approach to solving the cube in stages
solve_human(InitialName) :-
    const(InitialName, Initial),
    solve_white_cross(Initial, State1, Solution1),
    write("To make a white cross, do these moves: "), writeln(Solution1),

    solve_white_corners(State1, State2, Solution2),
    write("To make white corners, do these moves: "), writeln(Solution2),

    solve_middle_layer(State2, State3, Solution3),
    write("To make the middle layer, do these moves: "), writeln(Solution3),

    solve_yellow_cross(State3, State4, Solution4),
    write("To make a yellow cross, do these moves: "), writeln(Solution4),
%TODO: pokud je list prazdny, bud nevzpsat vubec, nebo rict, ze uz to je hotove.
    solve_yellow_corners(State4, State5, Solution5),
    write("To make yellow corners, do these moves: "), writeln(Solution5),

    solve_yellow_edges(State5, _, Solution6),
    write("To make yellow edges, do these moves: "), writeln(Solution6),

    Temp = [Solution1, Solution2, Solution3, Solution4, Solution5, Solution6],
    flatten(Temp, Solution),
    
    writeln("The cube is solved!"),
    write("For the initial state: "), writeln(Initial),
    write("Solution found: "), writeln(Solution).
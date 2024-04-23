
:- include('id.pl').
:- include('moves_compound.pl').
:- include('cube_states.pl').

%%% Human approach to solve the Rubik's cube. %%%

% Define other successor functions for different parts of algorithm solving the cube.

successors4middle(Cube, NewCube, Moves) :-
    (move2middle_1a(Cube, NewCube, Moves)) ;
    (move2middle_1b(Cube, NewCube, Moves)) ;
    (move2middle_2a(Cube, NewCube, Moves)) ;
    (move2middle_2b(Cube, NewCube, Moves)) ;
    (move2middle_3a(Cube, NewCube, Moves)) ;
    (move2middle_3b(Cube, NewCube, Moves)) ;
    (move2middle_4a(Cube, NewCube, Moves)) ;
    (move2middle_4b(Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

successors4yellow(MainMove, Cube, NewCube, Moves) :-
    (call(MainMove, Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

successors4yellow_corners_1(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow_corners_1, Cube, NewCube, Moves).

successors4yellow_corners_2(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow_corners_2, Cube, NewCube, Moves).

successors4yellow_edges(Cube, NewCube, Moves) :-
    successors4yellow(move2yellow_edges, Cube, NewCube, Moves).


% Define the function to solve particular step of the cube solving algorithm.
solve_step(MovePred, Initial, Final, Solution) :-
    iterative_deepening(MovePred, Initial, Final, Solution).

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
    solve_step(successors4yellow_corners_1, Initial, State1, Solution1),
    solve_step(successors4yellow_corners_2, State1, Final, Solution2),
    append(Solution1, Solution2, Solution).

solve_yellow_edges(Initial, Final, Solution) :-
    yellow_edges(Final),
    solve_step(successors4yellow_edges, Initial, Final, Solution).


% Write the solution to the console.
write_solution([], Message) :- 
    write("You already have "), write(Message), writeln(".").
write_solution(Solution, Message) :-
    write("To make "), write(Message), write(" do these moves: "),
    writeln(Solution).

% Human approach to solving the cube in stages
solve_human(InitialName) :-
    const(InitialName, Initial),
    solve_white_cross(Initial, State1, Solution1),
    write_solution(Solution1, "a white cross"),

    solve_white_corners(State1, State2, Solution2),
    write_solution(Solution2, "white corners"),

    solve_middle_layer(State2, State3, Solution3),
    write_solution(Solution3, "the middle layer"),

    solve_yellow_cross(State3, State4, Solution4),
    write_solution(Solution4, "a yellow cross"),

    solve_yellow_corners(State4, State5, Solution5),
    write_solution(Solution5, "yellow corners"),

    solve_yellow_edges(State5, _, Solution6),
    write_solution(Solution6, "yellow edges"),

    Temp = [Solution1, Solution2, Solution3, Solution4, Solution5, Solution6],
    flatten(Temp, Solution),
    
    writeln("The cube is solved!"), nl,
    write("For the initial state: "), writeln(Initial),
    write("Solution found: "), writeln(Solution).
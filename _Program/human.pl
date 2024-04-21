
% :- include('id.pl').
% :- include('human_moves.pl').

:- module(human, [solve_white_cross/1]).

:- use_module(cube).
:- use_module(examples).
:- use_module(moves).
:- use_module(id).
:- use_module(human_moves).

% TODO: popsat, ze umi vygenerovat ruzna reseni - proto neni ukonceno rezem.
% TODO: prejmenovat veci zde v human approach

%%% Human approach to solve the Rubik's cube. %%%

solve_step_name(InitialName, FinalName, Final) :-
    const(InitialName, Initial),    % Get the initial state by its const name defined in cube.pl
    const(FinalName, Final),        % Get the final state by its const name defined in cube.pl
    iterative_deepening(successors, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).

solve_step(Initial, FinalName, Final) :-
    const(FinalName, Final),        % Get the final state by its const name defined in cube.pl
    iterative_deepening(successors, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).

solve_ste2(Initial, Final) :-
    iterative_deepening(successors, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).

solve_yellow(MovePred, Initial, FinalName, Final) :-
    const(FinalName, Final),        % Get the final state by its const name defined in cube.pl
    iterative_deepening(MovePred, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).

% const(white_cross_1, cube(
%     _, w, _, w, w, w, _, w, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_cross_1(cube(
    _, w, _, w, w, w, _, w, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(white_cross_2, cube(
%     _, w, _, w, w, w, _, w, _,
%     _, g, _, _, g, _, _, _, _,
%     _, r, _, _, r, _, _, _, _,
%     _, b, _, _, b, _, _, _, _,
%     _, o, _, _, o, _, _, _, _,
%     _, _, _, _, _, _, _, _, _)).

white_cross_2(cube(
    _, w, _, w, w, w, _, w, _,
    _, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, _, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(white_corners_1, cube(
    w, w, _, w, w, w, _, w, _,
    g, g, _, _, g, _, _, _, _,
    _, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(white_corners_2, cube(
    w, w, _, w, w, w, w, w, _,
    g, g, g, _, g, _, _, _, _,
    r, r, _, _, r, _, _, _, _,
    _, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(white_corners_3, cube(
    w, w, _, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, _, _, b, _, _, _, _,
    _, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(white_corners_4, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, _, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, _, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(middle_layer_1a, cube(        
    _, w, w, w, w, w, w, w, w,
    _, g, g, _, g, _, g, g, _,
    r, r, r, _, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, _, _, o, _, _, _, w,
    _, _, _, o, _, _, o, _, _)).

const(middle_layer_1b, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, _, _, _, _,
    r, r, r, _, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(middle_layer_2a, cube(
    w, w, w, w, w, w, _, w, w,
    g, g, _, g, g, _, _, _, w,
    _, r, r, _, r, _, r, r, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    g, g, _, _, _, _, _, _, _)).

const(middle_layer_2b, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, _, _, _, _,
    b, b, b, _, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(middle_layer_3a, cube(
    w, w, w, w, w, w, w, w, _,
    g, g, g, g, g, g, _, _, _,
    r, r, _, r, r, _, _, _, w,
    _, b, b, _, b, _, b, b, _,
    o, o, o, _, o, o, _, _, _,
    _, _, r, _, _, r, _, _, _)).

const(middle_layer_3b, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, _, _, _, _,
    o, o, o, _, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

const(middle_layer_4a, cube(
    w, w, _, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, _, b, b, _, _, _, w,
    _, o, o, _, o, o, o, o, _,
    _, _, _, _, _, _, _, b, b)).

const(middle_layer_4b, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, _, _, _, _, _, _, _, _)).

% const(yellow_cross_1, cube(
%     w, w, w, w, w, w, w, w, w,
%     g, g, g, g, g, g, _, _, _,
%     r, r, r, r, r, r, _, _, _,
%     b, b, b, b, b, b, _, _, _,
%     o, o, o, o, o, o, _, _, _,
%     _, _, _, y, y, y, _, _, _)).

const(yellow_cross_1, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, _, y, _, _, y, _)).

const(yellow_cross_2, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    _, y, _, y, y, y, _, y, _)).

const(yellow_corners_1, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, _, _, _,
    r, r, r, r, r, r, _, _, _,
    b, b, b, b, b, b, _, _, _,
    o, o, o, o, o, o, _, _, _,
    y, y, y, y, y, y, y, y, y)).

const(yellow_corners_2, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, _, g,
    r, r, r, r, r, r, r, _, r,
    b, b, b, b, b, b, b, _, b,
    o, o, o, o, o, o, o, _, o,
    y, y, y, y, y, y, y, y, y)).

const(yellow_edges, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, g, g,
    r, r, r, r, r, r, r, r, r,
    b, b, b, b, b, b, b, b, b,
    o, o, o, o, o, o, o, o, o,
    y, y, y, y, y, y, y, y, y)).





solve_white_cross(InitialName) :-
    solve_step_name(InitialName, white_cross_1, State1),
% solve_white_cross(Initial) :-
%     solve_step2(Initial, white_cross_1(State1)),
%     solve_step(State1, white_cross_2, State2),
    solve_step2(State1, white_cross_2(State2)),
    solve_step(State2, white_corners_1, State3),
    solve_step(State3, white_corners_2, State4),
    solve_step(State4, white_corners_3, State5),
    solve_step(State5, white_corners_4, State6),

    writeln(""), writeln("Now middle layer:"), writeln(""),
    solve_yellow(successors4middle, State6, middle_layer_2b, State13),
    solve_yellow(successors4middle, State13, middle_layer_4b, State14),

    % solve_step(State6, middle_layer_1a, State7),
    % solve_step(State7, middle_layer_1b, State8),
    % solve_step(State8, middle_layer_2a, State9),
    % solve_step(State9, middle_layer_2b, State10),
    % solve_step(State10, middle_layer_3a, State11),
    % solve_step(State11, middle_layer_3b, State12),
    % solve_step(State12, middle_layer_4a, State13),
    % solve_step(State13, middle_layer_4b, State14),

    writeln(""), writeln("Now yellow cross:"), writeln(""),
    solve_step(State14, yellow_cross_1, State15),
    solve_step(State15, yellow_cross_2, State16),

    writeln(""), writeln("Now yellow corners 1:"), writeln(""),
    solve_yellow(successors4yellow, State16, yellow_corners_1, State17),

    writeln(""), writeln("Now yellow corners 2:"), writeln(""),
    solve_yellow(successors4yellow2, State17, yellow_corners_2, State18),

    writeln(""), writeln("Now yellow edges:"), writeln(""),
    solve_yellow(successors4yellow3, State18, yellow_edges, Solved),

    write("Final state: "), writeln(Solved).

    % move(State16, State17, Moves),
    % write("Moves: "), writeln(Moves),



    


% Human approach to solving the cube in stages
solve_human(Cube, Moves) :-
    solve_human_stage1(Cube, State1),
    solve_human_stage2(State1, State2),
    solve_human_stage3(State2, State3),
    solve_human_stage4(State3, State4),
    extract_solution(State4, [], Moves).





% solve_human_stage1(Cube, FinalState) :-
%     start_bfs(Cube, is_human_stage1, FinalState).

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



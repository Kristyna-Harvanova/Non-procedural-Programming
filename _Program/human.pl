
:- include('id.pl').
:- include('human_moves.pl').
:- include('human_moves2.pl').
%:- include('examples.pl').
%:- include('human_moves.pl').

% :- module(human, [solve_white_cross/1]).

% :- use_module(cube).
% % :- use_module(examples).
% :- use_module(moves).
% :- use_module(id).
% :- use_module(human_moves).
% :- include('human_moves.pl').


% TODO: popsat, ze umi vygenerovat ruzna reseni - proto neni ukonceno rezem.
% TODO: prejmenovat veci zde v human approach

%%% Human approach to solve the Rubik's cube. %%%

% solve_step_name(InitialName, FinalName, Final) :-
%     const(InitialName, Initial),    % Get the initial state by its const name defined in cube.pl
%     const(FinalName, Final),        % Get the final state by its const name defined in cube.pl
%     iterative_deepening(successors, Initial, Final, Solution), 
%     %write("For the initial state: "), writeln(Initial),
%     %write("For the final state: "), writeln(Final),
%     write("Solution found: "), writeln(Solution).

solve_step(Initial, FinalName, Final) :-
    const(FinalName, Final),        % Get the final state by its const name defined in cube.pl
    iterative_deepening(successors, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).

solve_step2(Initial, Final) :-
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

solve_yellow2(MovePred, Initial, Final) :-
    iterative_deepening(MovePred, Initial, Final, Solution), 
    %write("For the initial state: "), writeln(Initial),
    %write("For the final state: "), writeln(Final),
    write("Solution found: "), writeln(Solution).




solve_white_cross(Initial, Final) :-
    white_cross_1(State1),
    white_cross_2(Final),

    solve_step2(Initial, State1),
    solve_step2(State1, Final).

solve_white_corners(Initial, Final) :-
    white_corners_1(State1),
    white_corners_2(State2),
    white_corners_3(State3),
    white_corners_4(Final),

    solve_step2(Initial, State1),
    solve_step2(State1, State2),
    solve_step2(State2, State3),
    solve_step2(State3, Final).

solve_middle_layer(Initial, Final) :-
    middle_layer_2b(State1),
    middle_layer_4b(Final),

    solve_yellow2(successors4middle, Initial, State1),
    solve_yellow2(successors4middle, State1, Final).

solve_yellow_cross(Initial, Final) :-
    yellow_cross_1(State1),
    yellow_cross_2(Final),

    solve_step2(Initial, State1),
    solve_step2(State1, Final).

solve_yellow_corners(Initial, Final) :-
    yellow_corners_1(State1),
    yellow_corners_2(Final),

    solve_yellow2(successors4yellow, Initial, State1),
    solve_yellow2(successors4yellow2, State1, Final).

solve_yellow_edges(Initial, Final) :-
    yellow_edges(Final),

    solve_yellow2(successors4yellow3, Initial, Final).

% Human approach to solving the cube in stages
solve_human(InitialName) :-
    const(InitialName, Initial),
    solve_white_cross(Initial, State1),
    solve_white_corners(State1, State2),
    solve_middle_layer(State2, State3),
    solve_yellow_cross(State3, State4),
    solve_yellow_corners(State4, State5),
    solve_yellow_edges(State5, Solved),
    write("Final state: "), writeln(Solved).





% solve_white_cross(InitialName) :-
%     solve_step_name(InitialName, white_cross_1, State1),
% % solve_white_cross(Initial) :-
% %     solve_step2(Initial, white_cross_1(State1)),
%     solve_step(State1, white_cross_2, State2),
%     % white_cross_2(State2),
%     % solve_step2(State1, State2),
%     solve_step(State2, white_corners_1, State3),
%     solve_step(State3, white_corners_2, State4),
%     solve_step(State4, white_corners_3, State5),
%     solve_step(State5, white_corners_4, State6),

%     writeln(""), writeln("Now middle layer:"), writeln(""),
%     solve_yellow(successors4middle, State6, middle_layer_2b, State13),
%     solve_yellow(successors4middle, State13, middle_layer_4b, State14),

%     % solve_step(State6, middle_layer_1a, State7),
%     % solve_step(State7, middle_layer_1b, State8),
%     % solve_step(State8, middle_layer_2a, State9),
%     % solve_step(State9, middle_layer_2b, State10),
%     % solve_step(State10, middle_layer_3a, State11),
%     % solve_step(State11, middle_layer_3b, State12),
%     % solve_step(State12, middle_layer_4a, State13),
%     % solve_step(State13, middle_layer_4b, State14),

%     writeln(""), writeln("Now yellow cross:"), writeln(""),
%     solve_step(State14, yellow_cross_1, State15),
%     solve_step(State15, yellow_cross_2, State16),

%     writeln(""), writeln("Now yellow corners 1:"), writeln(""),
%     solve_yellow(successors4yellow, State16, yellow_corners_1, State17),

%     writeln(""), writeln("Now yellow corners 2:"), writeln(""),
%     solve_yellow(successors4yellow2, State17, yellow_corners_2, State18),

%     writeln(""), writeln("Now yellow edges:"), writeln(""),
%     solve_yellow(successors4yellow3, State18, yellow_edges, Solved),

%     write("Final state: "), writeln(Solved).

%     % move(State16, State17, Moves),
%     % write("Moves: "), writeln(Moves),





%%% Defining parts of algorithm for solving Rubik's cube as single moves. %%%

% Compound moves for solving middle layer.

move2middle_1a(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube1, NewCube0),   % prime
    left(NewCube2, NewCube1),   % prime
    down(NewCube3, NewCube2),   % prime
    front(NewCube4, NewCube3),  % prime
    down(NewCube4, NewCube5),
    front(NewCube5, Final),
    Moves = ["Left", "Down'", "Left'", "Down'", "Front'", "Down", "Front"].

move2middle_1b(Cube, Final, Moves) :- 
    front(NewCube0, Cube),      % prime
    down(NewCube1, NewCube0),
    front(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   % prime
    left(Final, NewCube5),      % prime
    Moves = ["Front'", "Down", "Front", "Down", "Left", "Down'", "Left'"].

move2middle_2a(Cube, Final, Moves) :- 
    back(Cube, NewCube0),
    down(NewCube1, NewCube0),   % prime
    back(NewCube2, NewCube1),   % prime
    down(NewCube3, NewCube2),   % prime
    left(NewCube4, NewCube3),   % prime
    down(NewCube4, NewCube5),
    left(NewCube5, Final),
    Moves = ["Back", "Down'", "Back'", "Down'", "Left'", "Down", "Left"].

move2middle_2b(Cube, Final, Moves) :- 
    left(NewCube0, Cube),       % prime
    down(NewCube0, NewCube1),
    left(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    back(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   % prime
    back(Final, NewCube5),      % prime
    Moves = ["Left'", "Down", "Left", "Down", "Back", "Down'", "Back'"].

move2middle_3a(Cube, Final, Moves) :- 
    right(Cube, NewCube0),
    down(NewCube1, NewCube0),   % prime
    right(NewCube2, NewCube1),  % prime
    down(NewCube3, NewCube2),   % prime
    back(NewCube4, NewCube3),   % prime
    down(NewCube4, NewCube5),
    back(NewCube5, Final),
    Moves = ["Right", "Down'", "Right'", "Down'", "Back'", "Down", "Back"].

move2middle_3b(Cube, Final, Moves) :- 
    back(NewCube0, Cube),       % prime
    down(NewCube0, NewCube1),
    back(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    right(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   % prime
    right(Final, NewCube5),     % prime
    Moves = ["Back'", "Down", "Back", "Down", "Right", "Down'", "Right'"].

move2middle_4a(Cube, Final, Moves) :- 
    front(Cube, NewCube0),
    down(NewCube1, NewCube0),   % prime
    front(NewCube2, NewCube1),  % prime
    down(NewCube3, NewCube2),   % prime
    right(NewCube4, NewCube3),  % prime
    down(NewCube4, NewCube5),
    right(NewCube5, Final),
    Moves = ["Front", "Down'", "Front'", "Down'", "Right'", "Down", "Right"].

move2middle_4b(Cube, Final, Moves) :- 
    right(NewCube0, Cube),      % prime
    down(NewCube0, NewCube1),
    right(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    front(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   % prime
    front(Final, NewCube5),     % prime
    Moves = ["Right'", "Down", "Right", "Down", "Front", "Down'", "Front'"].


% Compound moves for solving yellow cross.

move2yellow_corners_1(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube0, NewCube1),
    left(NewCube2, NewCube1),   % prime
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube4, NewCube5),
    down(NewCube5, NewCube6),
    left(Final, NewCube6),      % prime
    Moves = ["Left", "Down", "Left'", "Down", "Left", "Down", "Down", "Left'"].

move2yellow_corners_2(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube0, NewCube1),
    left(NewCube2, NewCube1),   % prime
    down(NewCube3, NewCube2),   % prime
    left(NewCube4, NewCube3),   % prime
    front(NewCube4, NewCube5),
    left(NewCube5, NewCube6),
    left(NewCube6, NewCube7),
    down(NewCube8, NewCube7),   % prime
    left(NewCube9, NewCube8),   % prime
    down(NewCube10, NewCube9),  % prime
    left(NewCube10, NewCube11),  
    down(NewCube11, NewCube12),
    left(NewCube13, NewCube12), % prime
    front(Final, NewCube13),    % prime
    Moves = ["Left", "Down", "Left'", "Down'", "Left'", "Front", "Left", "Left", "Down'", "Left'", "Down'", "Left", "Down", "Left'", "Front'"].

move2yellow_edges(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube1, NewCube0),   % prime
    left(NewCube1, NewCube2),  
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube4, NewCube5),
    left(NewCube5, NewCube6),
    down(NewCube7, NewCube6),   % prime
    left(NewCube8, NewCube7),   % prime
    down(NewCube9, NewCube8),   % prime
    left(NewCube10, NewCube9),  % prime
    left(Final, NewCube10),     % prime
    Moves = ["Left", "Down'", "Left", "Down", "Left", "Down", "Left", "Down'", "Left'", "Down'", "Left'", "Left'"].

    

% :- module(human_moves, [successors4middle/3, successors4yellow/3, successors4yellow2/3, successors4yellow3/3]).

% :- use_module(cube).
% :- use_module(moves).
%:- include('moves.pl').


% % r, u', r', u', f', u, f
% % f', u, f, u, r, u', r'

% l, d', l', d', f', d, f
move2middle1a(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube1, NewCube0),   %prime
    left(NewCube2, NewCube1),  %prime
    down(NewCube3, NewCube2),   %prime
    front(NewCube4, NewCube3),   %prime
    down(NewCube4, NewCube5),
    front(NewCube5, Final),
    Moves = ["Left", "Down'", "Left'", "Down'", "Front'", "Down", "Front"].

% f', d, f, d, l, d', l'
move2middle1b(Cube, Final, Moves) :- 
    front(NewCube0, Cube),   %prime
    down(NewCube1, NewCube0),
    front(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   %prime
    left(Final, NewCube5),  %prime
    Moves = ["Front'", "Down", "Front", "Down", "Left", "Down'", "Left'"].

% b, d', b', d', l', d, l
move2middle2a(Cube, Final, Moves) :- 
    back(Cube, NewCube0),
    down(NewCube1, NewCube0),   %prime
    back(NewCube2, NewCube1),  %prime
    down(NewCube3, NewCube2),   %prime
    left(NewCube4, NewCube3),   %prime
    down(NewCube4, NewCube5),
    left(NewCube5, Final),
    Moves = ["Back", "Down'", "Back'", "Down'", "Left'", "Down", "Left"].

% l', d, l, d, b, d', b'
move2middle2b(Cube, Final, Moves) :- 
    left(NewCube0, Cube),   %prime
    down(NewCube0, NewCube1),
    left(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    back(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   %prime
    back(Final, NewCube5),  %prime
    Moves = ["Left'", "Down", "Left", "Down", "Back", "Down'", "Back'"].

% r, d', r', d', b', d, b
move2middle3a(Cube, Final, Moves) :- 
    right(Cube, NewCube0),
    down(NewCube1, NewCube0),   %prime
    right(NewCube2, NewCube1),  %prime
    down(NewCube3, NewCube2),   %prime
    back(NewCube4, NewCube3),   %prime
    down(NewCube4, NewCube5),
    back(NewCube5, Final),
    Moves = ["Right", "Down'", "Right'", "Down'", "Back'", "Down", "Back"].

% b', d, b, d, r, d', r'
move2middle3b(Cube, Final, Moves) :- 
    back(NewCube0, Cube),   %prime
    down(NewCube0, NewCube1),
    back(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    right(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   %prime
    right(Final, NewCube5),  %prime
    Moves = ["Back'", "Down", "Back", "Down", "Right", "Down'", "Right'"].

% f, d', f', d', r', d, r
move2middle4a(Cube, Final, Moves) :- 
    front(Cube, NewCube0),
    down(NewCube1, NewCube0),   %prime
    front(NewCube2, NewCube1),  %prime
    down(NewCube3, NewCube2),   %prime
    right(NewCube4, NewCube3),   %prime
    down(NewCube4, NewCube5),
    right(NewCube5, Final),
    Moves = ["Front", "Down'", "Front'", "Down'", "Right'", "Down", "Right"].

% r', d, r, d, f, d', f'
move2middle4b(Cube, Final, Moves) :- 
    right(NewCube0, Cube),   %prime
    down(NewCube0, NewCube1),
    right(NewCube1, NewCube2),
    down(NewCube2, NewCube3),
    front(NewCube3, NewCube4),
    down(NewCube5, NewCube4),   %prime
    front(Final, NewCube5),  %prime
    Moves = ["Right'", "Down", "Right", "Down", "Front", "Down'", "Front'"].

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

move2yellow(Cube, Final, Moves) :- 
    left(Cube, NewCube0),
    down(NewCube0, NewCube1),
    left(NewCube2, NewCube1),  %prime
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube4, NewCube5),
    down(NewCube5, NewCube6),
    left(Final, NewCube6),  %prime
    Moves = ["Left", "Down", "Left'", "Down", "Left", "Down", "Down", "Left'"].

successors4yellow(Cube, NewCube, Moves) :-
    (move2yellow(Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

move2yellow2(Cube, Final, Moves) :- 
    %R, u, r', u', r', f, r, r, u', r', u', r, u, r', f'
    left(Cube, NewCube0),
    down(NewCube0, NewCube1),
    left(NewCube2, NewCube1),  %prime
    down(NewCube3, NewCube2),   %prime
    left(NewCube4, NewCube3),   %prime
    front(NewCube4, NewCube5),
    left(NewCube5, NewCube6),
    left(NewCube6, NewCube7),
    down(NewCube8, NewCube7),   %prime
    left(NewCube9, NewCube8),   %prime
    down(NewCube10, NewCube9),  %prime
    left(NewCube10, NewCube11),  
    down(NewCube11, NewCube12),
    left(NewCube13, NewCube12),  %prime
    front(Final, NewCube13),  %prime
    Moves = ["Left", "Down", "Left'", "Down'", "Left'", "Front", "Left", "Left", "Down'", "Left'", "Down'", "Left", "Down", "Left'", "Front'"].

successors4yellow2(Cube, NewCube, Moves) :-
    (move2yellow2(Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).

move2yellow3(Cube, Final, Moves) :- 
    %r, u', r, u, r, u, r, u', r', u', r', r'
    left(Cube, NewCube0),
    down(NewCube1, NewCube0),   %prime
    left(NewCube1, NewCube2),  
    down(NewCube2, NewCube3),
    left(NewCube3, NewCube4),
    down(NewCube4, NewCube5),
    left(NewCube5, NewCube6),
    down(NewCube7, NewCube6),   %prime
    left(NewCube8, NewCube7),   %prime
    down(NewCube9, NewCube8),  %prime
    left(NewCube10, NewCube9), %prime
    left(Final, NewCube10), %prime
    Moves = ["Left", "Down'", "Left", "Down", "Left", "Down", "Left", "Down'", "Left'", "Down'", "Left'", "Left'"].

successors4yellow3(Cube, NewCube, Moves) :-
    (move2yellow3(Cube, NewCube, Moves)) ;
    (down(Cube, NewCube), Moves = ["Down"]) ;
    (down(NewCube, Cube), Moves = ["Down'"]).
    




%%% Defining some examples of Rubik's cube. %%%

% Defining the solved state of Rubik's cube. (The faces are in order: up, left, front, right, back, down)
const(solved, cube(
    w, w, w, w, w, w, w, w, w,
    g, g, g, g, g, g, g, g, g,
    r, r, r, r, r, r, r, r, r,
    b, b, b, b, b, b, b, b, b,
    o, o, o, o, o, o, o, o, o,
    y, y, y, y, y, y, y, y, y)).

% Defining some of the initial states of Rubik's cube. (The faces are in order: up, left, front, right, back, down)

% From the solved:  right'. (1 move) 
% Result moves:     [Right]
const(in1, cube(
    w, w, o, w, w, o, w, w, o,
    g, g, g, g, g, g, g, g, g,
    r, r, w, r, r, w, r, r, w,
    b, b, b, b, b, b, b, b, b,
    y, o, o, y, o, o, y, o, o,
    y, y, r, y, y, r, y, y, r)).

% From the solved:  right, up. (2 moves)
% Result moves:     [Up',Right']
const(in2, cube(
    w, w, w, w, w, w, r, r, r,
    r, r, y, g, g, g, g, g, g,
    b, b, b, r, r, y, r, r, y,
    w, o, o, b, b, b, b, b, b,
    g, g, g, w, o, o, w, o, o,
    y, y, o, y, y, o, y, y, o)).

% From the solved:  front, down, left'. (3 moves)
% Result moves:     [Left,Down',Front']
const(in3, cube(
    r, w, w, r, w, w, g, g, g,
    y, y, o, g, g, o, g, g, o, 
    y, r, r, y, r, r, y, g, y,
    w, b, b, w, b, b, r, r, r,
    o, o, g, o, o, w, w, b, w, 
    b, y, b, o, y, b, o, y, b)).

% From the solved:  right, right, up, right'. (4 moves)
% Result moves:     [Right,Up',Right,Right]
const(in4, cube( 
    w, w, r, w, w, r, y, y, g,
    r, r, o, g, g, g, g, g, g,
    b, b, w, r, r, w, r, r, y,
    o, b, b, o, b, b, r, b, b,
    w, g, g, w, o, o, w, o, o,
    y, y, b, y, y, o, y, y, o)).

% From the solved:  down', up, front, front, down'. (5 moves)
% Result moves:     [Down,Front,Front,Up',Down]
const(in5, cube(   
    w, w, w, w, w, w, y, y, y,
    r, r, o, g, g, b, b, b, b,
    b, b, b, r, r, r, r, o, o,
    r, o, o, g, b, b, g, g, g,
    g, g, g, o, o, o, r, r, o,
    w, y, y, w, y, y, w, y, y)).

% From the solved:  up, up, front, left', down', right. (6 moves)
% Result moves:     [Right',Down,Left,Front',Up,Up]
const(in6, cube( 
    r, w, o, r, w, o, r, g, b,
    y, y, y, b, g, g, y, r, o,
    b, r, y, y, r, y, w, b, r,
    o, w, w, o, b, g, w, b, g,
    b, r, g, w, o, w, w, g, g, 
    g, y, b, b, y, o, o, o, r)).

% From the solved:  right, up', down', left, up, up, front. (7 moves)
% Result moves:     [Front',Up,Up,Left',Up,Down,Right']
% Computing time:   12 sec
const(in7, cube(    
    w, w, b, w, w, o, o, o, y,
    r, r, g, r, g, o, y, g, o,
    w, w, b, b, r, b, b, y, y,
    r, g, w, r, b, b, g, o, o, 
    r, g, g, w, o, y, g, g, o, 
    w, b, r, r, y, y, b, y, y)).

% From the solved:  right, up', down', left, up, up, front, back. (8 moves)
% Result moves:     [Front',Back',Up,Up,Left',Up,Down,Right']
% Computing time:   2 min 40 sec
const(in8, cube(
    w, b, o, w, w, o, o, o, y,
    b, r, g, w, g, o, w, g, o,
    w, w, b, b, r, b, b, y, y,
    r, g, y, r, b, y, g, o, b, 
    g, w, r, g, o, g, o, y, g,
    w, b, r, r, y, y, r, r, y)).

% From the solved:  right, up', down', left, up, up, front, back, left'. (9 moves)
% Result moves:     [Left,Front',Back',Up,Up,Left',Up,Down,Right']
% Computing time:   63 min 50 sec
const(in9, cube(
    w, b, o, b, w, o, b, o, y,
    g, o, o, r, g, g, b, w, w, 
    w, w, b, r, r, b, r, y, y,
    r, g, y, r, b, y, g, o, b,
    g, w, o, g, o, w, o, y, w, 
    g, b, r, g, y, y, r, r, y)).


% From the solved:  l, r', f, b', r, l', b, f'
const(inRand1, cube(
    o, b, o, r, w, r, o, b, o,
    w, y, w, g, g, g, w, y, w,
    b, r, b, w, r, w, b, r, b,
    y, w, y, b, b, b, y, w, y,
    g, o, g, y, o, y, g, o, g,
    r, g, r, o, y, o, r, g, r)).

const(inRand2, cube(
    g, y, o, r, w, g, y, w, o,
    r, g, g, b, g, r, g, b, r,
    o, r, g, y, r, y, w, g, y,
    w, w, b, o, b, b, r, b, b, 
    y, g, y, y, o, w, w, w, r, 
    b, o, b, r, y, o, w, o, o)).

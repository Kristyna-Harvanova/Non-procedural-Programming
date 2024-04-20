
%%% Defining the Rubik's cube. %%%

% Defining the colours of Rubik's cube.
colour(b).  % B for blue
colour(g).  % G for green
colour(r).  % R for red
colour(o).  % O for orange
colour(y).  % Y for yellow
colour(w).  % W for white

% Defining the types of faces of Rubik's cube.
faceType(up).
faceType(front).
faceType(right).
faceType(back).
faceType(left).
faceType(down).

% Defining the faces of Rubik's cube.
% The colours are in order:
% C1, C2, C3
% C4, C5, C6
% C7, C8, C9
face(Type, C1, C2, C3, C4, C5, C6, C7, C8, C9) :-
    faceType(Type), colour(C1), colour(C2), colour(C3), colour(C4), colour(C5), colour(C6), colour(C7), colour(C8), colour(C9).

% Defining the Rubik's cube.
cube(C1, C2, C3, C4, C5, C6, C7, C8, C9,
    C11, C12, C13, C14, C15, C16, C17, C18, C19,
    C21, C22, C23, C24, C25, C26, C27, C28, C29,
    C31, C32, C33, C34, C35, C36, C37, C38, C39,
    C41, C42, C43, C44, C45, C46, C47, C48, C49,
    C51, C52, C53, C54, C55, C56, C57, C58, C59) 
    :-
    face(up, C1, C2, C3, C4, C5, C6, C7, C8, C9),
    face(front, C11, C12, C13, C14, C15, C16, C17, C18, C19),
    face(right, C21, C22, C23, C24, C25, C26, C27, C28, C29),
    face(back, C31, C32, C33, C34, C35, C36, C37, C38, C39),
    face(left, C41, C42, C43, C44, C45, C46, C47, C48, C49),
    face(down, C51, C52, C53, C54, C55, C56, C57, C58, C59).


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

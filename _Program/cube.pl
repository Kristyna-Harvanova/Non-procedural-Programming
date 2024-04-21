
:- module(cube, [cube/54]).

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


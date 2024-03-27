% A monkey is standing in a room at position A. There are two boxes: box 1 is at position B, 
% and box 2 is at position C. A bunch of bananas are hanging from the ceiling at position D.

% The monkey may take the following actions:
%  - go(P) – Go to position P (where P is one of the atoms a, b, c, or d).
%  - stack - Place box 1 onto box 2. Both boxes must be at the monkey's current position. 
%  (It's not possible to place box 2 on box 1, since box 2 is larger.)
%  - unstack - Remove box 1 from box 2, placing it back on the floor.
%  - push(B, P) – Push box B (one of the atoms box1 or box2) to position P. 
%  The box must be at the monkey's current position. If box 1 is on top of box 2 and the monkey pushes box 2, 
%  box 1 will move along with it. The monkey may not push box 1 if it is on top of box 2.
%  - climb_on_1 – Climb onto box 1, which must be at the monkey's current position. 
%  This is possible even if box 1 is stacked on box 2. (There is no action to climb onto box 2.)
%  - climb_off_1 – Climb off box 1 back onto the floor.
%  - grab – Grab the bananas. This is only possible if the monkey is on box 1, which is on box 2, 
%  which is at the position of the bananas.

% The monkey would like to eat the bananas.

% Write a predicate solve(P) that is true if P is a list of actions that lead to a state in which 
% the monkey is holding the bananas. The monkey is smart, so no action may lead to a state 
% that is identical to one that has been seen previously. For example, P may not begin 
% with [go(b), push(c), stack, unstack, ...] because unstacking the box would lead to the same 
% state as before the box was stacked. (However, P might end with [climb_on_1, grab, climb_off_1], 
% since if the monkey is holding the bananas then the state after climbing down is not the same as before climbing up.)

% Sample queries:

% ?- length(P, 5), solve(P).
% false.

% ?- length(P, 6), solve(P).
% P = [go(b), push(box1, c), stack, push(box2, d), climb_on_1, grab] ;
% P = [go(c), push(box2, b), stack, push(box2, d), climb_on_1, grab]

% ?- length(P, 7), P = [go(b) | _], solve(P).
% P = [go(b), go(c), push(box2, b), stack, push(box2, d), climb_on_1, grab] ;
% P = [go(b), push(box1, a), push(box1, c), stack, push(box2, d), climb_on_1, grab] ;
% P = [go(b), push(box1, c), stack, push(box2, a), push(box2, d), climb_on_1, grab] ;
% P = [go(b), push(box1, c), stack, push(box2, b), push(box2, d), climb_on_1, grab] ;
% P = [go(b), push(box1, c), stack, push(box2, d), climb_on_1, grab, climb_off_1] ;
% P = [go(b), push(box1, d), go(c), push(box2, d), stack, climb_on_1, grab] ;
% P = [go(b), push(box1, d), push(box1, c), stack, push(box2, d), climb_on_1, grab]

% ?- length(L, 6), _P = [go(b), push(box1, c), stack, push(box2, a), unstack | L], solve(_P).
% L = [push(box1, d), go(a), push(box2, d), stack, climb_on_1, grab] ;
% L = [push(box2, d), go(a), push(box1, d), stack, climb_on_1, grab]

% ?- length(P, 8), append(_, [go(a)], P), solve(P).
% P = [go(b), push(box1, c), stack, push(box2, d), climb_on_1, grab, climb_off_1, go(a)] ;
% P = [go(c), push(box2, b), stack, push(box2, d), climb_on_1, grab, climb_off_1, go(a)]

% Hints:
% You could represent a state e.g. by a quadruple [M, Box1, Box2, Ban] representing the positions of the monkey, 
% box 1, box 2, and bananas.
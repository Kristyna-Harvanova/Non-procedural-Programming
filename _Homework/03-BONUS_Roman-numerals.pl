% In this exercise, we will use the standard form of Roman numerals as described here:
% Thousands	Hundreds	Tens	Units
% 1	M	C	X	I
% 2	MM	CC	XX	II
% 3	MMM	CCC	XXX	III
% 4		CD	XL	IV
% 5		D	L	V
% 6		DC	LX	VI
% 7		DCC	LXX	VII
% 8		DCCC	LXXX	VIII
% 9		CM	XC	IX

% Write a Prolog predicate roman(N, R) that is true if N is an integer in the range 0..3999 
% and R is a list of atoms containing the Roman numeral representation of the same integer. (If N is 0, R should be the empty list.)

% Your predicate must work and terminate in all directions. For example:

% ?- roman(39, R).
% R = [x, x, x, i, x]

% ?- roman(N, [x, x, x, i, x]).
% N = 39

% ?- roman(1993, R).
% R = [m, c, m, x, c, i, i, i]

% ?- roman(N, [Z, c]).
% N = 90,
% Z = x ;
% N = 200,
% Z = c ;
% N = 600,
% Z = d ;
% N = 1100,
% Z = m

% ?- roman(N, R).
% N = 0,
% R = [] ;
% N = 1,
% R = [i] ;
% N = 2,
% R = [i, i] ;
% N = 3,
% R = [i, i, i] ;
% N = 4,
% R = [i, v]

% In theory you could solve this with 4000 different facts, one for each possible number, however I will not accept a solution 
% such as this that contains a large number of hard-coded cases. A solution in fewer than 20 lines is possible.

% Hint:
% A table such as the following may be useful:

% table(T) :- T =
%     [1 : [i],
%      4 : [i, v], 5 : [v],
%      9 : [i, x], 10 : [x],
%      40 : [x, l],
%      ...
%      ]


% A helper predicate that helps generate the Roman numeral representation of a number.
table(T) :- T =
    [
        1000 : [m],
        900 : [c, m], 
        500 : [d],
        400 : [c, d], 
        100 : [c],
        90 : [x, c], 
        50 : [l],
        40 : [x, l], 
        10 : [x],
        9 : [i, x], 
        5 : [v],
        4 : [i, v], 
        1 : [i]
    ].

% Base case, if N is 0, R should be the empty list
roman(0, []).   

% roman(+N, ?R)
roman(N, R) :-
    nonvar(N),              % N is a non-variable
    between(0, 3999, N),    % N is an integer in the range 0..3999
    table(T),               % Get the table
    member(K : V, T),       % Get the key K and value V from the table
    N >= K,      
    !,                      % Cut to give the first subtraction, that is a valid form of the roman number
    N1 is N - K, 
    append(V, R1, R),       % Append the value to R1 and store it in R
    roman(N1, R1).          % Recursively call roman with N1 and R1

% roman(?N, +R)
roman(N, R) :-
    nonvar(R),  % R is a non-variable
    table(T),   % Get the table

    % member(K : V, T),     % Get the key and value from the table
    % (
    %     (V = [A, B],      % Get the first two elements from the value
    %     N1 is N + K,    
    %     roman(N1, R))     % Recursively call roman with N1 and R
    %     ;
    %     (V = [A],         % Get the first element from the value
    %     N1 is N + K,      
    %     roman(N1, [B|R])) % Recursively call roman with N1 and [B|R]
    % ),


    % (
    %     (member(K : [A, B], T),
    %     roman(N + K, R));
    %     (member(K : [A], T),
    %     roman(N + K, [B|R]))
    % ),
    roman_rev(0, R, T, N),
    between(0, 3999, N).    % N is an integer in the range 0..3999

roman_rev(N, [], _, N).             % Base case, if R is empty, N should be N
roman_rev(Acc, [A, B | R], T, N) :- % If R has at least two elements
    member(K : [A, B], T),          % Get the key K which has the value [A, B] in the table
    !,                              % Cut to give the first subtraction, that is a valid solution of the roman number
    N1 is Acc + K,
    roman_rev(N1, R, T, N).

roman_rev(Acc, [A | R], T, N) :-
    member(K : [A], T),             % Get the key K which has the value [A] in the table
    N1 is Acc + K,
    roman_rev(N1, R, T, N).



    

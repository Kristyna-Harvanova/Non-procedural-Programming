% Write the three predicates below. Your predicates should work correctly in every direction, and should always terminate when the solution set is finite.

% a) Write a predicate sublist(L, M) that is true if M is a sublist of L, i.e. the elements of M appear contiguously somewhere inside L. 
% A sublist must always contain at least one element. For example:

% ?- sublist([a, b, c], M).
% M = [a] ;
% M = [a, b] ;
% M = [b] ;
% M = [a, b, c] ;
% M = [b, c] ;
% M = [c]

% ?- sublist([e, a, X, Y, c], [a, b, c]).
% X = b,
% Y = c ;
% X = a,
% Y = b


% b) Write a predicate subseq(L, M) that is true if M is a subsequence of L, i.e. the elements of M appear in the same order inside L, but not necessarily contiguously. 
% A subsequence may be empty. For example:

% ?- subseq([a, b, c], M).
% M = [a, b, c] ;
% M = [a, b] ;
% M = [a, c] ;
% M = [a] ;
% M = [b, c] ;
% M = [b] ;
% M = [c] ;
% M = []

% ?- subseq([a, b, X, c, d], [a, e, d]).
% X = e


% c) Write a predicate disjoint(L, M, N) that is true if M and N are disjoint subsequences of L. This means that M and N must be subsequences (as defined in part (b) above) 
% and that M and N together must contain all the elements of L. For simplicity, you may assume that all elements of L are distinct. For example:

% ?- disjoint([a, b], M, N).
% M = [a, b],
% N = [] ;
% M = [a],
% N = [b] ;
% M = [b],
% N = [a] ;
% M = [],
% N = [a, b]

% ?- disjoint([a, b, c, d, e], [a, c], N).
% N = [b, d, e]

% ?- disjoint(L, [a, b], [c, d]).
% L = [a, b, c, d] ;
% L = [a, c, b, d] ;
% L = [a, c, d, b] ;
% L = [c, a, b, d] ;
% L = [c, a, d, b] ;
% L = [c, d, a, b]


% Hints:
% You may use library predicates in your solution. In particular, the built-in predicate 'append' might be helpful. append(L, M, N) is true if N is the concatenation of L and M.
% Something to think about: if you have all subsequences of [b, c, d], how can you generate all subsequences of [a, b, c, d]?
% If your predicate is not terminating, try rearranging the rules and/or goals.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5

% a)

% The sublist M can be at the beginning of the list L, or at the end, or in the middle. 
% List L is divided into 3 parts: _, M, _. The '_' can be also empty list [].
sublist(L, M) :- append(_, X, L), append(M, _, X), M \= [].

% b)

subseq([], []). % The empty list is a subsequence of any list.
subseq([H|TL], [H|TM]) :- subseq(TL, TM).   % If the TM is subsequence of TL, then it is the same, if they have the same head.
subseq([_|TL], TM) :- subseq(TL, TM).   % If TM is subsequence of TL, then it is the same, if TL has some more different elements in the beginning.

% c)

% In each step, we check if the head of L is also the head of M or N. In addition, in each step, M and N are checked if they are subsequence of L.
disjoint([], [], []). 
disjoint([H|TL], [H|TM], N) :-  
    disjoint(TL, TM, N), 
    subseq(TL, TM), 
    subseq(TL, N).
disjoint([H|TL], M, [H|TN]) :- 
    disjoint(TL, M, TN), 
    subseq(TL, M), 
    subseq(TL, TN).


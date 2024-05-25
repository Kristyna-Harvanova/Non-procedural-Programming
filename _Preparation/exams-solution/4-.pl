










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


% A cifry(+Ns, ?N)
% cifry([1,2,3], N). -> N = 123
% cifry([1,2,3], 99). -> false
cifry(Ns, Num) :-
    cifry_(Ns, Num, _).

cifry_([N], N, 1).
cifry_([N|Ns], NewNum, NewOrder) :-
    cifry_(Ns, Num, Order),
    NewOrder is Order * 10,
    NewNum is Num + NewOrder * N.

% B
% cifry0(+Ns, ?N)
cifry0([N|Ns], Num) :-
    length([N|Ns], M),
    (
        M < 2
    ;   M >= 2,
        N \= 0
    ),
    cifry([N|Ns], Num).

% C
% gen(+-Xs)
vals([0,1,2,3,4,5,6,7,8,9]).
gen(Xs) :-
    vals(Vals),
    gen_(Xs, Vals).

gen_([], _).
gen_([X|Xs], Vals) :-
    select(X, Vals, NewVals),
    gen_(Xs, NewVals).

% D
% alg(+-XS, +-Ys, +-Zs).
alg(Xs, Ys, Zs) :-
    maplist(between(0, 9),Xs),
    maplist(between(0, 9),Ys),
    maplist(between(0, 9),Zs),

    cifry0(Xs, NX),
    cifry0(Ys, NY),
    cifry0(Zs, NZ),

    NZ is NX + NY.

% E
% alg([[T,R,I], [K,R,A,T], [T,R,I], [D,E,V,E,T]]).
numbers([], Acc, Acc).
numbers([Xs|Xss], Numbers, Acc) :-
    cifry0(Xs, Cifry),
    numbers(Xss, [Cifry|Numbers], Acc).


alg(Xss) :-
    length(Xss, L),
    L >= 3,

    maplist(maplist(between(0,9)), Xss),
    numbers(Xss, [], [Result|Cifry]),
    sum_list(Cifry, Result).
    

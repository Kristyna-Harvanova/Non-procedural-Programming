% a)

% cifry(+Ns, ?N)
cifry(Xs, N) :-
    cifry_(Xs, 0, N).

cifry_([], N, N).
cifry_([X|Xs], N1, N) :-
    N2 is (N1 * 10) + X,
    cifry_(Xs, N2, N).

% b)

% cifry0(+Ns, ?N)
cifry0([X|Xs], N) :-
    X \= 0,
    cifry([X|Xs], N), !.
cifry0([0], 0).

% c)

% gen(+Xs)
gen(Xs) :-
    gen_(Xs, []).

gen_([], _).
gen_([X|Xs], Ys) :-
    between(0, 9, X),
    gen__(X, Ys),
    gen_(Xs, [X|Ys]).

gen__(_, []).
gen__(X, [Y|Ys]) :-
    X \= Y, 
    gen__(X, Ys).
    
% d)

% alg(±Xs,±Ys,±Zs)
alg(Xs, Ys, Zs) :-
    gen(Xs),
    gen(Ys),
    gen(Zs),
    cifry0(Xs, X),
    cifry0(Ys, Y),
    cifry0(Zs, Z),
    Z == X + Y.
% problém že gen nefuguje keď zoznam obsahuje viac krát jednu premennú, nemám už čas na vyriešenie

% alg(Xs, Ys, Zs) :-
%     gen(Xs),
%     gen(Ys),
%     cifry0(Xs, X),
%     cifry0(Ys, Y),
%     Z is X + Y,
%     cifry_rev_(Zs, Z).

% cifry_rev(-Ns, +N)
% cifry_rev(_, 0).
% cifry_rev(Xs, N) :-
%     X is N mod 10,
%     N1 is N div 10,
%     cifry_rev([X|Xs], N1).
%     cifry_rev_([X|Xs], N, 0).

% cifry_rev_([X|Xs], N, M) :-



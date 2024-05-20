%test(?X, ?Y) testuje či je zoznam [X,Y] hladký
test(X,Y) :- 
	nonvar(X),
	nonvar(Y),
	integer(X),
	integer(Y),
	X1 is X-1,
	X2 is X+1,
	between(X1, X2, Y),
	!. 

test(X, Y) :-
	var(Y), !,
	integer(X),
	X1 is X-1,
	X2 is X+1,
	between(X1, X2, Y).

test(X, Y) :-
	var(X), !,
	integer(Y),
	Y1 is Y-1,
	Y2 is Y+1,
	between(Y1, Y2, X).
	

%hladky(?Xs) testuje a generuje hladké zoznamy
hladky([]).
hladky([_]).
hladky([X,Y|Xs]) :-
	((nonvar(X); nonvar(Y)) -> 
	test(X,Y),
	hladky_([X,Y|Xs]);

	hladky([Y|Xs]),
	test(X,Y)
	).

hladky_([]).
hladky_([_]).
hladky_([X, Y|Xs]) :-
	test(X, Y),
	hladky_([Y|Xs]).

%hladka(?Xs) - generuje a testuje hladké matice
hladka(Xs) :- 
	use_module(library(clpfd)),
	transpose(Xs, Ys),
	hladka_(Xs, Ys).

hladka_([X|Xs], Ys) :-
	hladky(X),
	hladka__(Ys),
	hladka__(Xs).

hladka__([]).
hladka__([X|Xs]) :-
	hladky(X),
	hladka__(Xs).
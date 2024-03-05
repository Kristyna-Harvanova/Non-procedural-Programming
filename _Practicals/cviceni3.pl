% 3. cvičení, 2024-03-05

% Odbočka: deklarativní vs procedurální správnost programu
%
% Deklarativní správnost: správná odpověď existuje, program ji nemusí najít
% Procedurální správnost: program navíc správnou odpověď najde
%
% Proč? Pokud se na klauzule díváme jako na logické formule, na pořadí
% nezáleží. Prolog to ale pak v nějakém pořadí musí vyhodnotit a pokud
% vybereme špatné pořadí, nemusíme výsledek najít.
%
% Pozn. deklarativní správnost = částečná správnost
% (pokud najde výsledek, je správně)
%       procedurální správnost = úplná správnost
% (najde správný výsledek)

edge(a,b).
edge(b,c).

path(X, X).
path(X, Y) :- edge(X, Z), path(Z, Y).

path2(X, X).
path2(X, Y) :- path2(X, Z), edge(Z, Y).
% Najde výsledek, pak se zacyklí.

path3(X, Y) :- path3(X, Z), edge(Z, Y).
path3(X, X).
% Zacyklí se.

% Všechny 3 programy jsou ekvivalentní deklarativně, ale pouze path/2 je
% procedurálně správně.

% Seznamy jsou další rekurzivní strukturou. [] je prázdný seznam, [X|Y] je
% seznam, kde X je první prvek a Y je zbytek seznamu.
%
% Např. seznam čísel 1 až 4:
% [1|[2|[3|[4|[]]]]]
%
% Syntaktická zkratka:
same1 :- [1,2,3,4] = [1|[2|[3|[4|[]]]]].
same2 :- [1,2|R] = [1|[2|R]].

% f([A,B]) :- ...   % Unifikace uspěje pouze pro dvouprvkové seznamy
% f([A,B|R]) :- ... % Unifikace uspěje pro seznamy velikosti alespoň 2.

% Hledání prvku v seznamu. Porovnávání za nás řeší unifikace.
elem(X,[X|_]).
elem(X,[_|S]) :- elem(X, S).

% Přidávání prvku na začátek seznamu.
addFront(X, R, [X|R]).

% A na konec seznamu.
addBack(X, [], [X]).
addBack(X, [Y|Ys], [Y|R]) :- addBack(X, Ys, R).

% Pomocné predikáty.
toNat(N, R) :-
  integer(N),
  toNat_(N, R).

toNat_(N, R) :- N > 0 ->
  (N2 is N - 1, toNat_(N2, R2), R = s(R2));
  R = 0.

fromNat(0, 0).
fromNat(s(N), R) :-
  fromNat(N, R2),
  R is R2 + 1.






% Zmínit: Proč fail/false nefunguje pro ošetření dělení nulou?

% Pro zopakování:
% Seznam je buď prázdný ([]), nebo je tvořen hlavou H a zbytkem seznamu T
% ([H|T]).
%
% Syntaktické zkratky:
% [A|[B|[C|[]]]] = [A,B|[C|[]]] = [A,B,C|[]] = [A,B,C]

elem(X, [X|_]).
elem(X, [_|T]) :- elem(X, T).
% Standardní knihovna: member
%
% Často se používá jako member(-, +)
% member(X, [a,b,c]).
% X = a;
% X = b;
% X = c;
% false.

addFront(X, XS, [X|XS]).
% addFront(a, [b,c], R).
% R = [a,b,c].
%
% addFront(X, XS, [a,b,c]).
% X = a,
% XS = [b,c].

addBack(X, [], [X]).
addBack(X, [Y|YS], [Y|R]) :- addBack(X, YS, R).
% addBack([a,b], c, R).
% R = [a,b,c].
%
% addBack(XS, X, [a,b,c]).
% XS = [a,b],
% X = c.

% delete(X, S, R) smaže jeden výskyt X v seznamu S.
%
% delete(a, [a,b,c,a,d,e], R).
% R = [b,c,a,d,e];
% R = [a,b,c,d,e];
% false.
%
% delete(d, [a,b,c], R).
% false.
%
% Lze použít i obráceným směrem:
% delete(a, R, [b,c,d]).
% R = [a,b,c,d];
% R = [b,a,c,d];
% R = [b,c,a,d];
% R = [b,c,d,a];
% false.
%
% Standardní knihovna: select
delete(X, [X|R], R).
delete(X, [Y|YS], [Y|R]) :-
  delete(X, YS, R).

% deleteAll(X, S, R) smaže všechny výskyty X ze seznamu S.
% deleteAll(a, [a,b,c,a,d], R).
% R = [b,c,d];
% R = [b,c,a,d]; % Problém!
% R = [a,b,c,d];
% R = [a,b,c,a,d];
% false.
deleteAll(X, [X|XS], R) :-
  deleteAll(X, XS, R).
deleteAll(X, [Y|YS], [Y|R]) :-
  deleteAll(X, YS, R).
deleteAll(_, [], []).

% Spojování seznamů.
%
% Standardní knihovna: append
app([], YS, YS).
app([X|XS], YS, [X|R]) :-
  app(XS, YS, R).

% Aritmetika v Prologu
%
% 1 + 2 = 3.
% false. % ???
%
% Termy 1 + 2 a 3 nejsou shodné. 1 + 2 nejdříve musíme vyhodnotit, než
% se pokusíme o unifikaci.

% operátor is/2
% 3 is 1 + 2.
% true.
%
% X is 1 + 2.
% X = 3.
%
% 1 + 2 is X.
% ERROR: Arguments are not sufficiently instantiated
%
% V X is Y, Y musí být aritmetický výraz, nemůže obsahovat volné proměnné.
% Y = 1 + 2, X is Y. % OK

len([], 0).
len([_|T], R) :-
  len(T, N),
  R is N + 1.

% Pro porovnávání máme:
% X =:= Y
% X =\= Y
% X < Y
% X =< Y
% X >= Y
% X > Y
%
% X a Y musí být aritmetické výrazy bez volných proměnných.

% Permutace pomocí select/3.
perm([], []).
perm([X|XS], R) :-
  perm(XS, PXS),
  select(X, R, PXS).

split([X|XS], X, XS).
split([_|XS], X, R) :-
  split(XS, X, R).

% split(A, B, C) vs append(_, [B|C], A)

%comb(N, List, Result)
comb(0, _, []).
comb(N, Xs, [X|R]) :- append(_, [X|Ys], Xs), M is N-1, comb(M, Ys, R).

% Kombinace pomocí split/3.
comb(0, _, []).
comb(N, XS, [X|R]) :-
  N > 0,
  N2 is N - 1,
  split(XS, X, Rem),
  comb(N2, Rem, R).


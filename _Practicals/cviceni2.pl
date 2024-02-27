% 2. cvičení, 2024-02-27

% Einsteinova hadanka z prednasky 1:
osoba(ada).
osoba(bill).
osoba(steve).

ruzne(A, B, C) :-
    osoba(A), osoba(B), osoba(C),
    A \= B, B \= C, C \= A.

solve(Prolog) :- 
    ruzne(Cis, Prolog, Swift),
    ruzne(Linux, Mac, Win),
    bill \= Mac,
    Win = Cis,
    bill \= Linux,
    ada \= Swift,
    Swift = Mac.

% ?- solve(P).
% P = ada ;


% cele reseni, asi:

nekde(Osoba, pratele(O1, O2, O3)) :-
    Osoba = O1; Osoba = O2; Osoba = O3.

reseni(R) :-
    R = pratele(osoba(ada, _, _), osoba(bill, _, _), osoba(steve, _, _)),
    nekde(osoba(Mac, _, mac), R), Mac \= bill,
    nekde(osoba(_, cis, win), R),
    nekde(osoba(Linux, _, linux), R), Linux \= bill,
    nekde(osoba(Swift, swift, mac), R), Swift \= ada,
    nekde(osoba(_, prolog, _), R).

% ?- reseni(R).
% R = pratele(osoba(ada, prolog, linux), osoba(bill, cis, win), osoba(steve, swift, mac)) ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Kromě jednoduchých atomů (konstant) můžeme v Prologu také vytvářet složené
% termy.

% Operace na dvojicích.
first(pair(X, Y), X).
second(pair(X, Y), Y).

% first(pair(pair(1, 2), 3), R).
% R = pair(1,2).

% Unárně reprezentovaná čísla.

% nat(N)
% N je přirozené číslo
nat(0).
nat(s(N)) :- nat(N). % s ... succesor, naslednik

% Jak Prolog vyhodnocuje dotazy? Unifikace a backtracking!
%
% Když se Prolog snaží splnit nějaký dotaz a má na výběr více možností
% (predikát definovaný pomocí více než jedné klauzule), zkusí postupně
% ty klauzule, jejichž hlava pasuje na dotaz.
%
% Hlava klauzule pasuje na dotaz, pokud je lze unifikovat, tj. najít hodnoty
% proměnných tž. po dosazení jsou hlava a dotaz stejné. Prolog vždy hledá
% neobecnější unifikaci, která neobsahuje žádné zbytečné vazby.
%
% X = X.
% p(X) = Y.
% f(X, Y) = g(X). % false.
% f(X, b) = f(a, Y). % X = a, Y = b.

vertical(line(point(X, Y), point(X, Z))).
horizontal(line(point(X, Y), point(Z, Y))).

% V těle klauzule se také může objevit predikát, který právě definujeme.
% Jsou tedy možné rekurzivní definice.
%
% Klauzule se zkoušejí v pořadí, v jakém jsou zapsané v programu. Stejně tak
% se vyhodnocuje tělo klauzule.
%
% Pokud nějaký poddotaz skončí neúspěchem, Prolog se vrátí na poslední místo,
% kde existuje nějaká volba a zkusí jinou možnost.

% Méně nebo rovno
leq(0, Y) :- nat(Y).
leq(s(X), s(Y)) :- leq(X, Y).
% ?- leq(s(0), s(s(0))).
% true.
% ?- leq(s(s(0)), s(0)).
% false.

% Alternativní definice
leq2(X, X) :- nat(X).
leq2(X, s(Y)) :- leq2(X, Y).

% Méně než.
lt(0, s(Y)) :- nat(Y).
lt(s(X), s(Y)) :- lt(X, Y).

% Sčítání.
% X + Y = Z <==> add(X, Y, Z)
% add(+, +, ?)
add(0, Y, Y) :- nat(Y).
add(s(X), Y, s(Z)) :-
  add(X, Y, Z).
% ?- add(s(0), s(s(s(0))), R).
% R = s(s(s(s(0)))).
% ?- add(X, Y, s(s(s(0)))).
% X = 0,
% Y = s(s(s(0))) ;
% X = s(0),
% Y = s(s(0)) ;
% X = s(s(0)),
% Y = s(0) ;
% X = s(s(s(0))),
% Y = 0 ;

% Násobení.
mult(0, Y, 0) :- nat(Y).
mult(s(X), Y, R) :-
  mult(X, Y, R2),
  add(R2, Y, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% div(X, Y, Q, R) <==> X / Y = 0, X % Y = R
% ?- div(5, 2, Q, R).
% Q = 2, R = 1.

% subtract(X, Y, R) :- add(Y, R, X).

% div(X, Y, Q, R) :- 
%   leq(X, Y), X \= Y, Q = 0, R = X;
%   X = Y, Q = 1, R = 0.

% div(X, s(Y), Q, R) :- 
%   div(X, Y, Q2, R2),
%   subtract(R2, Y, R).


% Sefl reseni:
div(X, Y, 0, X) :-
  leq(s(X), Y).
div(X, Y, s(Q), R) :-
  leq(Y, X),
  add(S, Y, X),
  div(S, Y, Q, R).
  




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Půlení.
half(0, 0).
half(s(0), 0).
half(s(s(X)), s(R)) :- half(X, R).

% Odčítání pomocí predikátu add/3.
% Takovéto predikáty označujeme jako invertibilní.
% Jestli takhle predikát lze použít záleží na definici. Navíc tento směr nemusí
% být vždy stejně efektivní - vhodné použít dvě specializované definice.
subtract(X, Y, R) :- add(Y, R, X).

% Použití sčítání na rozklad čísla.
weird(X, R) :-
  add(A, B, X),
  mult(A, B, R).

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

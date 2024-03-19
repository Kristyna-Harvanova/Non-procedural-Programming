% 5. cvičení, 2024-03-19

% Porovnávání termů
%
% Operátory @<, @=<, @>, @>=, ==, \==, predikát compare. <, >, atp. lze použít
% pouze pro porovnávání aritmetických výrazů. Občas potřebujeme porovnávat
% více než jen čísla - znaky, řetězce, atomy.
%
% Výše zmíněné operátory pracují se standardním uspořádáním termů:
% proměnné < čísla < řetězce < atomy < složené termy
%
% ?- X @< 1.
% true.
%
% ?- x @< a(x,y).
% true.

% Mergesort.

split([], [], []).
split([X|XS], [X|R1], R2) :- split(XS, R2, R1).

merge(XS, [], XS) :- !.  % Řezem zaručíme, že pro merge([], [], R) nedostaneme dva stejné výsledky.
merge([], YS, YS) :- !.
merge([X|XS], [Y|YS], R) :-
  ( X @< Y -> merge(XS, [Y|YS], S), R = [X|S]
  ; X @> Y -> merge([X|XS], YS, S), R = [Y|S]
  ; merge(XS, YS, S), R = [X|S]
  ).


% "if-then-else" je v Prologu k dispozici jako (If -> Then ; Else). Definice tohoto speciálního
% predikátu obsahuje řez, takže podmínka se vyhodnotí právě jednou a pokud uspěje, tak se zároveň
% odřízne Else větev.

mergeSort([], []) :- !.
mergeSort([X], [X]) :- !.
mergeSort(L, S) :-
  L = [_,_|_],
  split(L, LL, LR),
  mergeSort(LL, LS),
  mergeSort(LR, RS),
  merge(LS, RS, S).

% ?- mergeSort([1,a,z,b,0,f(x,y),A,15], R).
% R = [A,0,1,15,a,b,z,f(x,y)]

% Další predikáty pro práci s termy.
% atom/1 - argument je atom
% atomic/1 - argument je konstanta (atom, číslo, řetězec)
% number/1
% integer/1
% float/1
% var/1 - argument je volná proměnná
% nonvar/1
% ground/1 - argument je term bez volných proměnných
% compound/1 - argument je složený term

% ?- atom(a).
% true.
%
% ?- atom(1).
% false.
%
% ?- atomic(1).
% true.

% Reprezentace výrokových formulí.
%
% X & (Y -> Z) ?
% Prozatím umíme jen and(x, imp(y,z)), jde to lépe?

% V Prologu můžeme definovat vlastní operátory:
% :- op(Prec,Fixity,Name)
%
% Kde Prec je priorita operátoru (menší hodnota = váže více),
% Fixity udává typ a asociativitu
%   fx, fy - prefix
%   xf, yf - postfix
%   xfx    - infix, bez asoc.
%   xfy    - infix, asoc. vpravo ...napr mocneni x^(y^z)
%   yfx    - infix, asoc. vlevo ...napr scitani (x+y)+z

:- op(550, xfx, ekv).
:- op(500, xfy, imp).
:- op(450, xfy, or).
:- op(400, xfy, and).
:- op(350,  fx, non).

% Do prefixové notace můžeme převést pomocí predikátu display/1
%
% display(1+2*3).
% +(1,*(2,3))
% true.

% Korektně zadaná formule.
correct(X) :- ground(X), correct_(X).

correct_(X) :- atom(X).
correct_(F ekv G) :- correct_(F), correct_(G).  % correct_(F) :-
correct_(F imp G) :- correct_(F), correct_(G).  %   F =.. [Op, L, R],
correct_(F or  G) :- correct_(F), correct_(G).  %   member(Op, [ekv, imp, or, and]),
correct_(F and G) :- correct_(F), correct_(G).  %   correct_(L), correct_(R).
correct_(  non G) :-              correct_(G).

% Chceme zjistit, jestli je daná formule F splnitelná.
%
% Idea:

sat(F) :-
  correct(F),
  vars(F, Vars),
  genModel(Vars, Model),
  eval(F, Model, true).

% Kde vars najde všechny proměnné, genModel na základě těchto proměnných
% (nedeterministicky) vytvoří model a pak jen zkusíme, jestli je F
% pravdivá v tomto modelu.

% Doplňte definice následujících predikátů.
% vars(F, Vars).
% genModel(Vars, Model).
% eval(F, Model, Value).

vars(X, [X]) :- atom(X).
vars(non F, Vars) :- vars(F, Vars).
vars(F, Vars) :- 
    F =.. [Op, L, R],
    member(Op, [ekv, imp, or, and]),
    vars(L, VarsL),
    vars(R, VarsR),    
    merge(VarsL, VarsR, Vars).

genModel(Vars, Model) :- 
    member(Vars, [true, false])

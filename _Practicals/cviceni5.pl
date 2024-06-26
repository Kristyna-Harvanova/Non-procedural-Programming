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

genModel([], []).
genModel([ Var | Vars ], [Var = V|Model]) :-
    member(V, [true, false]),
    genModel(Vars, Model).

non_(true, false).
non_(false, true).

table([A, _, _, _], true, true, A).
table([_, B, _, _], true, false, B).
table([_, _, C, _], false, true, C).
table([_, _, _, D], false, false, D).

getTable(ekv, [true, false, false, true]).
getTable(imp, [true, false, true, true]).
getTable(or, [true, true, true, false]).
getTable(and, [true, false, false, false]).

% eval(X ekv Y, [X=Xm, Y=Ym], Value) :-
%     Xm == Ym,
%     Value = true,!.
% eval(X ekv Y, [X=Xm, Y=Ym], false).

eval(V, Model, Res) :- atom(V), member(V=Res, Model).
eval(non F, Model, R2) :- eval(F, Model, R1), non_(R1, R2).
eval(F, Model, Value) :-
    F =.. [Op, L, R],
    getTable(Op, Table),
    eval(L, Model, Res1),
    eval(R, Model, Res2),
    table(Table, Res1, Res2, Res).
    





% :- op(550, xfx, ekv).
% :- op(500, xfy, imp).
% :- op(450, xfy, or).
% :- op(400, xfy, and).
% :- op(350,  fx, non).


% correct(X) :- ground(X), correct_(X).

% correct_(X) :- atom(X).
% correct_(non F) :- correct_(F).
% correct_(X) :- 
%     X =.. [Op, L, R],
%     member(Op, [ekv, imp, or, and]),
%     correct_(L), correct_(R).

% sat(F) :-
%     correct(F),
%     vars(F, Vars),
%     genModel(Vars, Model),
%     % member(Model, Model),
%     eval(F, Model, true), !.


% merge(XS, [], XS) :- !.  % Řezem zaručíme, že pro merge([], [], R) nedostaneme dva stejné výsledky.
% merge([], YS, YS) :- !.
% % merge([X|XS], [X|YS], [X|R]) :-
% %     merge(XS, YS, R), !.
% % merge([X|XS], [Y|YS], R) :-
% %     % X \= Y,
% %     ( X @=< Y -> merge(XS, [Y|YS], S), R = [X|S]
% %     ; merge([X|XS], YS, S), R = [Y|S]
% %     ).
    
% merge([X|XS], [Y|YS], R) :-
%     % X \= Y,
%     ( X @< Y -> merge(XS, [Y|YS], S), R = [X|S]
%     ; X @> Y -> merge([X|XS], YS, S), R = [Y|S]
%     ; merge(XS, YS, S), R = [X|S]
%     ).


% vars(X, [X]) :- atom(X), !.
% vars(non F, Vars) :- 
%     vars(F, Vars), !.
% vars(F, Vars) :-
%     F =.. [Op, L, R],
%     member(Op, [ekv, imp, or, and]),
%     vars(L, V1),
%     vars(R, V2),
%     merge(V1, V2, Vars).

% genModel([], []).
% genModel([V|Vars], [V:X|Xs]) :-
%     member(X, [true, false]),
%     genModel(Vars, Xs).

% % IN1, IN2, OUT
% and(true, true, true).
% and(false, _, false).
% and(false, false, false).

% or(true, _, true).
% or(false, true, true).

% ekv(true, true, true).
% ekv(false, false, true).
% ekv(true, false, false).
% ekv(false, true, false).

% imp(false, _, true).
% imp(true, true, true).
% imp(true, false, false).

% % IN, OUT
% non(false, true).
% non(true, false).

% eval(X, Model, Value) :- atom(X), member(X:Value, Model).
% eval(non X, Model, Value) :- 
%     eval(X, Model, V),
%     non(Value, V).

% eval(F, Model, Value) :-
%     F =.. [Op, L, R],
%     eval(L, Model, Value1),
%     eval(R, Model, Value2),
%     call(Op, Value1, Value2, V),
%     V = Value.

    


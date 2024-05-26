
% 1. Prolog (10 bodů): Jednoduchý algebrogram

% Algebrogram je úloha, jejíž řešení spočívá v náhradě zadaných písmen číslicemi tak, aby zadané početní operace dávaly správný výsledek. 
% Zde se budeme zabývat algebrogramy, tvořenými třemi či více řádky písmen. Každé z písmen chceme nahradit číslicí tak, aby 
% - stejné znaky byly nahrazeny stejnými číslicemi, různé znaky různými,
% - žádné číslo kromě nuly nezačínalo číslicí nula,
% - a číslo reprezentované posledním řádkem bylo součtem čísel, reprezentovaných předchozími řádky.

%     A B       1 9
%   + B A     + 9 1
%   -----     -----
%     A A C     1 1 0

% (a) Sestavte predikát cifry(+Ns, ?N), který uspěje, pokud Ns je seznam číslic přirozeného čísla N. Můžete předpokládat, že
% - Ns je seznam číslic (tj. celých čísel z intervalu 0 .. 9)
% - a N je buďto celé číslo nebo volná proměnná.

% ?- cifry([1,2,3], N).
% N = 123

% ?- cifry([1,2,3], 99).
% false

cifry([N], N).          % pokud je jen jednotka, vracime jednotku
cifry([N1|Ns], N) :-
    cifry(Ns, PrevN),   % volame rekurzivne na o jeden mensi rad (ten nejvyssi)
    length(Ns, Order),  
    N is (N1 * (10^Order)) + PrevN. % nasledujici cislo vyssiho radu je souctem predchoziho a aktualniho radu (desitky/stovky/tisice) s vynasobeno jeho patricnou hodnotou


% (b) Sestavte predikát cifry0(+Ns, ?N), který
% - selže, pokud Ns je seznam délky alespoň dva, který začíná nulou,
% - jinak vrací stejný výsledek jako cifry/2.

% ?- cifry0([0,1,2,3], 123).
% false

cifry0(Ns, N) :-        % slo by resit i if elsem
    length(Ns, Len),
    Len < 2,            % pokud se jedna o jednotky
    cifry(Ns, N).
cifry0([N1|Ns], N) :-
    length([N1|Ns], Len),
    Len >= 2,           % pokud se jedna o cisla vyssich radu,
    N1 \= 0,            % nesmi zacinat nulou.
    cifry([N1|Ns], N).


% (c) Sestavte predikát gen(+Xs), který
% - obdrží seznam Xs volných proměnných,
% - každé proměnné přiřadí číslici (v intervalu 0..9) tak, že hodnoty různých proměnných jsou různé
% - a postupně vrátí všechna řešení, každé právě jednou.
% Můžete předpokládat, že proměnné ve vstupním seznamu jsou navzájem různé.

% ?- gen([X,Y]).
% X = 0, Y = 1 ;
% X = 0, Y = 2 ;
% X = 0, Y = 3 ;
% ...
% Připomeňme, že můžete používat knihovní predikáty z naší referenční příručky včetně těch z odstavce "Aritmetické predikáty".

% Predikát assign_values(Xs, Digits) přiřadí proměnným v Xs hodnoty z Digits, přičemž každé proměnné přiřadí unikátní hodnotu.
assign_values([], _).
assign_values([X|Xs], Digits) :-
    select(X, Digits, RemainingDigits),     % Vybere X z Digits a vrátí RemainingDigits
    assign_values(Xs, RemainingDigits).

digits([0, 1, 2, 3, 4, 5, 6, 7, 8, 9]).

% gen(Xs) :- 
%     digits(Digits),
%     assign_values(Xs, Digits).


% (d) Sestavte predikát alg(+Xs,+Ys,+Zs), který
% - obdrží tři seznamy volných proměnných, které představují řádky algebrogramu
% - a postupně vrátí všechna jeho řešení, každé právě jednou.
% Proměnné se samozřejmě mohou opakovat, jak v jednom řádku, tak v různých řádcích.

% ?- alg([A,B],[B,A],[A,A,C]).
% A = 1, B = 9, C = 0 ;
% false.

alg(Xs, Ys, Zs) :-
    maplist(between(0, 9), Xs),
    maplist(between(0, 9), Ys),
    maplist(between(0, 9), Zs),
    cifry0(Xs, X), cifry0(Ys, Y), cifry0(Zs, Z),
    Z is X + Y.


% (e) Předchozí predikát zobecněte na algebrogramy s vyšším počtem řádků: sestavte predikát alg(+Xss), který
% - obdrží seznam seznamů volných proměnných, který reprezentuje algebrogram o alespoň třech řádcích
% - a postupně vrátí všechna jeho řešení, každé právě jednou.

% ?- alg([[T,R,I],[K,R,A,T],[T,R,I],[D,E,V,E,T]]).
% T = 2, R = 8, I = 5, K = 9, A = 3, D = 1, E = 0, V = 4 ;
% T = 3, R = 6, I = 5, K = 9, A = 7, D = 1, E = 0, V = 4 ;
% false.


% (f) Použili jste ve vašem řešení nějaký predikát vyššího řádu (tj. predikát, jehož argumentem je jiný predikát)? Pokud ne, vysvětlete, kde by se dal smysluplně použít.










%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5


% % A cifry(+Ns, ?N)
% % cifry([1,2,3], N). -> N = 123
% % cifry([1,2,3], 99). -> false
% cifry(Ns, Num) :-
%     cifry_(Ns, Num, _).

% cifry_([N], N, 1).
% cifry_([N|Ns], NewNum, NewOrder) :-
%     cifry_(Ns, Num, Order),
%     NewOrder is Order * 10,
%     NewNum is Num + NewOrder * N.

% % B
% % cifry0(+Ns, ?N)
% cifry0([N|Ns], Num) :-
%     length([N|Ns], M),
%     (
%         M < 2
%     ;   M >= 2,
%         N \= 0
%     ),
%     cifry([N|Ns], Num).

% % C
% % gen(+-Xs)
% vals([0,1,2,3,4,5,6,7,8,9]).
% gen(Xs) :-
%     vals(Vals),
%     gen_(Xs, Vals).

% gen_([], _).
% gen_([X|Xs], Vals) :-
%     select(X, Vals, NewVals),
%     gen_(Xs, NewVals).

% % D
% % alg(+-XS, +-Ys, +-Zs).
% alg(Xs, Ys, Zs) :-
%     maplist(between(0, 9),Xs),
%     maplist(between(0, 9),Ys),
%     maplist(between(0, 9),Zs),

%     cifry0(Xs, NX),
%     cifry0(Ys, NY),
%     cifry0(Zs, NZ),

%     NZ is NX + NY.

% % E
% % alg([[T,R,I], [K,R,A,T], [T,R,I], [D,E,V,E,T]]).
% numbers([], Acc, Acc).
% numbers([Xs|Xss], Numbers, Acc) :-
%     cifry0(Xs, Cifry),
%     numbers(Xss, [Cifry|Numbers], Acc).


% alg(Xss) :-
%     length(Xss, L),
%     L >= 3,

%     maplist(maplist(between(0,9)), Xss),
%     numbers(Xss, [], [Result|Cifry]),
%     sum_list(Cifry, Result).
    

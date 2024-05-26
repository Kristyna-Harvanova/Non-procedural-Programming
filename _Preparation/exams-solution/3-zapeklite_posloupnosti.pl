
% 1. Prolog (10 bodů): Zapeklité posloupnosti

% Buď 𝑛 přirozené číslo a x0, x1,...,xn-1 posloupnost celých čísel splňujících 0 ≤ xi < n. 
% Takovou posloupnost nazveme zapeklitou, pokud každé celé číslo i, 0 ≤ i < n, se v posloupnosti vyskytuje právě xikrát. 
% Kupříkladu posloupnost: 
% 6210010000
% je zapeklitá (n=10), protože obsahuje 6 nul, 2 jedničky, 1 dvojku, 0 trojek atd.

% (a) V jazyce Prolog sestavte definici predikátu pocet(+X,+Xs,?N), který uspěje, pokud seznam Xs obsahuje právě N výskytů hodnoty X.
% ?- pocet(0,[2,1,2,0,0],2).
% true.

% ?- pocet(2,[2,1,2,0,0],N).
% N = 2

pocet(_, [], 0).  % pokud zbylo prazdne pole a prvky se odecetli na 0, obsahovalo pole presne tolik X, kolik melo
pocet(X, [X | Xs], N) :- 
  pocet(X, Xs, NewN),   % pokud narazime v poli na hledany prvek, volame rekurzivne se snizenym N
  N is NewN + 1.        % snizeni je az tady, aby se mohlo pripadne doplnit, protoze neni +N, ale ?N
pocet(X, [X1 | Xs], N) :- 
  X \= X1,              % pokud se aktualni prvek pole s X neshoduje, hledame dale se stejnym poctem k najiti N.
  pocet(X, Xs, N).


% (b) Sestavte definici predikátu zp(+Xs), který uspěje, pokud zadaný seznam Xs představuje zapeklitou posloupnost. Můžete přitom využít pomocný predikát z části (a).
% ?- zp([6,2,1,0,0,0,1,0,0,0]).
% true.

% pomocna funkce, co dostane hledanou hodnotu Index, v jakem poli Xs a kolikrat (N) se ma nachazet v poli Xs.
zpHelp(_, _, []).
zpHelp(Index, Xs, [N | Ns]) :-  
  pocet(Index, Xs, N),
  NewIndex is Index + 1,
  zpHelp(NewIndex, Xs, Ns).

% zp(Xs) :-
%   zpHelp(0, Xs, Xs).


% (c) Zobecněte definici predikátu zp/1 tak, aby uměl zapeklité posloupnosti i generovat. Podrobněji:
% - pokud predikát v nové verzi zp(?Xs) obdrží seznam Xs volných proměnných,
% - vrátí v Xs postupně všechny zapeklité posloupnosti, jejichž délka odpovídá délce Xs.
% ?- length(Xs,4), zp(Xs).
% Xs = [1,2,1,0] ;
% Xs = [2,0,2,0] ;
% false.

% Nápověda: Vestavěný predikát between/3 zde může být užitečný.

zp(Xs) :-
  length(Xs, MaxN),
  maplist(between(0, MaxN), Xs),
  zpHelp(0, Xs, Xs).


% (d) Je možné dále rozšířit definici predikátu zp/1 tak, aby
% - postupně generoval (potenciálně) všechny zapeklité posloupnosti
% - pokud na vstupu obdrží volnou proměnnou?
% ?- zp(Xs).
% Xs = [] ;
% Xs = [1,2,1,0] ;
% Xs = [2,0,2,0] ;
% Xs = [2,1,2,0,0] ;
% ... (atd.)

% Pokud ano, definici predikátu zp/1 takto rozšiřte. Pokud ne, definujte nový predikát zpn/1, který bude takto fungovat:
% ?- zpn(Xs).
% Xs = [] ;
% Xs = [1,2,1,0] ;
% Xs = [2,0,2,0] ;
% Xs = [2,1,2,0,0] ;
% ... (atd.)


% je to mozne, uz to dokonce tak funguje.











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% % A
% % pocet(+X, +Xs, ?N)
% % pocet(0, [2,1,2,0,0], 2). -> true
% % pocet(0, [2,1,2,0,0], N). -> N = 2
% pocet(_, [], 0).
% pocet(X, [X|Xs], N) :-
%     pocet(X, Xs, NewN),
%     N is NewN + 1.

% pocet(X, [Y|Xs], N) :-
%     Y \= X,
%     pocet(X, Xs, N).

% % B
% % zp(+Xs)
% % zp([6,2,1,0,0,0,1,0,0,0]). -> true
% zp(Xs) :-
%     length(Xs, Len),
%     maplist(between(0,Len), Xs),
%     zp_(Xs, Xs, 0).

% zp_(_, [], _).
% zp_(List, [X|Xs], N) :-
%     pocet(N, List, X),
%     NewN is N + 1,
%     zp_(List, Xs, NewN).

% % C
% % length(Xs, 4), zp(Xs).
% % Xs = [1,2,1,0] ;
% % Xs = [2,0,2,0] 
% % revLen(Len, L) = length(L, Len).
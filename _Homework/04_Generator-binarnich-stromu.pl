% Binární strom lze v Prologu reprezentovat termem b(L, V, P), který obsahuje hodnotu kořene V, 
% levý podstrom L a pravý podstrom P. Prázdný strom lze reprezentovat atomem nil.

% a) Sestavte predikát vyššího řádu maptree/2, který aplikuje zadaný predikát P na vrcholy binárního stromu:
% maptree(+P, ?T) :- uspěje, pokud volání (unárního) predikátu P na argument V uspěje pro každý vrchol V stromu T.
% Nápověda: Inspirujte se definicí predikátu maplist na přednášce. Zejména můžete využít vestavěný predikát call, který aplikuje zadaný predikát P na zadaný argument.

% b) Sestavte predikát size(-T, +N, +H), který postupně vrátí všechny binární stromy T o N vrcholech a výšce H. 
% Výška stromu je definována jako délka nejdelší cesty (měřená počtem hran) z kořene do listu. 
% Např. strom b(nil, 10, t(nil, 15, nil)) má výšku 1. U prázdného stromu budeme předpokládat výšku -1.
% Predikát by měl vygenerovat všechny binární stromy se zadaným počtem vrcholů N ≥ 0 a zadanou výškou H ≥ -1. 
% Ve vrcholech generovaných stromů budou volné proměnné, které můžeme navázat na konkrétní hodnotu predikátem maptree, jak je uvedeno v příkladech níže.

% ?- size(T, 3, 2), maptree(=(1), T).
% T = b(nil, 1, b(nil, 1, b(nil, 1, nil))) ;
% T = b(nil, 1, b(b(nil, 1, nil), 1, nil)) ;
% T = b(b(nil, 1, b(nil, 1, nil)), 1, nil) ;
% T = b(b(b(nil, 1, nil), 1, nil), 1, nil)

% ?- size(T, 1, 1).
% false

% ?- size(T, 2, 1), maptree(=(0), T).
% T = b(nil, 0, b(nil, 0, nil)) ;
% T = b(b(nil, 0, nil), 0, nil) 

% ?- size(T, 6, 2), maptree(=(2), T).
% T = b(b(nil, 2, b(nil, 2, nil)), 2, b(b(nil, 2, nil), 2, b(nil, 2, nil))) ;
% T = b(b(b(nil, 2, nil), 2, nil), 2, b(b(nil, 2, nil), 2, b(nil, 2, nil))) ;
% T = b(b(b(nil, 2, nil), 2, b(nil, 2, nil)), 2, b(nil, 2, b(nil, 2, nil))) ;
% T = b(b(b(nil, 2, nil), 2, b(nil, 2, nil)), 2, b(b(nil, 2, nil), 2, nil)) 

% Instrukce:
% Můžete samozřejmě používat operátory (např. is) či knihovní predikáty (např. call, between), které již byly na přednášce či na cvičení probrány.
% Naopak prosím nepoužívejte prostředky, které jsme dosud neprobírali!

% A help predicate to find the maximum of two numbers, with the result in the third argument.
max(A, B, R) :- A >= B, R is A.
max(A, B, R) :- A < B, R is B.

% a)
maptree(_, nil).            % The base case, the tree is empty.
maptree(P, b(L, V, R)) :-   % The recursive case, the tree is not empty.
    call(P, V),
    maptree(P, L),
    maptree(P, R).

% b)
size(T, 0, -1) :- T = nil.  % The base case, the tree is empty.
size(T, N, H) :-            % The recursive case, the tree is not empty.
    T = b(L, _, R),         % The tree is not empty, so we can extract the left and right subtrees.
    N1 is N - 1,            % The number of nodes in both subtrees together (without the root).
    between(0, N1, NL), NR is N1 - NL,  % The number of nodes in the left and right subtrees.
    H1 is H - 1,            % The height of both subtrees together (without the root).
    between(-1, H1, HL), between(-1, H1, HR), max(HL, HR, H1),  % The height of the left and right subtrees.
    size(L, NL, HL),        % The left subtree.
    size(R, NR, HR).        % The right subtree.

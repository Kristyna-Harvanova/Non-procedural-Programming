% Uvažme jednoduchou variantu hry Hledání min, v níž hrací pole obsahuje jen dva řádky:

% 1 1 2 1 1 1 1 1
% ? ? ? ? ? ? ? ?

% Každé políčko v horní řadě zobrazuje viditelné číslo mezi 0 a 3. 
% Spodní řada nezobrazuje žádné hodnoty, ovšem každé její políčko může obsahovat skrytou minu. 
% Každé číslo v horní řadě udává počet sousedních políček (svisle nebo diagonálně), která obsahují minu.

% Pro výše uvedené hrací pole jsou miny na následujícících pozicích:

% 1 1 2 1 1 1 1 1
% o x o x o o x o

% V jazyce Prolog sestavte predikát miny(Pocty, Miny), který uspěje, pokud
%  - 'Pocty' představuje seznam přirozených čísel, který reprezentuje horní řadu
%  - zatímco seznam 'Miny' reprezentuje dolní řadu, přičemž atom x označuje minu, zatímco atom o políčko bez miny.

% Predikát by měl fungoval obousměrně, tj. k zadanému druhému řádku Miny vrátit odpovídající první řádek Pocty
% ?- miny(Pocty, [o, x, o, x, o, o, x, o]).
% Pocty = [1, 1, 2, 1, 1, 1, 1, 1]

% či naopak k zadanému prvnímu řádku vrátit odpovídající druhý:
% ?- miny([1, 1, 2, 1, 1, 1, 1, 1], Miny).
% Miny = [o, x, o, x, o, o, x, o]

% Pokud existuje více řešení, predikát by měl vrátit každé právě jednou:
% ?- miny([1,1], Miny).
% Miny = [o, x] ;
% Miny = [x, o] 

% Predikát by měl fungovat i v případě, že argumenty obsahují jak konstanty, tak volné proměnné:
% ?- miny([A, 2, 1, B, 1, 1, 1, C, 1, 2, D], 
%         [x, o, E, o, o, F, o, o, G, H, x]).
% A = B, B = 1,
% C = 0,
% D = 2,
% E = F, F = H, H = x,
% G = o ;
% A = B, B = C, C = D, D = 1,
% E = F, F = G, G = x,
% H = o 

% Další příklady:
% ?- length(Pocty, 3), miny(Pocty, Miny).
% Pocty = [0,0,0],
% Miny = [o,o,o] ;
% Pocty = [0,1,1],
% Miny = [o,o,x] ;
% Pocty = [1,1,1]
% Miny = [o,x,o] ;
% Pocty = [1,2,2],
% Miny = [o,x,x] ;
% Pocty = [1,1,0],
% Miny = [x,o,o] ;
% Pocty = [1,2,1],
% Miny = [x,o,x] ;
% Pocty = [2,2,1],
% Miny = [x,x,o] ;
% Pocty = [2,3,2],
% Miny = [x,x,x]

% ?- length(Pocty, 20), maplist(=(1), Pocty), miny(Pocty, Miny).
% % maplist/2 budeme probírat na příští přednášce
% % zde nám jen vygeneruje seznam ze samých jedniček
% Pocty = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
% Miny = [o, x, o, o, x, o, o, x, o, o, x, o, o, x, o, o, x, o, o, x] ;
% Pocty = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
% Miny = [x, o, o, x, o, o, x, o, o, x, o, o, x, o, o, x, o, o, x, o]

% Instrukce:
% Můžete samozřejmě používat již probrané operátory (např. is/2) a knihovní predikáty (např. append/3, between/3 či same_length/2).
% Naopak prosím nepoužívejte prostředky, které jsme dosud neprobírali! Pro řešení zadané úlohy opravdu stačí jen ty výše uvedené.
% Povšimněte si, že kdybychom spodní řadu reprezentovali čísly 0 a 1 (namísto atomy o a x), platilo by, 
% že každé číslo v horní řadě je součtem tří odpovídajících čisel pod ním. Nešlo by toto pozorování nějak využít pro řešení úlohy?

% Defining atoms.
mine2num(x, 1). % mine
mine2num(o, 0). % no mine

% Evaluates if the number of mines in Pocet's neighbourhood from Miny (translated to numbers MinyNums) is equal to the number Pocet.
correct_num_of_mines([], _).                                    % Base case - empty lists.                            
correct_num_of_mines([Pocet|Pocty], [X1,X2,X3|MinyNums]) :-     % Recursive case - handles the entire list.
    Pocet is X1 + X2 + X3,
    correct_num_of_mines(Pocty, [X2,X3|MinyNums]).
correct_num_of_mines([Pocet], [X1,X2]) :-                       % Handling the last element (or the first one if the list has only one element - with leading 0) separately.
    Pocet is X1 + X2.

% Evaluates correctness the whole list of mines and numbers.
miny(Pocty, Miny) :- 
    same_length(Pocty, Miny),                   % Ensures Pocty and Miny have the same length.
    maplist(mine2num, Miny, MinyNums),          % Converts 'x' and 'o' to 1 and 0.
    correct_num_of_mines(Pocty, [0|MinyNums]).  % Adds a leading 0 to handle the first element edge case correctly.





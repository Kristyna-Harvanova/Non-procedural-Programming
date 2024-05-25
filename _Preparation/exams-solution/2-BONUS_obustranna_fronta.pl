% BONUS Prolog (jen 5 bodů): Oboustranná fronta

% Cílem této úlohy je implementovat v jazyce Prolog oboustrannou frontu, 
% z níž bychom mohli odebírat i přidávat prvky na začátek i na konec v amortizovaném čase O(1).

% Nápověda: Frontu reprezentujte dvojicí seznamů predni (obsahuje počáteční část fronty) 
% a zadni (obsahuje otočený zbytek). Fronta je tedy tvořena prvky seznamu predni, 
% po nichž následují prvky seznamu zadni, ovšem v obráceném pořadí. 
% Kupříkladu pro predni = [2, 4] a zadni = [10, 8, 6] fronta obsahuje prvky 2, 4, 6, 8, 10. 
% Při pokusu o odebrání prvku z prázdného seznamu frontu znovu "vyvážíme": druhý seznam 
% rozdělíme na dvě stejně dlouhé části a vhodnou polovinu přesuneme do původně prázdného seznamu.

% (a) Popište term, jakým budete oboustrannou frontu v Prologu reprezentovat, 
% a sestavte predikát empty/1, který vrátí prázdnou frontu.

% (b) Sestavte predikáty add_first/3 a add_last/3, které
% - obdrží frontu a nový prvek
% - vloží prvek na začátek či na konec fronty
% - a novou frontu vrátí.
% - Obě operace by měly pracovat v konstantním čase.

% (d) Sestavte predikát list2deq(?Xs, ?Fronta), který uspěje, pokud Xs je seznam prvků oboustranné 
% fronty Fronta. Predikát by měl fungovat v obou směrech v tomto smyslu
% - list2deq(?Xs, ?Fronta) ověří, zdali zadaný Xs reprezentuje zadanou Frontu
% - list2deq(+Xs, -Fronta) pro zadaný seznam Xs vrátí odpovídající Frontu
% - list2deq(-Xs, +Fronta) pro zadanou Frontu vrátí odpovídající seznam Xs

% (e) Použili jste ve vašem řešení řez? Pokud ano, jde o řez červený (mění deklarativní význam programu) 
% či zelený (nemění deklarativní význam)? Pokud ne, dal by se někde řez smysluplně použít?

% Příklad:
% ?- list2deq([1,2,3],F), rem_last(F,X,F2),
%    add_first(F2,0,F3), list2deq(Xs,F3).
% ...
% Xs = [0, 1, 2, 10].


% Part (a): Define the term and the empty/1 predicate
% Term Representation:
% We represent the deque using two lists: front and back. The term can be represented as deque(Front, Back).

% empty/1 predicate
empty(deque([], [])).


% Part (b): Define the add_first/3 and add_last/3 predicates
% add_first/3 Predicate:
% This predicate adds an element to the front of the deque.

% add_first/3 predicate
add_first(Element, deque(Front, Back), deque([Element|Front], Back)).

% add_last/3 Predicate:
% This predicate adds an element to the back of the deque.

% add_last/3 predicate
add_last(Element, deque(Front, Back), deque(Front, [Element|Back])).


% Part (c): Define the rem_first/3 and rem_last/3 predicates
% rem_first/3 Predicate:
% This predicate removes an element from the front of the deque.

% rem_first/3 predicate
rem_first(Element, deque([Element|Front], Back), deque(Front, Back)).
rem_first(Element, deque([], Back), deque(NewFront, [])) :-
    reverse(Back, [Element|NewFront]).

% rem_last/3 Predicate:
% This predicate removes an element from the back of the deque.

% rem_last/3 predicate
rem_last(Element, deque(Front, [Element|Back]), deque(Front, Back)).
rem_last(Element, deque(Front, []), deque([], NewBack)) :-
    reverse(Front, [Element|NewBack]).


% Part (d): Define the list2deq/2 predicate
% list2deq/2 Predicate:
% This predicate converts a list to a deque and vice versa.

% list2deq/2 predicate
list2deq(List, deque(Front, Back)) :-
    append(Front, ReversedBack, List),
    reverse(Back, ReversedBack).


% Part (e): Discussion about the use of cuts (Řez)
% The use of cuts (!) in Prolog can help optimize the program by preventing unnecessary backtracking. Whether a cut is declarative or procedural depends on the context.

% Declarative cut (green cut): It does not change the logic of the program but improves efficiency.
% Procedural cut (red cut): It changes the logic and meaning of the program.
% In the provided example, we may use cuts to improve the efficiency of predicates where backtracking is not necessary.

% Here's how you could add cuts to the above predicates where they make sense:

% rem_first/3 predicate with cuts
rem_first(Element, deque([Element|Front], Back), deque(Front, Back)) :- !.
rem_first(Element, deque([], Back), deque(NewFront, [])) :-
    reverse(Back, [Element|NewFront]).

% rem_last/3 predicate with cuts
rem_last(Element, deque(Front, [Element|Back]), deque(Front, Back)) :- !.
rem_last(Element, deque(Front, []), deque([], NewBack)) :-
    reverse(Front, [Element|NewBack]).

% These cuts ensure that once the correct clause is found, no further unnecessary backtracking is performed.


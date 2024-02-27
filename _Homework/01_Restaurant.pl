% Restaurant

% Write a Prolog program that can solve the following logic puzzle.

% David, Emma, Stella, and Thomas were at a restaurant in Prague. They sat at a square table, with one person on each side, and the men sat across the table from each other, as did the women. Each of them ordered a different food along with a different beverage. Also:

% The person with cider sat across from the person with trout.
% The dumplings came with beer.
% The mushroom soup came with cider.
% The person with pasta sat across from the person with beer.
% David never drinks iced tea.
% Emma only drinks wine.
% Stella does not like dumplings.
% Who ordered which food?

% Your program should include a predicate 'solve' that takes four arguments. solve(Dumplings, Pasta, Soup, Trout) should return the names of the people who ordered each dish. Names are lowercase Prolog atoms. For example, if rule 7 above were absent, the output might begin like this:

% ?- solve(Dumplings, Pasta, Soup, Trout).
% Dumplings = stella,
% Pasta = emma,
% Soup = david,
% Trout = thomas ;
% ...
% Of course, your output will be different, since with rule 7 the above output is not a valid solution.

person(david).
person(emma).
person(stella).
person(thomas).

man(david).
man(thomas).
woman(emma).
woman(stella).

across(Who1, Who2) :- 
    person(Who1), person(Who2),
    Who1 \= Who2,
    (
        (man(Who1), man(Who2));
        (woman(Who1), woman(Who2))
    ).

food(trout).
food(dumplings).
food(soup).
food(pasta).

beverage(cider).
beverage(beer).
beverage(icedTea).
beverage(wine).

order(Who, Food, Beverage) :- 
    person(Who),
    food(Food),
    beverage(Beverage).

contains(Order, orders(O1, O2, O3, O4)) :-
    Order = O1; Order = O2; Order = O3; Order = O4.

solve(Dumplings, Pasta, Soup, Trout) :-
    Orders = orders(order(Dumplings, dumplings, _), order(Pasta, pasta, _), order(Soup, soup, _), order(Trout, trout, _)),
    contains(order(Who1, _, cider), Orders), contains(order(Who2, trout, _), Orders), across(Who1, Who2),
    contains(order(_, dumplings, beer), Orders),
    contains(order(_, soup, cider), Orders),
    contains(order(Who3, pasta, _), Orders), contains(order(Who4, _, beer), Orders), across(Who3, Who4),
    contains(order(david, _, Beverage), Orders), Beverage \= icedTea,
    contains(order(emma, _, wine), Orders),
    contains(order(stella, Food, _), Orders), Food \= dumplings,
    Dumplings \= Pasta, Dumplings \= Soup, Dumplings \= Trout, Pasta \= Soup, Pasta \= Trout, Soup \= Trout.

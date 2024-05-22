
:- use_module(library(clpfd)).

% ["_Preparation\\exams-solution\\1-hladke_matice.pl"]. 


%% a) test(?X, ?Y), pokud [X, Y] je hladnky seznam

% test(+X, ?Y)
test(X, Y) :- 
    nonvar(X),
    A is X - 1,
    B is X + 1,
    between(A, B, Y).

% test(-X, +Y)
test(X, Y) :-
    nonvar(Y), var(X),
    A is Y - 1,
    B is Y + 1,
    between(A, B, X).


%% b) hladky(+Xs), pokud seznam Xs je hladky

% hladky([_]).                % konec rekurze, pokud mame jednoprvkovy seznam, je hladky
% hladky([X1, X2 | Xs]) :-    
%     test(X1, X2),           % test, jestli prvni dva vybrane sousedni prvky jsou hladke
%     hladky([X2 | Xs]).      % rekurzivni volani na seznam pocinaje druhym prvkem pro kontrolu vsech dvojic


%% c) hladky(?Xs) zobecnit pro generovani hladkych seznamu

hladky([_]).    % (stop pravidlo) konec rekurze, pokud mame jednoprvkovy seznam, je hladky

hladky([X1, X2 | Xs]) :-    
    nonvar(X1),             % pripad, kdy zname hodnotu prvniho prvku aktualne testovaneho pole. 
    test(X1, X2),
    hladky([X2 | Xs]).

hladky([X1, X2 | Xs]) :-    
    var(X1), nonvar(X2),    % pripad, kdy zname hodnotu druheho prvku aktualne testovaneho pole.
    test(X1, X2),
    hladky([X2 | Xs]).

hladky([X1, X2 | Xs]) :-
    var(X1), var(X2),       % pripad, kdy nezname hodnoty prvniho a druheho prvku
    hladky([X2 | Xs]),      % nejdriv zavolame ulohu rekurzivne na podpole
    test(X1, X2).           % po rekurzi a zjisteni hodnoty druheho prvku muzeme doplnit hodnotu prvniho prvku.


%% d) hladka(+Xss), pokud Xss je hladka matice

% Pomocny predikat pro kontrolu, jestli je matice hladka ve vsech svych radcich.
% hladke_radky_matice([Xs]) :- hladky(Xs).   % konec rekurze
% hladke_radky_matice([Xs | Xss]) :-  
%     hladky(Xs),                     % kontrola hladkosti radku
%     hladke_radky_matice(Xss).       % rekurzivni volani na dalsi radky

% hladka(Xss) :-                  
%     hladke_radky_matice(Xss),       % kontrola hladkosti radku matice Xss
%     transpose(Xss, Yss),    
%     hladke_radky_matice(Yss).       % kontrola hladkosti sloupcu matice Xss (neboli radku transponovane matice Xss)


%% e) hladka(?Xss) zobecnit pto generovani hladkych matic

hladke_radky_matice([Xs]) :- hladky(Xs).   % konec rekurze
hladke_radky_matice([Xs | Xss]) :-  
    hladky(Xs),                     % kontrola hladkosti radku
    hladke_radky_matice(Xss).       % rekurzivni volani na dalsi radky

hladka([Xs | Xss]) :-                  
    hladky(Xs),                     % vytvoreni konkretnich hodnot v prvnim radku matice
    transpose([Xs | Xss], Yss),     
    hladke_radky_matice(Yss),       % vytvoreni hodnot ve vsech sloupcich matice z prvniho cisla tak, aby byly sloupce hladke
    hladke_radky_matice([Xs | Xss]).% test, jestli doplnene hodnoty do sloupcu sedi s podminkou hladkosti radku matice
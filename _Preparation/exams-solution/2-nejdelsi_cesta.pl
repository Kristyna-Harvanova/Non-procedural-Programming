% ["_Preparation\\exams-solution\\2-nejdelsi_cesta.pl"]. 
% cesta([a-[b], b-[a, c, e], c-[b, d, f]], [a, b, c, d, e, f], C).
% cesta([a-[b], b-[a, c, e], c-[b, d, f], d-[e]], [a, b, c, d, e, f], C). 
% cesta([a-[b], b-[a, c, e], c-[b, d, f], d-[e], e-[f]], [a, b, c, d, e, f], C).

%% a) cesta(+G, +S, -C), graf G je graf jako seznam sousedu, vrcholy S jako seznam a vraci cestu C jako seznam.

% pomocny predikat pro nalezeni sousedu daneho vrcholu
najdiSousedy(V, G, Ss) :-
    member(V-Ss, G);    % pokud je vrchol V zaznamenan v grafu a ma nejake sousedy Ss
    Ss = [].            % pokud vrchol neni zaznamenan v grafu G, nema ani zadne sousedy Ss.

% pomocny predikat pro nalezeni cesty s ukladanim dane cesty.
cestaAcc(_, [], C, C).              % konec rekurze, kdy uz nemame zadny vrchol, co lze pridat do cesty.

cestaAcc(G, [S1 | S], [], CAcc) :-  
    cestaAcc(G, S, [S1], CAcc).     % pridani prvniho vrcholu, kde nemusime testovat sousedy predesleho vrcholu v ceste (zadna jeste neni)

cestaAcc(G, [S1 | S], C, CAcc) :-
    \+ member(S1, C),                   % prvni, jeste nepouzity vrchol
    reverse([Posledni | _], C),         % vybereme posledni pridany vrchol do cesty
    najdiSousedy(Posledni, G, Sousedi),  
    (   
        member(S1, Sousedi),            % a pokud bude v sousedech posledniho pridaneho,
        append(C, [S1], NewC),          % muzeme pridat i novy vrchol
        cestaAcc(G, S, NewC, CAcc)      % volame znovu na stejny graf, o jedno mensi seznam vrcholu a novou cestu.
    );(
        cestaAcc(G, S, C, CAcc)         % pokud to nebyl soused, zkusime znovu s dalsim vrcholem.
        % cestaAcc(G, [S | S1], C, CAcc)         % takto pridanim na konec zkusime vrchol znovu a treba bude v sousedech jineho vrcholu, ale zacykli se to.

    ).

% hlavni predikat k nalezeni cesty
cesta(G, S, C) :-
    cestaAcc(G, S, [], C).


%% b) nejcesta(+G, +S, -C), vyuziti Posovy heuristiky

nejcestaAcc(_, [], C, C).              % konec rekurze, kdy uz nemame zadny vrchol, co lze pridat do cesty.

nejcestaAcc(G, [S1 | S], [], CAcc) :-  
    nejcestaAcc(G, S, [S1], CAcc).     % pridani prvniho vrcholu, kde nemusime testovat sousedy predesleho vrcholu v ceste (zadna jeste neni)

nejcestaAcc(G, [S1 | S], C, CAcc) :-
    \+ member(S1, C),                   % prvni, jeste nepouzity vrchol
    reverse([Posledni | _], C),         % vybereme posledni pridany vrchol do cesty
    najdiSousedy(Posledni, G, Sousedi),  
    (   
        member(S1, Sousedi),            % a pokud bude v sousedech posledniho pridaneho,
        append(C, [S1], NewC),          % muzeme pridat i novy vrchol
        nejcestaAcc(G, S, NewC, CAcc)      % volame znovu na stejny graf, o jedno mensi seznam vrcholu a novou cestu.
    );(
        nejcestaAcc(G, S, C, CAcc)         % pokud to nebyl soused, zkusime znovu s dalsim vrcholem.
        % nejcestaAcc(G, [S | S1], C, CAcc)         % takto pridanim na konec zkusime vrchol znovu a treba bude v sousedech jineho vrcholu, ale zacykli se to.

    ).

% hlavni predikat k nalezeni cesty
nejcesta(G, S, C) :-
    nejcestaAcc(G, S, [], C).








% Helper predicate to check if an edge exists between two vertices in the graph
% edge(G, X, Y) :-
%     member(X-[Y|_], G);
%     member(Y-[X|_], G).
% edge(G, X, Y) :-
%     member(X-[_|T], G),
%     edge([X-T], X, Y).

% % Predicate to find the path
% cestaC(G, S, C) :-
%     cesta_helper(G, S, [], C).

% % Base case: when no more vertices can be added, return the current path
% cesta_helper(_, [], Path, Path).

% % Recursive case: try to extend the path with the first usable vertex
% cesta_helper(G, [H|T], [], C) :-
%     cesta_helper(G, T, [H], C).
% cesta_helper(G, [H|T], [Last|Path], C) :-
%     edge(G, Last, H),
%     cesta_helper(G, T, [H, Last|Path], C).
% cesta_helper(G, [_|T], Path, C) :-
%     cesta_helper(G, T, Path, C).

% Example query:
% ?- cesta([a-[b], b-[a,c,e], c-[b,d,f], d-[c,e,f], e-[b,d,f], f-[c,d,e]], [a,b,c,d,e,f], C).
% C = [a, b, c, d, e].






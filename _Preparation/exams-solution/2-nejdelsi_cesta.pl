% ["_Preparation\\exams-solution\\2-nejdelsi_cesta.pl"]. 
% cesta([a-[b], b-[a, c, e], c-[b, d, f]], [a, b, c, d, e, f], C).
% cesta([a-[b], b-[a, c, e], c-[b, d, f], d-[e]], [a, b, c, d, e, f], C). 
% cesta([a-[b], b-[a, c, e], c-[b, d, f], d-[e], e-[f]], [a, b, c, d, e, f], C).

%% a) cesta(+G, +S, -C), graf G je graf jako seznam sousedu, vrcholy S jako seznam a vraci cestu C jako seznam.

cesta(_, [], _).

% cesta(_, [S1 | S], _) :-
%     append([], S1, C),
%     cesta(_, S, C).


existuje_hrana([V-Sousede | G], V1, V2) :-
    

cesta([V-Sousede | G], [S1 | S], C) :-
    \+member(S1, C),
    member(S1, Sousede),
    append(C, S1, newC),
    cesta(G, S, newC).

    
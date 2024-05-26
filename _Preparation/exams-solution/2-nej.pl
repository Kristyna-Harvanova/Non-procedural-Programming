% 11:40 - 12:50
% nevím, jestli to funguje, ale na následujícím příkladě to aspoň najde delší cestu:
%   nejcesta([a-[b],b-[a,c,d],c-[b,d,e],d-[b,c],e-[c,f],f-[e]], [a,b,c,d,e,f], C).

cesta(G, S, Cesta) :- cesta(G, S, [], C), reverse(C, Cesta).

cesta(_, [], Aku, Aku) :- !. % došly vrcholy => vrátíme akumulátor
cesta(G, [V|S], [], Cesta) :- !, cesta(G, S, [V], Cesta). % začínáme vytvářet cestu => jednoduše první vrchol z S
cesta(G, S, [A|Aku], Cesta) :-
    member(A-Naslednici, G), % najdeme následníky posledního vrcholu na cestě
    select(V, S, S1), % vybereme nějaký ze zbývajících vrcholů
    (
        member(V, Naslednici), % který lze připojit k poslednímu
        !,
        cesta(G, S1, [V,A|Aku], Cesta) % a rekurzivně jdeme dál
        ;
        \+ member(V, Naslednici), % nebo když nejde připojit
        !,
        cesta(G, [], [A|Aku], Cesta) % tak vynutíme bázi rekurze
    ).

nejcesta(G, S, Cesta) :- nejcesta(G, S, [], C), reverse(C, Cesta).

nejcesta(_, [], Aku, Aku) :- !. % došly vrcholy => vrátíme akumulátor
nejcesta(G, [V|S], [], Cesta) :- !, nejcesta(G, S, [V], Cesta). % začínáme vytvářet cestu => jednoduše první vrchol z S
nejcesta(G, S, [A|Aku], Cesta) :-
    member(A-Naslednici, G), % najdeme následníky posledního vrcholu na cestě
    select(V, S, S1), % vybereme nějaký ze zbývajících vrcholů
    (
        member(V, Naslednici), % který lze připojit k poslednímu
        !,
        nejcesta(G, S1, [V,A|Aku], Cesta) % a rekurzivně jdeme dál
        ;
        \+ member(V, Naslednici), % nebo když nejde připojit
        !, % tak Pósova heuristika
        nejcestaPosovaH(G, S, [A|Aku], Cesta)
    ).

nejcestaPosovaH(G, S, [D|Aku], Cesta) :-
    append(NovejsiCast, [C,B|StarsiCast] , [D|Aku]), % hledáme na cestě hranu B-C
    member(B-NasledniciB, G),
    member(D, NasledniciB), % B-D je hrana
    member(C-NasledniciC, G),
    member(E, NasledniciC), % C-E je hrana
    select(E, S, S1), % E je povolený vrchol
    reverse(NovejsiCast, NovejsiCastRev), % otočíme novější část
    append([E,C|NovejsiCastRev], [B|StarsiCast], Aku1), % spojíme do nové cesty
    cesta(G, S1, Aku1, Cesta), % a rekurzivně pokračujeme
    !.

nejcestaPosovaH(G, _, Aku, Cesta) :- cesta(G, [], Aku, Cesta). % heuristika selhala => vynutíme bázi rekurze

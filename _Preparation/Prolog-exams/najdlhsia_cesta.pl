%cesta(+G, +Vs, -C).
cesta(G, Vs, C) :-
    cesta_(G, Vs, [], C).


add(G, [V|Vs], V_in, V_out) :-
    select(V_in-Ns, G, Rest),
    (find_neigh(Ns, V, V1) ->
        V_out = V1;
    add(Rest, Vs, V_in, V_out)
    ).
    
find_neigh([V|_], V, V):- !.
find_neigh([_|Ns], V, V_out) :-
    find_neigh(Ns, V, V_out).




cesta_(_, [], C_in, C_out) :-
    reverse(C_in, C_out).
cesta_(G, [V|Vs], [], C_out) :-
    cesta_(G, Vs, [V], C_out).
cesta_(G, Vs, [X|Xs], C_out) :-
    (add(G, Vs, X, X1) ->
        delete(Vs, X1, VsNew),
        cesta_(G, VsNew, [X1,X|Xs], C_out);

        reverse([X|Xs], C_out)
        ).


%cesta([a-[b], b-[a,c,e], c-[b,d,f], d-[e,f]], [a,b,c,d,e,f], C).

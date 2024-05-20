%pruchod(+G, +V, -OG)
pruchod(G, V, OG) :- dfs(V, G, 1, _, OG).
%dfs(+G, +Vx, +T1, -T2, -OG)


dfsList([], G, T1, T1, G).
dfsList([V|Ns], G1, T1, T3, Gout) :-
    dfs(V, G1, T1, T2, G2),
    dfsList(Ns, G2, T2, T3, Gout).

dfs(V, G1, T1, T4, OG) :-
    stampVertex(V, G1, NewG, In, Out, [], Ns),
    In = T1,
    T2 is T1 + 1,
    dfsList(Ns, NewG, T2, T3, OG),
    Out = T3,
    T4 is T3 + 1, 
    !.

dfs(_, G, T, T, G).

stampVertex(V, [V-Ns|Xs], G_out, T_in, T_out, A, Ns) :-
    reverse(A, Rev_A),
    append([Rev_A, [V/T_in/T_out-Ns|Xs]], G_out),
    !.
stampVertex(V, [U-Ns|XS], G_out, T_in, T_out, A, X) :-
    stampVertex(V, XS, G_out, T_in, T_out, [U-Ns|A], X).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

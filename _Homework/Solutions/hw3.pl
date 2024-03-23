cone([o,o,o], 0).
cone(R, 1) :- select(x, R, [o,o]).
cone(R, 2) :- select(o, R, [x,x]).
cone([x,x,x], 3).

match([_,_], []).
match([A,B,C|R], [M|RM]) :- cone([A,B,C],M), match([B,C|R], RM).

miny(Pocty, Miny) :- same_length(Pocty, Miny), append([[o],Miny,[o]], MinyLong), match(MinyLong, Pocty).

table([1000-[m],900-[c,m],500-[d],400-[c,d],100-[c],90-[x,c],50-[l],40-[x,l],10-[x],9-[i,x],5-[v],4-[i,v],1-[i]]).

add([V-Rep|Rest], N, R) :-
    N >= V, N2 is N - V,
    add([V-Rep|Rest], N2, R2),
    append(Rep, R2, R).
add([V-_|Rest], N, R) :-
    N > 0, N < V,
    add(Rest, N, R).
add(_, 0, []).

roman(N, R) :- between(0, 3999, N), table(T), add(T, N, R).
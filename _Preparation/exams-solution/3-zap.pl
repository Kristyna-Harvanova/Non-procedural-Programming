% 15:57 - 16:37

pocet(X, Xs, N) :-
    include(=(X), Xs, Equal), % v Equal budou prvky z Xs unifikovatelné s X
    length(Equal, N). % chceme, aby jich bylo N

% prvky seznamu jsou mezi 0 a Max (umí i generovat)
seq([],_).
seq([X|Xs], Max) :- between(0, Max, X), seq(Xs, Max).

zp(Xs) :-
    length(Xs, Len), % umí i generovat [],0; [_],1; ...
    Max is Len-1,
    seq(Xs, Max), % zkontroluje rozsahy / vygeneruje posloupnost
    zp(Xs, Xs, 0).

zp(_, [], _).
zp(Xs, [Xi|Xis], I) :-
    pocet(I, Xs, Xi), % I se vyskytuje v Xs Xi-krát
    I1 is I+1,
    zp(Xs, Xis, I1).


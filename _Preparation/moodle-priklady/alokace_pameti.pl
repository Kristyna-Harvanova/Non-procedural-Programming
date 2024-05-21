% Na vstupu obdržíme informaci o úsecích obsazené paměti ve tvaru seznamu dvojic Zacatek-DelkaUseku, přičemž

% úseky jsou v seznamu uspořádány vzestupně dle počáteční adresy,
% úseky nenavazují bezprostředně na sebe, tj. navazující úseky jsou vždy spojeny do jedné položky ve vstupním seznamu.
% Dále obdržíme seznam délek úseků, které potřebujeme obsadit.

% Cílem problému je sestavit predikát alokace(+Alokovat, +Obsazeno, -Umisteni, -NoveObsazeno), který

% pro každý požadavek ze seznamu Alokovat obsadí v paměti první volný úsek, kam se požadovaná velikost vejde (heuristika First Fit),
% vrátí v seznamu Umisteni polohy alokovaných úseků ve tvaru dvojic DelkaUseku-Zacatek,
% a v seznamu NoveObsazeno nový seznam obsazených úseků ve tvaru splňujícím podmínky 1-2 výše.
% Můžete předpokládat, že adresy jsou celá nezáporná čísla a první obsazovaný úsek vždy začíná na adrese 0.

% Příklad:

% ?- alokace([100,10,50], [0-60,100-50,250-70], Umisteni, NoveObs).
% Umisteni = [100-150,10-60,50-320],
% NoveObs = [0-70,100-270].

% firstFit(Start, Len, Alloc, Pos, NewAlloc)
firstFit(Start, Len, [], Start, [Start-Len]).
firstFit(Start, Len, [Alloc-AllocLen | Rest], Pos, NewTaken) :-
    Start + Len =< Alloc -> Pos = Start, NewTaken = [Start-Len, Alloc-AllocLen | Rest];
    NewStart is Alloc + AllocLen, firstFit(NewStart, Len, Rest, Pos, RestTaken),
    NewTaken = [Alloc-AllocLen | RestTaken].

merge([], []).
merge([X], [X]).
merge([A-AL, B-BL | Rest], New) :-
    B is A + AL -> L is AL + BL, merge([A-L | Rest], New);
    merge([B-BL | Rest], RestNew), New = [A-AL | RestNew].

% alokace(Req, Taken, Pos, NewTaken)
alokace([], Taken, [], Taken).
alokace([Req | Reqs], Taken, [Req-Pos | PosRest], NewTaken) :-
    firstFit(0, Req, Taken, Pos, Unmerged),
    merge(Unmerged, Merged),
    alokace(Reqs, Merged, PosRest, NewTaken).


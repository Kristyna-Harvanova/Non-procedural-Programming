

% spusteni
% swipl
% ['cviceni1.pl'].



muz(jirka).
muz(pavel).
muz(adam).

zena(marie).
zena(adela).
zena(jitka).

rodic(jirka, marie).
rodic(jirka, adam).
rodic(jitka, marie).
rodic(pavel, jirka).




% ?- rodic(jirka, marie).
% ?- true ;
% ?- false.

% ?- rodic(X,adam).
% jirka.

% ?- rodic(X, marie).
% X = jirka ;
% X = jitka.

%%%%%%% konjunkce ",":

% ?- rodic(X, marie), muz(X).
% X = jirka ;
% false.


%%%%%%% implikace ":-": 
% ale zprava doleva

tata(X, Y) :- rodic(X, Y), muz(X).

manzele(jirka, jitka).
% ?- manzele(X, jitka).
% X = jirka.
% ?- manzele(X, jirka).
% false.


manzeleSym(X, Y) :- manzele(X, Y).
manzeleSym(X, Y) :- manzele(Y, X).



bratr(Kdo, Koho) :- 
    rodic(R, Kdo), 
    rodic(R, Koho), 
    muz(Kdo), 
    Kdo \= Koho.

% pomoci logicke formule: 
% pro V Kdo, Koho (E R: rodic(R, Kdo) & rodic(R, Koho) & muz(Kdo) & -(Kdo = Koho)) => bratr(Kdo, Koho)


sestra(Kdo, Koho) :- 
    rodic(R, Kdo), 
    rodic(R, Koho), 
    zena(Kdo), 
    Kdo \= Koho.

vnuk(Vnuk, DedaBabi) :- 
    rodic(Rodic, Vnuk), 
    rodic(DedaBabi, Rodic), 
    muz(Vnuk).

vnucka(Vnucka, DedaBabi) :- 
    rodic(Rodic, Vnucka), 
    rodic(DedaBabi, Rodic), 
    zena(Vnucka).


% Oženil jsem se s jednou vdovou, která již měla dospělou dceru.
% Můj otec, který nás často navštěvoval, se do mé nevlastní dcery
% zamiloval a vzal si ji za ženu. Tak se můj otec stal mým zeťem a
% moje nevlastní dcera mojí nevlastní matkou. Za několik měsíců
% porodila má žena syna, který se stal švagrem mého otce a současně
% mým strýcem. Manželce mého otce se také narodil syn, který se tak
% stal mým bratrem a současně vnukem.
%
% Vytvořte v Prologu databázi, která reprezentuje fakta v této hádance.
% Poté definujte predikáty pro rodinné vztahy (švagr, bratr, vnuk, atp)
% a ověřte, že skutečně platí.
%
% Nakonec definuje predikát "dědeček" a použijte ho na zodpovězení
% následující otázky:
%
% Jsem svým vlastním dědečkem?

muz(ja).
vdova(vdova).
rodic(vdova, dcera).

% reseni z Discordu:

zena(vdova).
zena(dcera).

muz(ja).
muz(otec).
muz(syn).
muz(otcuvSyn).

bioRodic(vdova, dcera).
bioRodic(otec, ja).
bioRodic(vdova, syn).
bioRodic(ja, syn).
bioRodic(otec, otcuvSyn).
bioRodic(dcera, otcuvSyn).

manzele(ja, vdova).
manzele(otec, dcera).

manzeleSym(X, Y) :- manzele(X, Y); manzele(Y, X).

rodic(X, Y) :- bioRodic(X, Y).
rodic(X, Y) :- manzeleSym(X, Z), bioRodic(Z, Y).

sourozenec(X, Y) :- bioRodic(Z, X), bioRodic(Z, Y), X \= Y.

zet(X, Y) :- muz(X), manzeleSym(X, Z), rodic(Y, Z).

matka(X, Y) :- zena(X), rodic(X, Y).

svagr(X, Y) :- muz(X), sourozenec(X, Z), manzeleSym(Z, Y).
svagr(X, Y) :- muz(X), manzeleSym(X, Z), sourozenec(Z, Y).

stryc(X, Y) :- muz(X), sourozenec(X, Z), rodic(Z, Y).
stryc(X, Y) :- muz(X), manzeleSym(X, Z), sourozenec(Z, ZZ), rodic(ZZ, Y).

bratr(X, Y) :- muz(X), sourozenec(X, Y).

vnuk(X, Y) :- muz(X), rodic(Z, X), rodic(Y, Z).

deda(X, Y) :- muz(X), rodic(X, Z), rodic(Z, Y).

% zet(otec, ja).
% matka(dcera, ja).
% svagr(syn, otec).
% stryc(syn, ja).
% bratr(otcuvSyn, ja).
% vnuk(otcuvSyn, ja).

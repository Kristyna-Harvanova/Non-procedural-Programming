% Na vstupu je zadán seznam záznamů, přičemž jeden záznam je reprezentován seznamem dvojic atribut-hodnota. Můžete si představit, že vstup reprezentuje tabulku relační databáze, záznamy odpovídají jejím řádkům a atributy jsou jména sloupců. Hodnoty některých atributů mohou být v některých řádcích nedefinovány, pak se příslušná dvojice atribut-hodnota v příslušném seznamu vůbec nevyskytuje.

% Cílem tohoto problému je definovat predikát extrakce/2, který obdrží popsaný vstup a na výstupu vrátí asociativní seznam dvojic atribut-seznam_vsech_ruznych_hodnot takový, že

% každý atribut ze vstupní tabulky bude ve výstupním seznamu právě jednou,
% každá hodnota atributu ze vstupní tabulky bude ve výstupním seznamu u příslušného atributu právě jednou,
% je-li v nějakém záznamu hodnota některého atributu nedefinována, na výstupu bude u příslušného atributu hodnota nedef, a to právě jednou,
% seznam bude setříděn dle standardního pořadí termů (viz přednáška Prolog 3, str. 25).
% Příklad:

% ?- extrakce([[barva-oranzova, motor-plyn, pocet_mist-40], 
%             [barva-modra, motor-diesel, pocet_kol-6],
%             [motor-elektro, pocet_mist-5] ], Atributy).
% extrakce([[barva-oranzova, motor-plyn, pocet_mist-40], [barva-modra, motor-diesel, pocet_kol-6], [motor-elektro, pocet_mist-5] ], Atributy).
% Atributy = [barva-[modra, nedef, oranzova], 
%             motor-[diesel, elektro, plyn], 
%             pocet_kol-[6, nedef], 
%             pocet_mist-[5, 40, nedef]].
% Příklad 2:

% ?- extrakce([
%    [hra-the_last_of_us, rok-2013, platforma-ps3, metacritic-9.2],
%    [hra-the_last_of_us, rok-2023, platforma-pc, metacritic-1.8], 
%    [hra-witcher3, rok-2015, platforma-pc, metacritic-9.1], 
%    [hra-witcher3, rok-2022, platforma-ps5, metacritic-7.9]
%             ], Atributy).
% Atributy = [hra-[the_last_of_us, witcher3], 
%             metacritic-[1.8, 7.9, 9.1, 9.2], 
%             platforma-[pc, ps3, ps5], 
%             rok-[2013, 2015, 2022, 2023]].
% Nápověda: Zjednodušenou verzi úlohy (bez nedef) jsme vyřešili na cvičení #7, což můžete samozřejmě využít jako inspiraci. Pozor na to, že hodnoty atributů se mohou opakovat, viz Příklad 2 výše. Můžete samozřejmě využít probrané knihovní predikáty (např. sort/2 či msort/2).

getAttr(X-_, X).

getAttrLine(Attr, DBLine, Val) :- member(Attr-Val, DBLine) -> true; Val = nedef.    % pokud atribut v radku existuje, vratim jeho hodnotu. pokud neexistuje, vratim nedef

getAttrAll(DB, Attr, Attr-Vals) :- maplist(getAttrLine(Attr), DB, ValsDup), sort(ValsDup, Vals).

extrakce(Database, Result) :-
    append(Database, Flat),
    maplist(getAttr, Flat, AttrsDup),
    sort(AttrsDup, Attrs),
    maplist(getAttrAll(Database), Attrs, Result).



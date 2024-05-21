-- V této úloze budeme pracovat se stromy. Nepůjde ale o kořenové stromy, nýbrž o neorientované souvislé acyklické grafy, reprezentované seznamy svých hran.

-- Naším cílem je sestavit funkci vrstvy, která rozdělí strom S na vrstvy počínaje od listů. V první vrstvě jsou tedy listy stromu S. Jejich odstraněním obdržíme nový strom S', jehož listy představují druhou vrstvu. Další vrstvy obbdržíme analogicky.

-- Příklad:

-- > vrstvy [(1,2),(1,3),(1,4),(1,5)]
-- [[2,3,4,5],[1]]
-- Příklad 2:

-- > vrstvy [('a','c'),('b','c'),('c','d'),('c','e'),('d','f'),('f','g'),('f','h'),('h','i')]
-- ["abegi","ch","df"]
-- Instrukce:

-- 1. Strom je zadán seznamem svých hran, přičemž hrana mezi vrcholy u a v je reprezentována právě jednou z dvojic (u,v) či (v,u). Strom o jediném vrcholu takto reprezentovat nelze, ale to není příliš zajímavý případ, který tedy lehce oželíme.

-- 2. Vrcholy stromu mohou být hodnoty libovolného typu, který je instancí typové třídy Ord, tedy čísla, znaky, řetězce ...

-- 3. Funkce na výstupu vrací seznam seznamů, které představují vrstvy, seřazené od poslední (tvořené listy) po první, viz výše.

-- 4. Vrcholy by měly být v každé vrstvě seřazeny vzestupně (protože jde o instanci třídy Ord, řazení je vždy možné).

-- 5. Ve vašem řešení můžete používat knihovní funkce z naší referenční příručky na Moodle.

-- Návod: Zvažte, zdali by nebylo užitečné, na začátku převést seznam hran na jinou reprezentaci, vhodnější pro řešení naší úlohy.

import Data.List

type Graph a = [(a, [a])]

neighbors :: (Ord a) => [(a, a)] -> Graph a
neighbors g = map (\x -> (fst $ head x, map snd x)) $ groupBy (\a b -> fst a == fst b) $
    sort $ concatMap (\(x, y) -> [(x, y), (y, x)]) g

layer :: (Ord a) => Graph a -> ([a], Graph a)
layer g = (leaves, map (\(v, n) -> (v, n \\ leaves)) inner)
    where 
        leaves = map fst outer
        (outer, inner) = partition (\(v, e) -> length e <= 1) g

vrstvy :: (Ord a) => Graph a -> [[a]]
vrstvy [] = []
vrstvy g = let (l, g') = layer g in l:vrstvy g'

-- spousteni
-- vrstvy  (neighbors [('a','c'),('b','c'),('c','d'),('c','e'),('d','f'),('f','g'),('f','h'),('h','i')])
-- ["abegi","ch","df"]
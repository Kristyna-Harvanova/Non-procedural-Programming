-- Haskell (10 bodů): Vodní zdroje

-- Na čtverečkové mapě jsou zadány vodní zdroje svými souřadnicemi, což jsou dvojice přirozených čísel. 
-- Na pozici (0, 0) je umístěn vodojem. Pro každý zdroj (či vodojem) jsou zadány sousední zdroje (či vodojem), 
-- s nimiž je možné propojení. Naším cílem je propojit vodní zdroje tak, aby každý zdroj byl spojen s nějakým dalším zdrojem nebo s vodojemem.
-- Propojení ze zdroje X musí jít na vodojem nebo na zdroj Y, který je v obou souřadnicích neostře menší.
-- V obecnosti, pokud je víc možností propojení na zdroj Y, můžete si vybrat libovolný takový, že mezi X a Y neleží jiný vhodný zdroj.

-- Pokud úlohu přeformulujeme jako grafový problém (vrcholy jsou zdroje a vodojem, hrany možná propojení mezi nimi), 
-- tak výsledné propojení představuje kostru vstupního grafu.

-- Mapu zdrojů lze reprezentovat seznamem dvojic, kde:
-- - první složka představuje souřadnice zdroje (či vodojemu)
-- - druhé složka seznam sousedních zdrojů (či vodojemu)

import Data.List
import Data.Ord

type Mapa = [((Int,Int), [(Int,Int)])]
-- type Mapa a = [((a, a), [(a, a)])]

map1 :: Mapa
-- map1 :: Mapa Int
map1 = [
    ((0, 0), [(2, 1), (3, 3)]),
    ((1, 3), [(2, 1), (0, 0), (0, 2)]),
    ((2, 1), [(3, 2), (0, 0)]),
    ((2, 0), [(0, 0)]),
    ((3, 2), [(3, 3), (2, 1), (1, 3)]),
    ((3, 3), [(3, 2), (1, 3)])
    ]
-- [((3,3),(3,2)),((3,2),(2,1)),((2,0),(0,0)),((2,1),(0,0)),((1,3),(0,2))]

map2 :: Mapa
-- map2 :: Mapa Int
map2 = [
    ((0, 0), [(2, 1), (3, 3)]),
    ((1, 3), [(2, 1), (0, 0)]),     -- tady je rozdil, pujde videt v posledni polozce vysledku
    ((2, 1), [(3, 2), (0, 0)]),
    ((2, 0), [(0, 0)]),
    ((3, 2), [(3, 3), (2, 1), (1, 3)]),
    ((3, 3), [(3, 2), (1, 3)])
    ]
-- [((3,3),(3,2)),((3,2),(2,1)),((2,0),(0,0)),((2,1),(0,0)),((1,3),(0,0))]

-- (a) Sestavte funkci zdroje :: Mapa -> [((Int,Int), (Int,Int))], která vytvoří propojení zdrojů.

-- najde nejblizsi mensi vrchol, do ktereho povedeme hranu
findEdge :: (Int, Int) -> [(Int, Int)] -> ((Int, Int), (Int, Int))
-- findEdge :: (Ord a) => (a, a) -> [(a, a)] -> ((a, a), (a, a))
findEdge (x, y) neighbours = 
    let suitable = filter (\(first, second) -> first <= x && second <= y) neighbours
        inOrder = sortBy (flip compare) suitable
        chosen = head inOrder
    in ((x, y), chosen)

zdrojeHelp :: Mapa -> [((Int,Int), (Int,Int))] -> [((Int,Int), (Int,Int))] 
-- zdrojeHelp :: (Ord a) => Mapa a -> [((a,a), (a,a))] -> [((a,a), (a,a))] 
zdrojeHelp [] founded = founded
zdrojeHelp ((vertex, neighbours):map) founded
    | vertex == (0, 0) = zdrojeHelp map founded    -- (0,0) neboli vodojem nema zadneho validniho souseda, tedy nepridame edge
    | length map == 0 =                         -- pokud jsme u konce, pridame posledni vhodnou hranu a uz nerekurzime
        let edge = findEdge vertex neighbours
        in (edge:founded)
    | otherwise =                               -- jinak hledame hranu pro aktualni zdroj a rekurzivne volame na dalsi
        let edge = findEdge vertex neighbours
        in zdrojeHelp map (edge:founded)

zdroje :: Mapa -> [((Int,Int), (Int,Int))]   
-- zdroje :: (Ord a) => Mapa a -> [((a,a), (a,a))]   
zdroje map = zdrojeHelp map []


-- (b) Zobecněte typ Mapa tak, aby mapa mohla být indexována i jinými typy než Int.

-- (c) Jak se změní typová signatura funkce zdroje pro takto zobecněný typ Mapa z (b)? 
-- Uveďte včetně vhodných typových omezení pomocí typových tříd.

-- (d) Jak se změní typ funkce zdroje, pokud bude porovnávací funkce na první souřadnici předávána 
-- jako funkcionální parametr? Tedy funkce zdroje se změní na funkci vyššího řádu.

-- Takto:
-- zdroje :: (Ord a) => Mapa a -> (a -> a -> Bool) -> [((a,a), (a,a))]











-- concatMap (\x -> [(x,x+2,x/2)]) [1,3,5]
-- [(1.0,3.0,0.5),(3.0,5.0,1.5),(5.0,7.0,2.5)]
-- concatMap (\x -> [x+2]) [1,3,5]
-- [3,5,7]

----------------------------------------------------------------------------------------------

-- -- type Mapa = [((Int, Int), [(Int, Int)])]
-- -- B)
-- type Mapa a = [((a, a), [(a, a)])]
-- -- C) a needs to be Ord bcs of comparison
-- zdroje :: Ord a => Mapa a -> [((a, a), (a, a))]
-- zdroje mapa = sorted
--     where
--         filtered = map (\((locX, locY), connected) -> ((locX, locY), filter (\(conX, conY) -> conX <= locX && conY <= locY)  connected)) mapa
--         sorted = map (\(loc, connected) -> (loc, minimumBy (\a b -> compare b a) connected)) filtered

-- -- D) added function for X comparison
-- zdroje' :: Ord a => Mapa a -> (a -> a -> Bool) -> [((a, a), (a, a))]
-- zdroje' mapa f = sorted
--     where
--         filtered = map (\((locX, locY), connected) -> ((locX, locY), filter (\(conX, conY) -> f locX conX && conY <= locY)  connected)) mapa
--         sorted = map (\(loc, connected) -> (loc, minimumBy (\a b -> compare b a) connected)) filtered

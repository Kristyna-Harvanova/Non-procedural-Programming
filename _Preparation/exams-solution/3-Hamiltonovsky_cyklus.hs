-- 2. Haskell (10 bodů): Hamiltonovský cyklus v orientovaném grafu

-- V této úloze budeme pracovat se orientovanými grafy, jejichž vrcholy jsou reprezentovány navzájem různými celými čísly:
-- type Graf = [(Int, [Int])]

-- Graf g na obrázku bude tedy reprezentován následovně:
-- g :: Graf
-- g = [(1, [3,6]), (2, [6]), (3, [2,5]), (4, [1,3]), (5, [2,4]), (6, [3,4,5])]

-- Hamiltonovský cyklus v grafu je cyklus, který navštíví každý vrchol grafu právě jednou. 
-- Kupříkladu graf na obrázku výše obsahuje takový cyklus:
-- 1 -> 3 -> 5 -> 2 -> 6 -> 4 -> 1

-- Cílem našeho problému je definovat funkci:
-- hc :: Graf -> Maybe [Int]
-- která
-- - obdrží orientovaný graf,
-- - zjistí, zdali obsahuje Hamiltonovský cyklus,
-- - pokud ano, jeden takový cyklus vrátí jako seznam vrcholů opatřený konstruktorem Just,
-- - pokud ne, vrátí hodnotu Nothing.

-- Pokud graf obsahuje více Hamiltonovských cyklů, stačí vrátit libovolný z nich.
-- > hc g
-- Just [1,3,5,2,6,4]

-- > hc [(1,[2]), (2,[3]), (3,[4]), (4,[5]), (5,[2])]
-- Nothing

-- Důležité: Jde o NP-těžký problém, takže se očekává, že vaše funkce bude - měřeno nejhorším případem - 
-- pracovat v exponenciálním čase. Pokud je ovšem vstupní graf tvořen jen cyklem 
-- (např. 7 vrcholů a hrany 7 -> 2 -> 1 -> 3 -> 5 -> 6 -> 4 -> 7), vaše funkce by měla pracovat 
-- v polynomiálním čase. Triviální řešení projít všechny permutace množiny vrcholů tedy nestačí 
-- (mohlo by vést k exponenciální složitosti i v případě jednoduchého cyklu).

-- (a) Sestavte definici funkce hc.

-- (b) Zobecněte definici typového synonyma Graf tak, aby vrcholy grafu mohly být reprezentovány i jinak 
-- než jen celými čísly (třeba znaky, řetězci, desetinnými čísly apod.).

-- (c) Zobecněte typovou signaturu funkce hc tak, aby vrcholy grafu mohly být reprezentovány i jinak 
-- než jen celými čísly (přitom můžete využít (b)). Je-li to třeba, použijte typové omezení 
-- na vhodné typové třídy. Půjde s takto změněnou typovou signaturou použít váš původní kód, 
-- nebo budou potřebné nějaké změny? Odpověď prosím zdůvodněte.

-- type Graf = [ (Int, [Int]) ]

-- g1 :: Graf 
g1 :: Graf Int
g1 = [
    (1, [3, 6]),
    (2, [6]),
    (3, [2, 5]),
    (4, [1, 3]),
    (5, [2, 4]),
    (6, [3, 4, 5])
    ]
-- Just [1,3,2,6,5,4,1]

-- g2 :: Graf 
g2 :: Graf Int
g2 = [
    (1, [2]),
    (2, [3]),
    (3, [4]),
    (4, [5]),
    (5, [6]),
    (6, [1])
    ]
-- Just [1,2,3,4,5,6,1]

-- g3 :: Graf
g3 :: Graf Int
g3 = [
    (1, [2]),
    (2, [3]),
    (3, [4]),
    (4, [5]),
    (5, [1]),
    (6, [1])
    ]
-- Nothing

-- pomocna funkce k aktualizaci sousedu v grafu
-- replaceNeighbours :: Graf -> Int -> [Int] -> Graf
replaceNeighbours :: (Eq a) => Graf a -> a -> [a] -> Graf a
replaceNeighbours ((v, ns):graf) vertex newNeighbours 
    | v == vertex = ((v, newNeighbours):graf)   -- pokud jsme nasli vrchol, jehoz sousedy chceme nahradit, vratime aktualizovany
    | otherwise = (v, ns):(replaceNeighbours graf vertex newNeighbours) -- vratime seznam zkontrolovaneho neaktualizovaneho vrcholu a rekurzivni volani funkce na zbytku

-- pomocna rekurzivni funkce pro hc
-- hcHelp :: Graf -> [Int] -> Maybe [Int]
hcHelp :: (Eq a) => Graf a -> [a] -> Maybe [a]
hcHelp graf cycle
    | length cycle >= length graf =
        if (elem (head cycle) (snd (head (filter (\(x, _) -> x == last cycle) graf))))  -- kontrola, jestli posledni prvek cyklu ma za souseda prvni prvek cyklu
            then Just (cycle ++ [head cycle])                                           -- pridame prvni prvek na konec, aby byl cyklus (nebo muzeme vratit jen cycle samotne)
        else Nothing                                                                    -- nejde o Hamiltonovsky cyklus, protoze posledni prvek nenavazuje na prvni
    | length cycle == 0 = hcHelp graf [fst (head graf)]                                 -- pridani prvniho prvku do mozneho cyklu
    | otherwise =                               
        let (lastVertex, (neighbours)) = head (filter (\(x, _) -> x == last cycle) graf)   -- vybereme posledni pridany vrchol a jeho souseda, ktereho chceme pridat do cyklu
            tryNext [] = Nothing                                                        -- pokud uz nejsou zadni sousede k dospozici, backtracking
            tryNext (n1:ns) 
                | elem n1 cycle = tryNext ns    -- pokud uz soused v cyklu je, zkousime s dalsim sousedem
                | otherwise = 
                    let newGraph2 = replaceNeighbours graf lastVertex (filter (/= n1) neighbours)   -- aktualizujeme sousedy
                    in case hcHelp newGraph2 (cycle ++ [n1]) of
                        Nothing -> tryNext ns   -- zkousime jineho souseda, pokud tato cesta nefungovala
                        solution -> solution
        in tryNext neighbours

-- a)
-- hc :: Graf -> Maybe [Int]
-- hc graf = hcHelp graf []

-- b)
type Graf a = [ (a, [a]) ]

-- c)
hc :: (Eq a) => Graf a -> Maybe [a]
hc graf = hcHelp graf []

-- Je treba omezit na Eq, protoze pouzivame Minimální definice:  (==) nebo (/=).
-- v samotnem kodu zmeny potrebne nejsou, je vsak treba zmenit typovou signaturu i u vsech dalsich nadefinovanych 
-- pomocnuch funkci.






----------------------------------------------------------------------------------


-- import Data.List (partition) 
-- import Data.Maybe

-- -- type Graf = [(Int, [Int])]
-- -- B), C) Eq is needed for == ('elem')
-- type Graf a = [(a, [a])]

-- g :: Graf Int
-- g = [(1, [3,6]), (2, [6]), (3, [2,5]), (4, [1,3]), (5, [2,4]), (6, [3,4,5])]

-- g2 :: Graf Int
-- g2 = [(1, [2]), (2, [3]), (3, [4]), (4, [5]), (5, [2])]

-- hc :: Eq a => Graf a -> Maybe [a]
-- hc g
--     | null solutions = Nothing
--     | otherwise = Just $ head solutions ++ [v]
--     where
--         solutions = allHc g ends v
--         (v, _) = head g
--         ends = map fst (filter ((v `elem`) . snd) g)

-- allHc :: Eq a => Graf a -> [a] -> a -> [[a]]
-- allHc [] _ _ = []
-- allHc [(i, _)] possibleEnds _
--     | i `elem` possibleEnds = [[i]]
--     | otherwise = []
-- allHc g possibleEnds from
--     | isNothing edges = []
--     | null solutions = []
--     | otherwise = updatedSolutions
--         where
--             edges = lookup from g
--             jEdges = fromJust edges
--             newG = graphWithoutVertex g from
--             solutions = map (allHc newG possibleEnds) jEdges
--             updatedSolutions = concatMap (map (from:)) solutions

-- graphWithoutVertex :: Eq a => Graf a -> a -> Graf a
-- graphWithoutVertex g v = noEdges
--     where
--         noV = filter ((/= v) . fst) g
--         noEdges = map (\(vertex, edges) -> (vertex, filter (/= v) edges)) noV


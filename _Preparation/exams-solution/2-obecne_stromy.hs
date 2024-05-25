
-- Cílem tohoto problému je zobecnit několik populárních funkcí vyššího řádu, které jsou definovány nad seznamy, na obecné kořenové stromy.

-- tree = Node 1 [Node 2 [Nil], Node 3 [Nil, Node 4 [Nil]]]

-- (a) Definujte datový typ (pomocí data) pro reprezentaci obecných kořenových stromů s ohodnocenými vrcholy:
-- Snažte se o co nejobecnější definici.
-- Nezapomeňte na reprezentaci prázdného stromu.

data Tree a = Nil | Node a [Tree a]
    deriving (Show)


-- (b) Funkce foldl a foldr zobecněte na funkci fold, která
-- bude - namísto seznamu - procházet stromem ve vaší reprezentaci popsané v (a).

-- A value of type a (the node's value).
-- A list of values of type b (results of folding the children).
-- It returns a value of type b (the result of combining the node and its children's results).
fold :: (a -> [b] -> b) -> b -> (Tree a) -> b
fold _ acc Nil = acc
fold f acc (Node val children) = f val (map (fold f acc) children)


-- (c) Pomocí funkce fold definujte funkci arita, která vrátí aritu
-- (tj. maximální počet dětí přes všechny vrcholy) zadaného kořenového stromu.

arita :: (Tree a) -> Int
arita tree = fold (\_ childrenArity -> max (length childrenArity) (maximum childrenArity)) 0 tree


-- (d) Zobecněte funkci map na funkci mapStrom, která:
-- Obdrží binární funkci f a obecný kořenový strom.
-- Aplikuje f na prvky stromu, aniž by přitom měnila jeho strukturu.
-- A výsledný strom vrátí.

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ Nil = Nil
mapTree f (Node val children) = Node (f val) (map (mapTree f) children)


-- (e) Zobecněte funkci take na funkci takeStrom, která:
-- Obdrží obecný kořenový strom a přirozené číslo h.
-- Odstraní ve stromě všechny vrcholy ve hloubce větší než h
-- (hloubka vrcholu v je počet hran na cestě z kořene do v).
-- A výsledný strom (hloubky nejvýše h) vrátí.

takeTree :: Tree a -> Int -> Tree a
takeTree tree h = depth h 0 tree
    where
        depth _ _ Nil = Nil
        depth maxDepth currentDepth (Node val children)
            | maxDepth == currentDepth = (Node val [Nil])
            | otherwise = Node val (map (depth maxDepth (currentDepth + 1)) children)


-- (f) Využijte váš datový typ k definici nekonečného stromu takového,
-- že pro každé přirozené číslo h existuje vrchol ve hloubce alespoň h.

infiniteTree :: a -> Tree a
infiniteTree val = Node val [infiniteTree val]


-- (g) Co když na nekonečný strom z části (f) aplikujeme nejprve funkci mapTree 
-- a poté funkci takeTree (s vhodnými parametry)? Bude to fungovat? Odpověď zdůvodněte.

-- Řešení:
-- Pokud nejprve aplikujeme mapTree a poté takeTree na nekonečný strom, mapTree projde stromem a aplikuje funkci na každý uzel. 
-- Vzhledem k tomu, že strom je nekonečný, průchod by nikdy neskončil, pokud bychom ho nějak neomezili. 
-- Po aplikaci takeTree bychom dostali konečný strom s hloubkou h, kde každý uzel byl transformován funkcí mapTree. 
-- To funguje správně, protože takeTree omezuje hloubku a zajišťuje, že strom je konečný.





----------------------------------------------------------------------------------

-- import Data.List


-- data Tree a = Nil | Vertex a [Tree a]
--     deriving Show

-- fold :: (a -> [b] -> b) -> b -> Tree a -> b
-- fold _ b Nil = b
-- -- fold f b (Vertex a (c:children)) = f a (fold f b c)
-- fold f b (Vertex a children) = f a (map (fold f b) children)

-- mapTree :: (a -> b) -> Tree a -> Tree b
-- mapTree _ Nil = Nil
-- mapTree f (Vertex val children) = Vertex (f val) (map (mapTree f) children)

-- arita :: Tree a -> Int
-- arita = fold (\_ childrenArity -> max (length childrenArity) (maximum childrenArity)) 0

-- takeTree :: Tree a -> Int -> Tree a
-- takeTree Nil _ = Nil
-- takeTree (Vertex a children) h
--     | h == 0 = Vertex a [Nil]
--     | h > 0 = Vertex a (map (\c -> takeTree c (h-1)) children)
--     | otherwise = Nil

-- infTree :: Tree Int
-- infTree =
--     Vertex 1 [infTree]


-- t :: Tree Int
-- t =
--     Vertex 5 [
--         Vertex 1 [
--             Vertex 2 [Nil],
--             Vertex 3 [
--                 Vertex 4 [Nil]
--             ]
--         ],
--         Vertex 6 [Nil],
--         Vertex 7 [Nil],
--         Vertex 8 [Nil],
--         Vertex 9 [Nil],
--         Vertex 10 [
--             Vertex 11 [
--                 Vertex 12 [Nil],
--                 Vertex 13 [Nil]
--             ],
--             Vertex 14 [Nil]
--         ]
--     ]





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
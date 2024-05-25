
-- Cílem tohoto problému je zobecnit několik populárních funkcí vyššího řádu, které jsou definovány nad seznamy, na obecné kořenové stromy.

-- (a) Definujte datový typ (pomocí data) pro reprezentaci obecných kořenových stromů s ohodnocenými vrcholy:
-- Snažte se o co nejobecnější definici.
-- Nezapomeňte na reprezentaci prázdného stromu.

data Tree a = Nil | Node a [Tree a]
    deriving (Show)


-- (b) Funkce foldl a foldr zobecněte na funkci fold, která
-- bude - namísto seznamu - procházet stromem ve vaší reprezentaci popsané v (a).

fold :: (b -> a -> b) -> b -> (Tree a) -> b
fold _ a Nil = a    -- prazdny strom = Nil
fold f a (Node val children) = foldl (fold f) (f a val) children


















----------------------------------------------------------------------------------

import Data.List


data Tree a = Nil | Vertex a [Tree a]
    deriving Show

fold :: (a -> [b] -> b) -> b -> Tree a -> b
fold _ b Nil = b
-- fold f b (Vertex a (c:children)) = f a (fold f b c)
fold f b (Vertex a children) = f a (map (fold f b) children)

mapTree :: (a -> b) -> Tree a -> Tree b
mapTree _ Nil = Nil
mapTree f (Vertex val children) = Vertex (f val) (map (mapTree f) children)

arita :: Tree a -> Int
arita = fold (\_ childrenArity -> max (length childrenArity) (maximum childrenArity)) 0

takeTree :: Tree a -> Int -> Tree a
takeTree Nil _ = Nil
takeTree (Vertex a children) h
    | h == 0 = Vertex a [Nil]
    | h > 0 = Vertex a (map (\c -> takeTree c (h-1)) children)
    | otherwise = Nil

infTree :: Tree Int
infTree =
    Vertex 1 [infTree]


t :: Tree Int
t =
    Vertex 5 [
        Vertex 1 [
            Vertex 2 [Nil],
            Vertex 3 [
                Vertex 4 [Nil]
            ]
        ],
        Vertex 6 [Nil],
        Vertex 7 [Nil],
        Vertex 8 [Nil],
        Vertex 9 [Nil],
        Vertex 10 [
            Vertex 11 [
                Vertex 12 [Nil],
                Vertex 13 [Nil]
            ],
            Vertex 14 [Nil]
        ]
    ]





-- type Mapa = [((Int, Int), [(Int, Int)])]
-- B)
type Mapa a = [((a, a), [(a, a)])]
-- C) a needs to be Ord bcs of comparison
zdroje :: Ord a => Mapa a -> [((a, a), (a, a))]
zdroje mapa = sorted
    where
        filtered = map (\((locX, locY), connected) -> ((locX, locY), filter (\(conX, conY) -> conX <= locX && conY <= locY)  connected)) mapa
        sorted = map (\(loc, connected) -> (loc, minimumBy (\a b -> compare b a) connected)) filtered

-- D) added function for X comparison
zdroje' :: Ord a => Mapa a -> (a -> a -> Bool) -> [((a, a), (a, a))]
zdroje' mapa f = sorted
    where
        filtered = map (\((locX, locY), connected) -> ((locX, locY), filter (\(conX, conY) -> f locX conX && conY <= locY)  connected)) mapa
        sorted = map (\(loc, connected) -> (loc, minimumBy (\a b -> compare b a) connected)) filtered
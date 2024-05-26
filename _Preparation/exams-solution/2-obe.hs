-- 10:32 - 11:05

data Tree a = Nil | Node a [Tree a] -- je na uživateli, jestli mu dává smysl jako potomky mít i prázdné stromy; my je povolíme
  deriving (Show)

fold :: (t -> [b] -> b) -> b -> Tree t -> b
fold fNode fNil = go
  where
    go Nil = fNil
    go (Node v children) = fNode v (map go children)

arita :: Tree t -> Int
arita = fold (\_ children -> case length children of
                               0 -> 0
                               n -> maximum (n:children)) 0

mapTree :: (t -> a) -> Tree t -> Tree a
mapTree f Nil = Nil
mapTree f (Node v children) = Node (f v) (map (mapTree f) children)

takeTree :: Tree a -> Int -> Tree a
takeTree Nil _ = Nil
takeTree (Node v _) 0 = Node v [] -- hloubka 0 => pouze kořen
takeTree (Node v children) h = Node v (map (\t -> takeTree t (h-1)) children)

-- 0-1-2-3-...
infTree :: Tree Integer
infTree = gen 0
  where
    gen n = Node n [gen (n+1)]

-- >>> takeTree (mapTree (*10) infTree) 4
-- Node 0 [Node 10 [Node 20 [Node 30 [Node 40 []]]]]
-- (je to lazy generované)
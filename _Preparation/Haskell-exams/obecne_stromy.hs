data Tree a = Nill | Node a [Tree a]
    deriving(Show)


fold :: (a -> [b] -> b) -> b -> Tree a -> b
fold f b Nill = b
fold f b (Node a children) = f a (map (fold f b) children)

arita :: Tree a -> Int
arita = fold (\_ bs -> max (max_ bs) (length bs)) 0
    where
        max_ [] = 0
        max_ [x] = x
        max_ (x:xs) = max x (max_ xs)

mapTree :: (t -> a) -> Tree t -> Tree a
mapTree f Nill = Nill
mapTree f (Node a children) = Node (f a) (map (mapTree f) children)   

takeTree :: Int -> Tree a -> Tree a
takeTree = take2 0
    where 
        take2 (-1) _  _ = Nill
        take2 _ _ Nill = Nill
        take2 h hmax (Node a children)
            | hmax > h = Node a (map (take2 (h+1) hmax) children)
            | hmax == h = Node a []

testTree :: Tree Integer
testTree = Node 1 [Node 2 [Node 3 [], Node 4 [], Node 5 [],  Node 5 []], Node 6 [Node 7 []]]

infiniteTree :: a -> Tree a
infiniteTree a = Node a [infiniteTree a]
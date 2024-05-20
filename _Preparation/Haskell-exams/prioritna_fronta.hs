class (Functor q) => PQueue q where
    empty :: q a
    insert :: (a, Int) -> q a -> q a
    remove :: q a -> ((a, Int), q a)
    merge :: q a -> q a -> q a


data FQueue a = FQueue [(a, Int)]


instance PQueue FQueue where 
    empty :: FQueue a
    empty = FQueue []

    insert :: (a, Int) -> FQueue a -> FQueue a
    insert (a, n) (FQueue []) = FQueue [(a,n)]
    insert x (FQueue xs) = FQueue (insert_ x xs)
        where 
            insert_ (a, n) q@((b, m):xs)
                | n > m = (b, m):(insert_ (a, n) xs)
                | otherwise = (a, n):q 

    remove :: FQueue a -> ((a, Int), FQueue a)
    remove (FQueue (x:xs)) = (x, FQueue xs)

    merge :: FQueue a -> FQueue a -> FQueue a
    merge (FQueue xs) (FQueue ys) = FQueue (merge_ xs ys)
        where 
            merge_ [] [] = []
            merge_ [] ys = ys
            merge_ xs [] = xs
            merge_ (x@(xa,xn):xs) (y@(ya,yn):ys)
                | xn < yn = x:(merge_ xs (y:ys))
                | otherwise = y:(merge_ (x:xs) ys)


instance Functor FQueue where
    fmap :: (a -> b) -> FQueue a -> FQueue b
    fmap f (FQueue xs) = FQueue (map (\(a, n) -> ((f a), n)) xs)


instance Foldable FQueue where 
    foldr :: (a -> b -> b) -> b -> FQueue a -> b
    foldr f z (FQueue xs) = foldr_ f z xs
        where
            foldr_ f z [] = z
            foldr_ f z ((a,_):xs) = f a (foldr_ f z xs)

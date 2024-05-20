data FPole a = Node (Int, a) (FPole a) (FPole a) | Nill
    deriving (Show)

class Foldable m => Pole m where
    make :: [t] -> m t
    get :: m t -> Int -> t
    update :: m t -> Int -> t -> m t


instance Pole FPole where
    make ts = make_ $ indexes ts
        where 
            indexes ts = zip [0..] ts
            make_ [] = Nill
            make_ [x] = Node x Nill Nill
            make_ xs = Node (xs !! n) (make_ (take n xs)) (make_ (drop (n+1) xs)) 
                where
                    n = (length xs) `div` 2

    get (Node (i, x) l r) n 
        | n == i = x
        | n < i = get l n
        | n > i = get r n
    update (Node (i, x) l r) n y 
        | n == i = Node (i, y) l r
        | n < i = Node (i, x) (update l n y) r
        | n > i = Node (i, x) l (update r n y)

instance Foldable FPole where
    foldr :: (a -> b -> b) -> b -> FPole a -> b
    foldr f z Nill = z
    foldr f z (Node (_, x) l r) = foldr f (f x (foldr f z l)) r

instance Functor FPole where
    fmap f Nill = Nill
    fmap f (Node (i, x) l r) = Node (i, f x) (fmap f l) (fmap f r)   

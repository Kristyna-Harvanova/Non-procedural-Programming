
class Foldable m => Pole m where
    make :: [t] -> m t
    get :: m t -> Int -> t
    update :: m t -> Int -> t -> m t

-- a)
data FPole t = Empty | Node Int t (FPole t) (FPole t)
    deriving (Show)

-- b)
instance Pole FPole where
    make xs = makeFPole 0 (length xs - 1) xs
        where
            makeFPole lo hi vals
                | lo > hi = Empty
                | otherwise =
                    let mid = div (lo + hi) 2           
                        left = makeFPole lo (mid - 1) vals
                        right = makeFPole (mid + 1) hi vals
                    in Node mid (vals !! mid) left right

    -- a)
    get Empty _ = error "Index out of bounds."
    get (Node index val left right) wantedIndex
        | wantedIndex == index = val
        | wantedIndex < index = get left wantedIndex
        | wantedIndex > index = get right wantedIndex

    update Empty _ _ = Empty    -- vracime strom
    update (Node index val left right) wantedIndex newVal
        | wantedIndex == index = (Node index newVal left right)     -- vratime cely aktualni strom s vymenenou novou hodnotou
        | wantedIndex < index = Node index val (update left wantedIndex newVal) right   -- musime aktualizovat podstrom, ale vracime cely strom, nejen podstrom
        | wantedIndex > index = Node index val left (update right wantedIndex newVal)

-- c)
instance Foldable FPole where
    foldr _ a Empty = a
    foldr f a (Node _ val left right) = 
        foldr f (f val (foldr f a right)) left
    
-- d)
instance Functor FPole where
    fmap _ Empty = Empty
    fmap f (Node index val left right) = 
        Node index (f val) (fmap f left) (fmap f right)

-- Example usage to test the implementation
main :: IO ()
main = do
    let p = make [4, 6, 8, 10] :: FPole Int
    print $ get p 2 -- Should print 8
    let p1 = update p 2 7
    print $ get p1 2 -- Should print 7
    print $ get p1 3 -- Should print 10
    print $ maximum p1 -- Should print 10
    let p2 = fmap negate p1
    print $ maximum p2 -- Should print -4


-------------------------------------------------------------------------------------------------------------

-- class Foldable m => Pole m where
--     make :: [t] -> m t
--     get :: m t -> Int -> t
--     update :: m t -> Int -> t -> m t

-- data FPole t = ArrayNil | FItem (FPole t) (Int, t) (FPole t) deriving Show

-- instance Pole FPole where
--     make :: [t] -> FPole t
--     make [] = ArrayNil
--     make l = helper l 0
--         where
--             helper [] _ = ArrayNil
--             helper [a] start = FItem ArrayNil (start, a) ArrayNil
--             helper list start = FItem (helper left start) (half, middle) (helper right (half+1))
--                 where
--                     len = length list
--                     half = len `div` 2
--                     left = take half list
--                     (middle:right) = drop half list

--     get :: FPole t -> Int -> t
--     get ArrayNil i = error "index out of bounds"
--     get (FItem l (n, item) r) i
--         | n == i = item
--         | n > i = get l i
--         | otherwise = get r i

--     update :: FPole t -> Int -> t -> FPole t
--     update (FItem l (n, item) r) index newItem
--         | n == index = FItem l (n, newItem) r
--         | n > index = FItem l (n, item) (update r index newItem)
--         | otherwise = FItem (update l index newItem) (n, item) r

-- instance Foldable FPole where
--     foldMap f ArrayNil = mempty
--     foldMap f (FItem l (n, item) r) = foldMap f l <> f item <> foldMap f r
--     -- foldr f b ArrayNil = b
--     -- foldr f b (FItem l (n, item) r) =   

-- instance Functor FPole where
--     fmap f ArrayNil = ArrayNil
--     fmap f (FItem l (n, item) r) = FItem (fmap f l) (n, f item) (fmap f r)
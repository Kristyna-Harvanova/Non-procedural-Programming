



-------------------------------------------------------------------------------------------------




-- -- PRIORITY QUEUE

-- class (Functor q) => PQueue q where
--     empty :: q a
--     insert' :: (a, Int) -> q a -> q a
--     remove :: q a -> ((a, Int), q a)
--     merge :: q a -> q a -> q a

-- data FQueue a = Q [(Int, [a])] deriving Show


-- instance PQueue FQueue where
--     empty :: FQueue a
--     empty = Q []

--     insert' :: (a, Int) -> FQueue a -> FQueue a
--     insert' (i, p) (Q list)
--         | null larger  = Q (smaller ++ [(p, [i])])
--         | pLarger /= p = Q (smaller ++ [(p, [i])] ++ larger)
--         | otherwise    = Q (smaller ++ [(pLarger, listLarger ++ [i])] ++ otherLarger)
--         where
--             (smaller, larger) = partition ((p >) . fst) list
--             (pLarger, listLarger) = head larger
--             otherLarger = tail larger

--     remove :: FQueue a -> ((a, Int), FQueue a)
--     remove (Q []) = error "Empty queue"
--     remove (Q ((p, i:list):rest))
--         | null list = ((i, p), Q rest)
--         | otherwise = ((i, p), Q ((p, list):rest))

--     merge :: FQueue a -> FQueue a -> FQueue a
--     merge (Q list) (Q []) = Q list
--     merge (Q []) (Q list) = Q list
--     merge (Q ((p1,list1):rest1)) (Q ((p2,list2):rest2))
--         | p1 < p2  = Q ((p1,list1):mergedP1Smaller)
--         | p2 < p1  = Q ((p2,list2):mergedP2Smaller)
--         | p1 == p2 = Q ((p1, list1++list2):mergedSame)
--             where
--                 (Q mergedP1Smaller) = merge (Q rest1) (Q ((p2,list2):rest2))
--                 (Q mergedP2Smaller) = merge (Q ((p1,list1):rest1)) (Q rest2)
--                 (Q mergedSame)      = merge (Q rest1) (Q rest2)


-- instance Functor FQueue where
--     fmap f (Q []) = Q []
--     fmap f (Q ((p,l):list)) = Q ((p, map f l):mapped)
--         where
--             (Q mapped) = fmap f (Q list)


-- instance Foldable FQueue where
--     foldr :: (a -> b -> b) -> b -> FQueue a -> b
--     foldr f b (Q []) = b
--     foldr f b (Q ((p,l):list)) = newB'
--         where 
--             newB = foldr f b (Q list)
--             newB' = foldr f newB l


import Data.Maybe

--a)
type Graf_ = [(String , [(String, Int)])]

-- b)
type Graf a b = [(a , [(a, b)])]


-- a), c)
g :: Graf String Int
g = [   ("a", [("b",1), ("c", 1), ("f", 3)]),
        ("b", [("d", 2)]),
        ("c", [("b", 2), ("e", 1)]),
        ("d", [("c", 2)]),
        ("e", [("d", 3)]),
        ("f", [("c", 4), ("e", 2)])
    ]

-- nc :: Graf -> String -> String -> Maybe ([String], Int)
nc :: (Num n, Eq a, Ord n) => [(a, [(a, n)])] -> a -> a -> Maybe ([a], n)
nc g u v = solution $ findRoutes g u v [] 0
    where
        solution [] = Nothing
        solution ((n, c):rs) = Just (reverse c, n)


findRoutes :: (Num n, Eq a, Ord n) => [(a, [(a, n)])] -> a -> a -> [a] -> n -> [(n, [a])]
findRoutes g u v c l = longestRoute $ concatMap (fRoute gNew v (u:c) l) ns
    where 
        ns = findNeighbours g u
        gNew = filter (\(a,b) -> a /= u) g 

        fRoute g v c l (u,i) 
            | v == u = [(l+i, u:c)]
            | otherwise = findRoutes g u v c (l+i)

        longestRoute [] = []
        longestRoute rs = [(m, reverse $ fromJust $ lookup m rs)]
            where 
                m = maximum (map fst rs)


findNeighbours :: Eq a => [(a, [b])] -> a -> [b]
findNeighbours g u
    | isNothing ns = []
    | otherwise = fromJust ns
    where 
        ns = lookup u g

-- d) išlo to spraviť bez zmeny kódu, stačilo mi zobecniť signatúry
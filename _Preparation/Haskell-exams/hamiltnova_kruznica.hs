import Data.Maybe

-- pôvodná definícia
type Graf_ = [(Int, [Int] )]

-- b) zobecnená definícia
type Graf v = [(v, [v] )]

-- a), c)
g :: Graf Int
g = [(1, [3,6]), (2, [6]), (3, [2,5]), (4, [1,3]), (5, [2,4]), (6, [3,4,5])]

hc :: Eq v => Graf v -> Maybe [v]
hc ((v, ns):xs) 
    | result == [] = Nothing
    | otherwise = Just (reverse result)
    where
        result = hcc v ns xs [v]

hcc :: Eq v => v -> [v] -> [(v, [v])] -> [v] -> [v]
hcc vl [] g c = []
hcc vl (n:ns) g c 
    | result == [] = hcc vl ns g c
    | otherwise = result
    where
        result = hccc vl n g c


hccc :: Eq v => v -> v -> [(v, [v])] -> [v] -> [v]
hccc vl v [] c 
    | v == vl = c
    | otherwise = []
hccc vl v g c 
    | isNothing ns = []
    | otherwise = hcc vl (fromJust ns) gNew (v:c)
    where 
        ns = lookup v g
        gNew = filter (\(x, _) -> x /= v) g


-- c) stačilo zobecniť signatúry funkcií, a omedzenie - Eq v 

-- hc g
-- Just [1, 3, 5, 2, 6, 4]

-- hc [(1, [2]), (2,[3]), (3,[4]), (4,[5]), (5,[2])] 
-- Nothing
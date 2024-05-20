import Data.Maybe

-- pôvodná mapa
type Mapa_ = [((Int, Int), [(Int, Int)])]
-- b)
type Mapa a = [((a, a), [(a, a)])]

-- a)
zdroje :: Ord a => Floating  a => Mapa a -> [((a, a), (a, a))]
zdroje [] = []
zdroje rs = concatMap pripojZdroj rs
    where 
        pripojZdroj (_, []) = []
        pripojZdroj ((x, y), zs) = [((x, y), fromJust n)]
            where 
                ns = filter (\(a,b) -> (a <= x) && (b <= y)) zs
                dists = map (\(a,b) -> sqrt ((a-b)*(a-b) + (b - y)*(b - y))) zs  -- potencionálne sa dá použiť iná metrika, na zistenie najbližšieho políčka
                min = minimum dists
                n = lookup min (zip dists ns)


-- d) 
-- zdroje :: Ord a -> Mapa a -> (a -> a -> bool) -> [((a, a), (a, a))]

-- skompiluje sa v pohode
-- neviem či funguje tak ako má, nemám test data zo skúšky
-- skúšal som nejakých pár vlastných testov
-- a myslím si, že to robí čo má, ale nvm :/

-- testy
-- zdroje [((0,0), []), ((1,0), [(0,0)]), ((1,1), [(0,0), (1,0)])]
-- zdroje [((0,0), []), ((1,0), [(0,0)]), ((1,1), [(0,0), (1,0)]), ((2,2), [(0,0), (1,1), (1,0)]), ((0,1), [(1,1), (0,0), (2,2)])]


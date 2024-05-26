import Data.Maybe
import Data.List
-- 16:40 - 17:41

type Graf a = [ (a, [a]) ]

g1 :: Graf Int
g1 = [(1, [3,6]), (2, [6]), (3, [2,5]), (4, [1,3]), (5, [2,4]), (6, [3,4,5])]

hc :: Eq a => Graf a -> Maybe [a]
hc g = listToMaybe $ hc' g

hc' :: Eq a => Graf a -> [[a]]
hc' g = go (map fst (tail g)) [firstVertex] -- vždy začínáme prvním vrcholem (je to jedno, je to cyklus)
  where
    firstVertex = fst (head g)

    neighbors v = fromJust $ lookup v g

    -- go :: [Int] -> [Int] -> [[Int]]
    go [] acc = if firstVertex `elem` neighbors (head acc) -- kontrola, že poslední vrchol je spojen s prvním
                  then [reverse acc]
                  else []
    go verticesLeft acc = do
      v <- verticesLeft `intersect` neighbors (head acc) -- pro všechny sousedy posledního přidaného vrcholu, které ještě nejsou v cyklu...
      go (filter (/=v) verticesLeft) (v:acc) -- zkusíme dokončit cyklus


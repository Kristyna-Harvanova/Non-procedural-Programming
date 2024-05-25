import Data.Maybe
import Data.List (maximumBy)
import Data.Ord (comparing)
-- 20:17 - 20:57

type Graf v c = [ (v, [(v,c)]) ]

g :: Graf String Int
g = [("a", [("b",1), ("c",1), ("f",3)]),
     ("b", [("d",2)]),
     ("c", [("b",2), ("e",1)]),
     ("d", [("c",2)]),
     ("e", [("d",3)]),
     ("f", [("c",4), ("e",2)])]

-- naslednici :: String -> Graf -> [(String,Int)]
naslednici v g = fromMaybe [] (lookup v g)

maximumBySafe _ [] = Nothing
maximumBySafe f xs = Just (maximumBy f xs)

-- nc :: Graf -> String -> String -> Maybe ([String], Int)
nc :: (Ord b, Eq a, Num b) => Graf a b -> a -> a -> Maybe ([a], b)
nc g fromV toV = (\(p,c) -> (reverse p, c)) <$> go fromV toV [fromV] 0
  where
    -- go :: String -> String -> [String] -> Int -> Maybe ([String],Int)
    go fromV toV path len
      | fromV == toV = Just (path, len)
      | otherwise    =
        let
          mozniNaslednici = filter (\(n,_) -> n `notElem` path) $ naslednici fromV g
          nejdelsiCesty = mapMaybe (\(n,c) -> go n toV (n:path) (len+c)) mozniNaslednici
        in maximumBySafe (comparing snd) nejdelsiCesty


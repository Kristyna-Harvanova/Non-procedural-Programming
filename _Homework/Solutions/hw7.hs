import Data.Char
import Data.List

is_equiv :: (a -> a -> Bool) -> [a] -> Bool
is_equiv (~=) set = refl && sym && trans
  where
    infix 1 ==>
    x ==> y = not x || y

    every c = all c set

    refl  = every (\x -> x ~= x)
    sym   = every (\x -> every (\y -> x ~= y ==> y ~= x))
    trans = every (\x -> every (\y -> every (\z -> x ~= y && y ~= z ==> x ~= z)))

classes :: (a -> a -> Bool) -> [a] -> [[a]]
classes _    []     = []
classes (~=) (x:xs) = (x:ex):classes (~=) nex
  where
    (ex, nex) = partition (x ~=) xs

reflexive_closure :: (Eq a) => (a -> a -> Bool) -> (a -> a -> Bool)
reflexive_closure (~=) x y = x == y || x ~= y


caesar :: Int -> String -> String
caesar n = map shift
  where
    shift c
        | isLower c = spin c 'a'
        | isUpper c = spin c 'A'
        | otherwise = c

    spin c base = chr (ord base + (ord c - ord base + n) `mod` 26)

rotate :: Int -> [a] -> [a]
rotate n xs = drop n xs ++ take n xs

chiSq :: [Double] -> [Double] -> Double
chiSq os es = sum (zipWith (\o e -> (o - e) ** 2 / e) os es)

crack :: [Double] -> String -> String
crack freq text = caesar (-key) text
  where
    x // y = fromIntegral x / fromIntegral y

    alpha    = map toLower (filter isAlpha text)
    alphaLen = length alpha
    observed = [length (filter (== c) alpha) // alphaLen | c <- ['a'..'z']]

    freq1 = map (/ 100) freq
    key   = snd (minimum [(chiSq (rotate n observed) freq1, n) | n <- [0..25]])
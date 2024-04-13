factors :: Int -> [Int]
factors = go 2
  where
    go k p
        | k * k > p      = [p]
        | p `mod` k == 0 = k:go k (p `div` k)
        | otherwise      = go (k + 1) p

isPrime :: Int -> Bool
isPrime n = factors n == [n]

primesTo :: Int -> [Int]
primesTo n = [p | p <- [2..n], isPrime p]

gap :: Int -> (Int, Int)
gap = go . primesTo
  where
    go [a, b] = (a, b)
    go (a:b:r)
        | b - a >= q - p = (a, b)
        | otherwise      = (p, q)
      where
        (p, q) = go (b:r)
    go _ = undefined

googolMod :: Integer -> Integer -> Integer
googolMod 0 k = 10 `mod` k
googolMod n k = googolMod (n - 1) k ^ 10 `mod` k


-- jen tak pro zajimavost, gap se da napsat na jednu radku -- tyhle fce si pozdeji ukazeme
gap = maximumBy (compare `on` uncurry subtract) . reverse . (zip <*> tail) . primesTo
 
-- (potrebuje moduly Data.List a Data.Function)
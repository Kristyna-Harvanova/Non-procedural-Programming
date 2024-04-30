import Data.Char
import Data.List

search :: [String] -> [String] -> [Int]
search grid = map (count . map toLower)
  where
    gridA = map (map toLower) grid
    gridB = transpose gridA

    line  s = length . filter (s `isPrefixOf`) . tails
    count s = sum [line s' l | g <- [gridA, gridB], l <- g, s' <- [s, reverse s]]
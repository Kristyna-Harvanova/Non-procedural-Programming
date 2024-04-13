import Data.Char(chr, ord, toLower, isAlpha)
-- Caesarova šifra je historická kryptografická metoda, která všechna písmena ve zprávě cyklicky posune o n pozic v abecedě dopředu. 
-- Julius Caesar údajně používal tuto metodu s posunutím n = 3: například slovo caesar by se zašifrovalo jako fdhdvu. 
-- V jazyce Haskell lze tuto metodu implementovat například takto:

-- import Data.Char (ord, chr, isLower, isUpper)

velikostAbecedy :: Int
velikostAbecedy = ord 'z' - ord 'a' + 1

-- vrati pozici pismena c v abecede zacinajici pismenem a
pismenoNaCislo :: Char -> Char -> Int
pismenoNaCislo a c = ord c - ord a

-- vrati n-te pismeno v abecede zacinajici pismenem a
cisloNaPismeno :: Char -> Int -> Char
cisloNaPismeno a n = chr (ord a + n)

-- cyklicky posune pismeno c o n pozic v abecede zacinajici pismenem a
posun :: Int -> Char -> Char -> Char
posun n c a = cisloNaPismeno a ((pismenoNaCislo a c + n) `mod` velikostAbecedy)

-- cyklicky posune male/velke pismeno o n pozic v abecede malych/velkych pismen
-- ostatni znaky nemeni
posun' :: Int -> Char -> Char
posun' n c | isLower c = posun n c 'a'
           | isUpper c = posun n c 'A'
           | otherwise = c

-- zadany text xs sifruje (desifruje) pomoci klice n (-n)
caesar :: Int -> String -> String
caesar n xs = [posun' n x | x <- xs]
-- Caesarovu šifru lze snadno prolomit, je-li šifrovaný text dostatečně dlouhý a jsou známy průměrné četnosti výskytů písmen v jazyce, v němž je text napsán. 
-- Metodu popsal již Edgar Allan Poe v klasické detektivní povídce Zlatý brouk.

-- V jazyce Haskell sestavte funkci
-- crack :: [Double] -> String -> String
-- která obdrží zašifrovaný text a tabulku očekávaných četností znaků v jazyce textu, a vrátí nejpravděpodobnější původní text.

-- Při ladění můžete využít známé hodnoty očekávaných četností znaků [%] v anglickém či českém jazyce (jen písmena latinské abecedy bez diakritiky):
enFreq :: [Double]
enFreq = [8.2, 1.5, 2.8, 4.3, 12.7, 2.2, 2.0,
          6.1, 7.0, 0.2, 0.8, 4.0, 2.4, 6.7,
          7.5, 1.9, 0.1, 6.0, 6.3, 9.1, 2.8,
          1.0, 2.4, 0.2, 2.0, 0.1]

czFreq :: [Double]
czFreq = [8.6, 1.7, 3.3, 3.6, 10.5, 0.2, 0.2,
          2.2, 7.5, 2.2, 3.6, 4.2, 3.5, 6.8,
          8.0, 3.2, 0.01, 4.9, 6.3, 5.1, 4.0,
          4.3, 0.01, 0.1, 2.8, 3.2]

-- Kupříkladu v anglickém textu se E (či e) vyskytuje v asi 12.7% ze všech písmen, leč pouze 0.1% z nich představuje Z (či z).
-- Budeme předpokládat, že text byl zašifrován funkcí caesar definovanou výše, 
-- tj. posouvají se jen velká ('A'..'Z') a malá ('a'..'z') písmena latinské abecedy. Ostatní znaky zůstávají nezměněny.

-- Příklad:
-- crack enFreq "S vsuo zbyqbkwwsxq sx Rkcuovv!"

-- Očekávaný výsledek:
-- "I like programming in Haskell!"

-- Zdůvodnění:
-- caesar 10 "I like programming in Haskell!"
-- "S vsuo zbyqbkwwsxq sx Rkcuovv!"

-- Nápověda:
-- 1. Definujte funkci, která spočítá tabulku (reprezentovanou seznamem) empirických četností, tj. četností znaků v zašifrovaném textu
-- 2. Porovnejte každou možnou cyklickou rotaci této tabulky se zadanou tabulkou očekávaných četností.
-- 3. Pro porovnání empirických (e i) a očekávaných (o i) četností pro všech n uvažovaných znaků abecedy lze použít statistiku χ2 (stačí uvažovat jen malá / velká písmena):
-- ∑(i=1..n) = (e i - o i)^2
-- Minimální hodnota statistiky odpovídá nejvyšší shodě a udává tedy to nejpravděpodobnější posunutí, které bylo použito při šifrování.
-- 4. Pro určení minima seznamu lze využít knihovní funkci 
-- minimum :: Ord a => [a] -> a
-- 5. Pro zjištění hodnoty posunutí bude třeba zašifrovaný text dešifrovat, k čemuž poslouží funkce caesar definovaná výše.
-- 6. Můžete samozřejmě využít i libovolnou další funkci, která byla probrána na přednášce či na cvičení. Z knihovních funkcí, na něž jsme dosud nenarazili, se může hodit
-- isAlpha :: Char -> Bool
-- z modulu Data.Char, která zjistí, zdali je zadaný znak písmenem.


crack :: [Double] -> String -> String


import Data.Char (chr, ord, toLower, isAlpha)
import Data.List (minimumBy)
import Data.Ord (comparing)

-- 1. Define a function to compute empirical frequencies of each letter in a given string.
letterFreqs :: String -> [Double]
letterFreqs text = let filteredText = filter isAlpha text
                       totalCount = fromIntegral (length filteredText)
                   in [fromIntegral (length (filter ((== c) . toLower) filteredText)) / totalCount | c <- ['a'..'z']]

-- 3. Calculate the chi-squared statistic to compare two frequency distributions.
chiSquared :: [Double] -> [Double] -> Double
chiSquared observed expected = sum [((o - e) ** 2) / e | (o, e) <- zip observed expected, e /= 0]

-- Helper function to rotate a list n positions to the right (used in step 2).
rotate :: Int -> [a] -> [a]
rotate n xs = drop n' xs ++ take n' xs
  where n' = length xs - n

-- Function to decrypt a message using a negative shift in the Caesar cipher (part of step 6).
decrypt :: Int -> String -> String
decrypt shift = map (\c -> if isAlpha c then caesar (-shift) [c] else c)

-- Main crack function
-- 2., 3., and 4. Test all possible cyclic rotations, calculate chi-squared for each, and determine the minimum.
-- 5. Use the minimum function to find the least chi-squared value which indicates the best match (most probable original shift).
crack :: [Double] -> String -> String
crack expectedFreqs encryptedText = decrypt bestShift encryptedText
  where
    observedFreqs = letterFreqs encryptedText
    shiftsChiSquared = [(shift, chiSquared (rotate shift observedFreqs) expectedFreqs) | shift <- [0..25]]
    bestShift = fst $ minimumBy (comparing snd) shiftsChiSquared

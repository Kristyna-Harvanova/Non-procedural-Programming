-- Cílem této úlohy je sestavit funkci search pro vyhledávání slov v písmenné mřížce:
-- search :: [String] -> [String] -> [Int]

-- Prvním argumentem funkce je seznam řetězců, které představují řádky mřížky; všechny řetězce budou tedy téže délky. Druhým argumentem je seznam hledaných slov.
-- Každé ze slov se může v mřížce vyskytnout
-- - jednou, vícekrát, nebo také vůbec,
-- - vodorovně (na řádku) zleva doprava nebo zprava doleva,
-- - svisle (ve sloupci) shora dolů nebo zdola nahoru.

-- Při vyhledávání ignorujte velikost písmen: slovo potato se tedy může v mřížce vyskytnout jako PoTaTO.

-- Vaše funkce by měla vrátit seznam přirozených čísel, udávajících počty výskytů každého ze zadaných slov v mřížce.

-- Příklad:
-- test = search
--         ["ARTTEEB",
--          "DSOPNLT",
--          "TURNIPA",
--          "XKROFET",
--          "SKALEOT",
--          "MRCTEEB"]
--         ["beet", "carrot", "kale", "turnip", "potato"]

-- > test
-- [2,1,1,1,0]

-- Příklad #2:
-- test2 = search
--         ["ABCBA",
--          "BCABC",
--          "CABCA",
--          "BCABC",
--          "ABABA"]
--         ["abc", "bca"]

-- > test2
-- [7,5]

-- Poznámka: Největší testovací mřížka má rozměry 400 x 400. Zde je příklad dotazu na mřížku o takové velikosti.
-- test3 = let line = cycle "dandelion"
--             grid = take 400 [take 400 s | s <- tails line]
--         in search grid ["Dand", "LION", "iled", "noile", "dandy"]   

-- > test3
-- [35290,35288,35290,35200,0]

-- Definice testu využívá knihovní funkce cycle a tails, které jsme dosud neprobírali. První z nich řetězením svého argumentu vygeneruje nekonečný seznam, 
-- druhá (definovaná v modulu Data.List) vrátí seznam všech přípon zadaného seznamu.

-- Návod: Ve Vašem řešení můžete samozřejmě využít libovolné knihovní funkce, které byly probrány na cvičení či na přednášce. Z těch neprobraných doporučuji zvážit použití
-- - funkce toLower pro konverzi na malá písmena (na cvičení jsme měli toUpper)
-- - funkce transpose, která transponuje matici zadanou seznamem řádkových seznamů (programovali jsme v Prologu, v Haskellu bychom to jistě zvládli také),
-- - případně též funkce tails popsané výše.

-- První z nich je definována v modulu Data.Char, zbylé dvě v Data.List. Pro použití je třeba příslušné moduly importovat.

import Data.List
import Data.Char

-- (Not used) help function that tells if a word is in a line or not.
findInLine :: String -> String -> Bool
findInLine line word = 
    let lowerLine = map toLower line
        lowerWord = map toLower word
    in isInfixOf lowerWord lowerLine || isInfixOf lowerWord (reverse lowerLine)

-- A help function that finds the number of occurences of a word in one line in both directions (from start to end and from end to start of the line).
countInLine :: String -> String -> Int
countInLine line word = 
    let lowerLine = map toLower line
        lowerWord = map toLower word
        count line = length (filter (isPrefixOf lowerWord) (tails line))
    in 
        if (length word) <= 1 then count lowerLine          -- if the word is just one character it should not be found twice (in line and in reverse line)
        else count lowerLine + count (reverse lowerLine)

-- A help function that finds the number of occurences of a word in all provided lines (in both directions).
countInLines :: [String] -> String -> Int
countInLines [] _ = 0
countInLines (line:lines) word =
    let count = countInLine line word
    in count + countInLines lines word

-- A help function that finds the number of occurences of a word in whole grid - in all lines (both directions = left to rigth and right to left) 
-- and all transposed lines (both directions = top to bottom and bottom to top)
countInGrid :: [String] -> String -> Int
countInGrid grid word = (countInLines grid word) + (countInLines (transpose grid) word)

-- Main function to search for each word in the grid and count occurrences
search :: [String] -> [String] -> [Int]
search grid words = map (countInGrid grid) words
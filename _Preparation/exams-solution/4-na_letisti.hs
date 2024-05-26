-- 2. Haskell (10 bodů): Na letišti
-- V našem problému se pohybujeme na letišti, na němž přistávají (a odkud odlétají) letadla, o nichž jsou známy následující údaje:
-- - čas příletu a odletu, který je dán letovým řádem
-- - kapacita letadla (= maximální počet cestujících)
-- - pro každé letadlo je dále známo, že může stát pouze na některých branách.

-- Na libovolné bráně může stát v libovolném časovém okamžiku nejvýše jedno letadlo. Pokud nelze pro letadlo nalézt přípustnou bránu, 
-- kde by mohlo stát po celou dobu mezi příletem a odletem, pak musí stát na záchytné ploše, jejíž kapacita není potenciálně omezena. 
-- V takovém případě je ovšem třeba zajišťovat přepravu cestujících mezi letadlem a letištní budovou letištním autobusem, což není příliš žádoucí.

-- Cílem problému je nalézt plán přiřazení letadel branám, případně záchytné ploše, který by maximalizoval součet kapacit letadel umístěných na branách.
--  Nebudeme ale hledat optimální řešení, místo toho se pokusíme navrhnout nějakou smysluplnou heuristiku a implementovat ji v jazyce Haskell.

-- (a) Definujte datové typy
-- - Letadlo pro reprezentaci všech údajů o letadle, potřebných pro řešení našeho problému (viz výše)
-- - Brana pro identifikaci brány.
-- U každého zvažte, zda-li bude vhodnější použít algebraický datový typ (data) či typové synonymum (type). 
-- Pokud to budete považovat za vhodné, můžete si samozřejmě zavést i další datové typy (např. pro identifikaci letadla).

-- (b) Definujte typovou signaturu funkce alokace, která
-- - obdrží údaje o všech letadlech
-- - a seznam použitelných bran
-- - a vrátí plán přiřazení letadel branám.

-- (c) Funkci alokace implementujte. Budete-li používat pomocné funkce, u každé v komentáři popište její význam.

-- (d) Stručně vysvětlete heuristiku, realizovanou v (c), a stručně zdůvodněte, proč dává její použití pro řešení našeho problému smysl.

import Data.List (find)
import Data.Maybe (isJust)

-- a)
type Brana = String

data Letadlo = Letadlo {
  casPriletu :: Int,
  casOdletu :: Int,
  kapacita :: Int,
  mozneBrany :: [Brana]
} deriving (Show, Eq)

-- Sample data type for test purposes
letadla :: [Letadlo]
letadla = [
  Letadlo { casPriletu = 1, casOdletu = 5, kapacita = 100, mozneBrany = ["A", "B"] },
  Letadlo { casPriletu = 6, casOdletu = 10, kapacita = 150, mozneBrany = ["A"] },
  Letadlo { casPriletu = 2, casOdletu = 7, kapacita = 120, mozneBrany = ["B", "C"] }
    ]

brany :: [Brana]
brany = ["A", "B", "C"]


--b)
-- alokace :: [Letadlo] -> [Brana] -> [(Letadlo, Brana)]


--c)
-- Helper function to check if a gate is available for the given plane
isGateAvailable :: [(Letadlo, Brana)] -> Letadlo -> Brana -> Bool
isGateAvailable assignments plane gate =
  all (\(p, g) -> g /= gate || casOdletu p <= casPriletu plane || casOdletu plane <= casPriletu p) assignments

-- Main allocation function
alokace :: [Letadlo] -> [Brana] -> [(Letadlo, Brana)]
alokace planes gates = foldl allocatePlane [] planes
  where
    allocatePlane :: [(Letadlo, Brana)] -> Letadlo -> [(Letadlo, Brana)]
    allocatePlane assignments plane =
      let availableGate = find (\gate -> isGateAvailable assignments plane gate && gate `elem` mozneBrany plane) gates
      in case availableGate of
           Just gate -> assignments ++ [(plane, gate)]
           Nothing -> assignments


-- (d) Explain the Heuristic
-- The heuristic used in the alokace function is straightforward:

-- For each plane, check each gate to see if it can accommodate the plane without any time conflicts with other planes already assigned to that gate.
-- If a gate is available and is one of the possible gates for the plane, assign the plane to that gate.
-- If no suitable gate is found, the plane is not assigned to any gate (this part can be further handled based on specific requirements, like assigning it to a holding area).
-- The heuristic is simple and efficient for small to moderately sized inputs but does not guarantee an optimal solution. It aims to find a feasible solution that maximizes the utilization of available gates by checking each plane against each gate in a sequential manner.

-- This approach ensures that the function runs in polynomial time relative to the number of planes and gates, making it practical for real-world scenarios where an exact optimal solution is not necessary or too costly to compute.

main :: IO ()
main = do
  let assignments = alokace letadla brany
  print assignments
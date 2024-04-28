-- V jazyce Haskell lze binární vyhledávací stromy (BVS) reprezentovat jakožto algebraický datový typ například takto:
-- data Tree = Nil | Node Tree Int Tree
--     deriving (Eq, Ord, Show)

-- Poznámka: Pro správné automatické vyhodnocení vašeho řešení je třeba, abyste použili uvedenou definici bez změny, včetně odvození instancí typových tříd Eq, Ord a Show.

-- Připomeňme, že binární strom je dokonale vyvážený, pokud pro každý jeho vrchol platí, že počty vrcholů v levém a pravém podstromě se liší nejvýše o 1.

-- Sestavte funkci
-- allBalanced :: Int -> [Tree]

-- která obdrží přirozené číslo N a vrátí seznam všech možných dokonale vyvážených BVS, obsahujících každé z přirozených čísel 1, 2, ... N právě jednou. 
-- Stromy mohou být v seznamu uvedeny v libovolném pořadí.

-- Příklady vstupu a výstupu:
-- > allBalanced 2
-- [Node Nil 1 (Node Nil 2 Nil),Node (Node Nil 1 Nil) 2 Nil]

-- > allBalanced 3
-- [Node (Node Nil 1 Nil) 2 (Node Nil 3 Nil)]

-- > mapM_ print (allBalanced 4)
-- Node (Node Nil 1 Nil) 2 (Node Nil 3 (Node Nil 4 Nil))
-- Node (Node Nil 1 Nil) 2 (Node (Node Nil 3 Nil) 4 Nil)
-- Node (Node Nil 1 (Node Nil 2 Nil)) 3 (Node Nil 4 Nil)
-- Node (Node (Node Nil 1 Nil) 2 Nil) 3 (Node Nil 4 Nil)

-- Funkce mapM_ and print jsme ještě neprobírali. V příkladě výše jsou použity proto, abychom vytiskli každý strom z výstupního seznamu na zvláštní řádek, což učiní výstup o něco čitelnějším.

-- Nápověda:
-- Přemýšlejte rekurzivně: Pro každou možnou hodnotu v kořeni můžete rekurzivně vygenerovat všechny možné levé i pravé podstromy ...

data Tree = Nil | Node Tree Int Tree
    deriving (Eq, Ord, Show)

-- Help function generate all balanced trees for a given list of numbers
allBalancedTrees :: [Int] -> [Tree]
allBalancedTrees [] = [Nil]
allBalancedTrees [x] = [Node Nil x Nil]
allBalancedTrees xs = concat [[Node l x r | l <- allBalancedTrees ls, r <- allBalancedTrees rs] | (ls, x, rs) <- validSplits xs]

-- Generate valid possible ways to pick a root and split the remaining elements into left and right subtrees
validSplits :: [Int] -> [([Int], Int, [Int])]
validSplits [] = []
validSplits [x] = [([], x, [])]
validSplits xs
    | length xs `mod` 2 == 1 =          -- If the number of elements in left and rigth subtree is the same
        let i = (length xs `div` 2) 
        in [(take i xs, xs !! i, drop (i + 1) xs)]  
    | otherwise =                       -- If there is even number of elements, and one from them is root, then number of elems in left subtree is the number of elems in right subtree + 1, and vice versa
        [(take i xs, xs !! i, drop (i + 1) xs) | i <- [(length xs `div` 2) - 1..length xs `div` 2]]

-- Main function to return all balanced trees for numbers 1, 2 .. N
allBalanced :: Int -> [Tree]
allBalanced n = allBalancedTrees [1..n]

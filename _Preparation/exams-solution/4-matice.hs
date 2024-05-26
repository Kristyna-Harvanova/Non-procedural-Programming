-- 3. Haskell (10 bodů): Matice v typové třídě
-- Následující typová třída reprezentuje matice s prvky typu a:
-- class TMatice q where
--   soucin    :: Num a => q a -> q a -> Maybe (q a)
--   submatice :: q a -> (Int,Int) -> (Int,Int) -> Maybe (q a)
--   -- další metody nebudeme uvažovat

-- Funkce soucin dvě zadané matice vynásobí, pokud to jejich rozměry umožňují, v opačném případě vrátí Nothing. 
-- Funkce submatice vrátí submatici zadané matice, určenou souřadnicemi levého horního a pravého dolního rohu. 
-- V případě chybně zadaných souřadnic vrátí Nothing.

-- (a) Definujte nový datový typ RMatice pro reprezentaci řídkých matic s prvky typu a:
-- data RMatice a = ...
-- Řídká matice má většinu svých prvků rovných nule. Vaše reprezentace
-- - by měla obsahovat rozměry matice a nenulové prvky s identifikací jejich pozice,
-- - prostorová složitost by tedy měla být lineární v počtu nenulových prvků,
-- - pokud budete u nenulových prvků předpokládat nějaké uspořádání, uveďte to prosím do poznámky.

-- (b) Deklarujte typ RMatice jako instanci typové třídy TMatice
-- instance TMatice RMatice where
--   soucin ...
-- včetně implementace metod soucin a submatice.

-- (c) Deklarujte typ RMatice jako instanci typové třídy Show (za předpokladu, že typ prvků matice je instancí Show)
-- instance Show a => Show (RMatice a) where
--   show ...
-- včetně implementace metody show. Tu implementujte nějakým rozumným způsobem tak, aby z výstupu byl patrný skutečný obsah matice.

-- Poznámka: Funkce show pouze převede matici z interní reprezentace (navržené v (a)) na řetězec. 
-- Jde jen o práci s řetězci (a volání funkce show na prvky matice), není třeba žádné I/O funkce.

-- (d) Je možné rozšířit návrh datového typu RMatice tak, aby umožňoval reprezentovat i nekonečné matice? 
-- Pokud ne, vysvětlete proč ne. Pokud ano, využijte zvolenou definici ke konstrukci nekonečné jednotkové matice (jedničky na hlavní diagonále, všude jinde nuly).

class TMatice q where
  soucin    :: Num a => q a -> q a -> Maybe (q a)
  submatice :: q a -> (Int,Int) -> (Int,Int) -> Maybe (q a)
  -- další metody nebudeme uvažovat

-- a)
data RMatice a = RMatice (Int, Int) [((Int, Int), a)]

-- b)
instance TMatice RMatice where
    soucin (RMatice (rowsA, colsA) elemsA) (RMatice (rowsB, colsB) elemsB)
        | colsA /= rowsB = Nothing
        | otherwise = Just $ RMatice (rowsA, colsB) result
        where
            result = [((i, j), sum [x * y | ((i, k1), x) <- elemsA, ((k2, j), y) <- elemsB, k1 == k2]) |
                      i <- [0..rowsA-1], j <- [0..colsB-1]]

    submatice (RMatice (rows, cols) elems) (r1, c1) (r2, c2)
        | r1 < 0 || r2 >= rows || c1 < 0 || c2 >= cols || r1 > r2 || c1 > c2 = Nothing
        | otherwise = Just $ RMatice (r2 - r1 + 1, c2 - c1 + 1) [((r - r1, c - c1), val) | ((r, c), val) <- elems, r >= r1, r <= r2, c >= c1, c <= c2]

-- c)
instance Show a => Show (RMatice a) where
    show (RMatice (rows, cols) elems) = unlines [concat [if (r, c) `elem` positions then show (lookup (r, c) elems) else "0" | c <- [0..cols-1]] | r <- [0..rows-1]]
        where
            positions = map fst elems
            lookup pos = snd . head . filter ((== pos) . fst)

-- d)
-- data RMatice a = RMatice (Int, Int) [((Int, Int), a)] | InfiniteIdentity

-- -- If an infinite identity matrix is needed, we can define specific functions to handle its properties without storing all elements.

-- instance TMatice RMatice where
--     soucin (RMatice (rowsA, colsA) elemsA) (RMatice (rowsB, colsB) elemsB)
--         | colsA /= rowsB = Nothing
--         | otherwise = Just $ RMatice (rowsA, colsB) result
--         where
--             result = [((i, j), sum [x * y | ((i, k1), x) <- elemsA, ((k2, j), y) <- elemsB, k1 == k2]) |
--                       i <- [0..rowsA-1], j <- [0..colsB-1]]
--     soucin InfiniteIdentity m = Just m
--     soucin m InfiniteIdentity = Just m

--     submatice (RMatice (rows, cols) elems) (r1, c1) (r2, c2)
--         | r1 < 0 || r2 >= rows || c1 < 0 || c2 >= cols || r1 > r2 || c1 > c2 = Nothing
--         | otherwise = Just $ RMatice (r2 - r1 + 1, c2 - c1 + 1) [((r - r1, c - c1), val) | ((r, c), val) <- elems, r >= r1, r <= r2, c >= c1, c <= c2]
--     submatice InfiniteIdentity (r1, c1) (r2, c2) = Just $ RMatice (r2 - r1 + 1, c2 - c1 + 1) [((i, j), if i == j then 1 else 0) | i <- [0..r2-r1], j <- [0..c2-c1]]

-- instance (Show a, Num a) => Show (RMatice a) where
--     show (RMatice (rows, cols) elems) = unlines [concat [if (r, c) `elem` positions then show (lookup (r, c) elems) else "0" | c <- [0..cols-1]] | r <- [0..rows-1]]
--         where
--             positions = map fst elems
--             lookup pos = snd . head . filter ((== pos) . fst)
--     show InfiniteIdentity = "Infinite Identity Matrix"

-- In this solution, InfiniteIdentity handles the case of representing an infinite identity matrix. This approach leverages Haskell's lazy evaluation to deal with infinite structures conceptually without explicitly storing them.
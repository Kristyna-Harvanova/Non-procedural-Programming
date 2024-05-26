
-- 3. Haskell (10 bodů): Prioritní fronta

-- Následující typová třída reprezentuje prioritní frontu s prvky typu a, které mají přiřazeny priority typu Int:

-- class (Functor q) => PQueue q where
--   empty  :: q a
--   insert :: (a, Int) -> q a -> q a
--   remove :: q a -> ((a, Int), q a)
--   merge  :: q a -> q a -> q a

-- přičemž:
-- - empty reprezentuje prázdnou prioritní frontu,
-- - insert vloží hodnotu s prioritou do fronty,
-- - remove odebere hodnotu s minimální prioritou z fronty,
-- - merge sloučí dvě zadané prioritní fronty do jediné.

-- Pozor na to, že PQueue je podtřídou (potomkem) typové třídy Functor, takže každá její instance musí 
-- být též instancí Functoru: musí tedy implementovat fmap, která aplikuje zadanou funkci na všechny 
-- hodnoty ve frontě, přitom priority ponechá nezměněny.

-- (a) Pro implementaci prioritní fronty definujte nový datový typ FQueue
-- data FQueue ...

-- Datový typ navrhněte tak, aby operaci remove bylo možné realizovat v čase O(1), 
-- zatímco u operací insert a merge stačí čas O(N), kde N je počet prvků ve výsledné frontě.

-- (b) Deklarujte FQueue jako instanci typové třídy PQueue
-- instance PQueue FQueue ...
-- včetně implementace metod empty, insert, remove a merge.

-- (c) Protože PQueue je potomkem typové třídy Functor, bude třeba deklarovat FQueue i jako instanci Functoru:
-- instance Functor FQueue where ...
-- včetně implementace metody fmap.

-- (d) Deklarujte FQueue jako instanci typové třídy Foldable
-- instance Foldable FQueue ...
-- k čemuž postačí implementovat metodu foldr (svinování zprava).

-- Příklad použití
-- > q = insert ("python", 5) $ insert ("scala", 10) empty :: FQueue String
-- > r = insert ("prolog", 7) $ insert ("haskell", 3) empty :: FQueue String
-- > t = merge q r
-- > "prolog" `elem` t -- definováno v Foldable
-- True
-- > u = fmap (\s -> s ++ s) t
-- > ((x, p), u1) = remove u
-- > (x, p)
-- ("haskellhaskell",3)

class (Functor q) => PQueue q where
  empty  :: q a
  insert :: (a, Int) -> q a -> q a
  remove :: q a -> ((a, Int), q a)
  merge  :: q a -> q a -> q a


-- a)
data FQueue a = Queue [(a, Int)]
    deriving (Show)

-- b)
instance PQueue FQueue where
    empty :: FQueue a
    empty = Queue []

    -- -- nejvyssi po nejnizsi
    -- merge :: FQueue a -> FQueue a -> FQueue a
    -- merge (Queue fq1) (Queue fq2) = Queue (mergeHelp fq1 fq2 [])     -- volame pomocnou funkci na seznamy a vracime FQueue
    --     where
    --         mergeHelp [] [] queue = queue       -- pokud jiz neni co spojit, vracime seznam
    --         mergeHelp [] ((val2, prior2):fq2) queue = mergeHelp [] fq2 (queue++[(val2, prior2)])    -- pokud uz nezbyva v jednom ze seznamu prvek, pridavame jen z jednoho seznamu
    --         mergeHelp ((val1, prior1):fq1) [] queue = mergeHelp fq1 [] (queue++[(val1, prior1)])    
    --         mergeHelp ((val1, prior1):fq1) ((val2, prior2):fq2) queue                               
    --             | prior1 >= prior2 = mergeHelp fq1 ((val2, prior2):fq2) (queue++[(val1, prior1)])   -- pokud je z prvniho seznamu vetsi priorita, umistime do vysledneho seznamu
    --             | prior1 < prior2 = mergeHelp ((val1, prior1):fq1) fq2 (queue++[(val2, prior2)])    -- pokud z druheho seznamu

    -- nejnizsi po nejvyssi (stacilo zmenit porovnani)
    merge :: FQueue a -> FQueue a -> FQueue a
    merge (Queue fq1) (Queue fq2) = Queue (mergeHelp fq1 fq2 [])     -- volame pomocnou funkci na seznamy a vracime FQueue
        where
            mergeHelp [] [] queue = queue       -- pokud jiz neni co spojit, vracime seznam
            mergeHelp [] ((val2, prior2):fq2) queue = mergeHelp [] fq2 (queue++[(val2, prior2)])    -- pokud uz nezbyva v jednom ze seznamu prvek, pridavame jen z jednoho seznamu
            mergeHelp ((val1, prior1):fq1) [] queue = mergeHelp fq1 [] (queue++[(val1, prior1)])    
            mergeHelp ((val1, prior1):fq1) ((val2, prior2):fq2) queue                               
                | prior1 < prior2 = mergeHelp fq1 ((val2, prior2):fq2) (queue++[(val1, prior1)])   -- pokud je z prvniho seznamu vetsi priorita, umistime do vysledneho seznamu
                | prior1 >= prior2 = mergeHelp ((val1, prior1):fq1) fq2 (queue++[(val2, prior2)])    -- pokud z druheho seznamu

    -- -- nejvyssi po nejnizsi
    -- insert :: (a, Int) -> FQueue a -> FQueue a
    -- insert (newVal, newPriority) (Queue []) = Queue [(newVal, newPriority)]
    -- insert (newVal, newPriority) (Queue ((val, priority):fQueue))
    --     | newPriority >= priority = Queue ([(newVal, newPriority)] ++ ((val, priority):fQueue))
    --     | newPriority < priority = merge (Queue [(val, priority)]) (insert (newVal, newPriority) (Queue fQueue))

    -- nejnizsi po nejvyssi (stacilo zmenit porovnani)
    insert :: (a, Int) -> FQueue a -> FQueue a
    insert (newVal, newPriority) (Queue []) = Queue [(newVal, newPriority)]
    insert (newVal, newPriority) (Queue ((val, priority):fQueue))
        | newPriority < priority = Queue ([(newVal, newPriority)] ++ ((val, priority):fQueue))
        | newPriority >= priority = merge (Queue [(val, priority)]) (insert (newVal, newPriority) (Queue fQueue))

    -- aby mohlo byt remove v O(1), prioritni fronta je razena od nejnizsiho po nejvyssi
    remove :: FQueue a -> ((a, Int), FQueue a)
    remove (Queue (last:fq)) = (last, (Queue fq))

-- c)
instance Functor FQueue where
    fmap :: (a -> b) -> FQueue a -> FQueue b
    fmap f (Queue fq) = Queue (map (\(val, prior) -> ((f val), prior)) fq)
    -- fmap _ (Queue []) = Queue []
    -- fmap f (Queue ((val, prior):fq)) = merge (Queue [((f val), prior)]) (fmap f (Queue fq))

-- d)
instance Foldable FQueue where
    foldr :: (a -> b -> b) -> b -> FQueue a -> b
    foldr _ acc (Queue []) = acc
    foldr f acc (Queue ((val, _):fq)) = f val (foldr f acc (Queue fq))






-------------------------------------------------------------------------------------------------




-- -- PRIORITY QUEUE

-- class (Functor q) => PQueue q where
--     empty :: q a
--     insert' :: (a, Int) -> q a -> q a
--     remove :: q a -> ((a, Int), q a)
--     merge :: q a -> q a -> q a

-- data FQueue a = Q [(Int, [a])] deriving Show


-- instance PQueue FQueue where
--     empty :: FQueue a
--     empty = Q []

--     insert' :: (a, Int) -> FQueue a -> FQueue a
--     insert' (i, p) (Q list)
--         | null larger  = Q (smaller ++ [(p, [i])])
--         | pLarger /= p = Q (smaller ++ [(p, [i])] ++ larger)
--         | otherwise    = Q (smaller ++ [(pLarger, listLarger ++ [i])] ++ otherLarger)
--         where
--             (smaller, larger) = partition ((p >) . fst) list
--             (pLarger, listLarger) = head larger
--             otherLarger = tail larger

--     remove :: FQueue a -> ((a, Int), FQueue a)
--     remove (Q []) = error "Empty queue"
--     remove (Q ((p, i:list):rest))
--         | null list = ((i, p), Q rest)
--         | otherwise = ((i, p), Q ((p, list):rest))

--     merge :: FQueue a -> FQueue a -> FQueue a
--     merge (Q list) (Q []) = Q list
--     merge (Q []) (Q list) = Q list
--     merge (Q ((p1,list1):rest1)) (Q ((p2,list2):rest2))
--         | p1 < p2  = Q ((p1,list1):mergedP1Smaller)
--         | p2 < p1  = Q ((p2,list2):mergedP2Smaller)
--         | p1 == p2 = Q ((p1, list1++list2):mergedSame)
--             where
--                 (Q mergedP1Smaller) = merge (Q rest1) (Q ((p2,list2):rest2))
--                 (Q mergedP2Smaller) = merge (Q ((p1,list1):rest1)) (Q rest2)
--                 (Q mergedSame)      = merge (Q rest1) (Q rest2)


-- instance Functor FQueue where
--     fmap f (Q []) = Q []
--     fmap f (Q ((p,l):list)) = Q ((p, map f l):mapped)
--         where
--             (Q mapped) = fmap f (Q list)


-- instance Foldable FQueue where
--     foldr :: (a -> b -> b) -> b -> FQueue a -> b
--     foldr f b (Q []) = b
--     foldr f b (Q ((p,l):list)) = newB'
--         where 
--             newB = foldr f b (Q list)
--             newB' = foldr f newB l


-- You have all studied relations in mathematics.

-- Let's review a few properties of relations. Suppose that R is a relation on some set A.

-- R is reflexive if x R x for all x in A.
-- R is symmetric if x R y implies y R x, for all x, y in A.
-- R is transitive if x R y and y R z implies x R z, for all x, y, z in A.
-- R is an equivalence relation if it is reflexive, symmetric, and transitive.
-- In Haskell, we can represent a relation on a set of values of type 'a' using a function of type (a -> a -> Bool).

-- a) Write a function
-- is_equiv :: (a -> a -> Bool) -> [a] -> Bool
-- that determines whether a function is an equivalence relation on a given set of values:

-- > is_equiv (\x y -> x `mod` 5 == y `mod` 5) [1..30]
-- True
-- > is_equiv (<=) [1..30]
-- FalsePlus-Vessel-Vastly-Utensil-Overbill0
-- > is_equiv (\x y -> False) [1..3]
-- False
-- > is_equiv (\i j -> abs(i - j) <= 2) [1..20]
-- False

-- b) Write a function
-- classes :: (a -> a -> Bool) -> [a] -> [[a]]
-- that takes an equivalence relation R plus a set S of values, and returns a set of equivalence classes of S with respect to R:

-- > classes (\x y -> x `mod` 5 == y `mod` 5) [2, 7, 6, 100, 3, 4, 5, 8, 1]
-- [[6,1],[3,8],[100,5],[4],[2,7]]
-- You may return the equivalence classes in any order. The elements within each class may appear in any order as well.

-- c) The reflexive closure of a relation R is the smallest relation that contains R and is also reflexive.
-- For example, the reflexive closure of the relation (<) is the relation (<=). The reflexive closure of (<=) is itself.
-- Write a function
-- reflexive_closure :: Eq a => (a -> a -> Bool) -> (a -> a -> Bool)
-- that takes a relation R and returns its reflexive closure:

-- > f = reflexive_closure (<)
-- > f 3 4
-- True
-- > f 4 4
-- True


-- a)
-- Defining all necessary relations to be able to determine the equivalence.

-- R is reflexive if x R x for all x in A.
is_refl :: (a -> a -> Bool) -> [a] -> Bool
is_refl rel set = all (\x -> rel x x) set

-- R is symmetric if x R y implies y R x, for all x, y in A.
-- Using the fact that if `A => B` and `B => A` at the same time, then A must be the same value as B.
is_sym :: (a -> a -> Bool) -> [a] -> Bool
is_sym rel set = all (\(x, y) -> rel x y == rel y x) [(x, y) | x <- set, y <- set]
-- is_sym rel set = all (\(x, y) -> (not (rel x y) || rel y x) && (not (rel y x) || rel x y)) [(x, y) | x <- set, y <- set]

-- R is transitive if x R y and y R z implies x R z, for all x, y, z in A.
-- Using `A => B` is equivalent to `not A or B`.
is_trans :: (a -> a -> Bool) -> [a] -> Bool
is_trans rel set = all (\(x, y, z) -> not (rel x y && rel y z) || rel x z) [(x, y, z) | x <- set, y <- set, z <- set]   

-- R is an equivalence relation if it is reflexive, symmetric, and transitive.
is_equiv :: (a -> a -> Bool) -> [a] -> Bool
is_equiv rel set = (is_refl rel set) && (is_sym rel set) && (is_trans rel set)


-- b)
-- Defining a helper function that divides a list into two parts based on their relation to a given element 'x' (if they are equivalent or not).
partition :: (a -> a -> Bool) -> a -> [a] -> ([a], [a])
partition _ _ [] = ([], [])                                             -- Base case for partition: if the set of elements to part is empty, return two empty lists.
partition rel x (y:set) =                                               -- Recursive case for partition
    let (equivalent, other) = partition rel x set                       -- Check if 'x' is related to 'y' based on the relation 'rel'.
    in if rel x y then (y:equivalent, other) else (equivalent, y:other) -- If true, add 'y' to the 'equivalent' list, otherwise, add 'y' to the 'other' list.

-- Defining a function 'classes' that calculates the equivalence classes of a set given an equivalence relation.
classes :: (a -> a -> Bool) -> [a] -> [[a]]
classes rel [] = []                                                     -- Base case: If the input list is empty, return an empty list of classes.
classes rel (x:set) = let (equivalent, other) = partition rel x set     -- Recursive case: Decompose the list into a head element 'x' and the rest 'set'.
                      in ((x : equivalent) : classes rel other)         -- Prepend the list containing 'x' and its equivalent elements to the list of equivalence classes formed from 'other'.


-- c)
-- Reflexivity ensured by (x == y) - that every element is related to itself. 
-- The (rel x y) - new relation also includes all the relations defined by the original relation rel.
reflexive_closure :: Eq a => (a -> a -> Bool) -> (a -> a -> Bool)
reflexive_closure rel = \x y -> x == y || rel x y
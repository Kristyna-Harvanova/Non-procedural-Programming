-- a)
-- Write a function
-- factors :: Int -> [Int]
-- that computes a list of prime factors of an integer N ≥ 2, in ascending order:

-- > factors 180
-- [2,2,3,3,5]
-- Your function must run in O(sqrt(N)) in the worst case.

-- b)
-- Write a function
-- gap :: Int -> (Int, Int)
-- that takes an integer N ≥ 3 and computes the largest prime gap in the range 2 .. N. 
-- Specifically, the function should return a pair of consecutive primes (p, q) such that 2 ≤ p < q ≤ N and (q - p) is as large as possible. 
-- Because p and q are consecutive primes, all integers k in the range p < k < q must not be prime. 
-- If there are multiple prime gaps (p, q) of maximal size, return the one with the smallest value of p.

-- For example:
-- > gap 1000
-- (887,907)


-- a)

-- -- Find the smallest divisor that is prime.
-- findPrime :: Int -> Int
-- findPrime x = head [p | p <- [2..x], (mod x p) == 0]

-- -- -- Find the smallest divisor that is prime.
-- findPrimeHelper :: Int -> Int -> Int
-- findPrimeHelper x currentDivisor = 
--     if (x `mod` currentDivisor) == 0 then currentDivisor
--     else findPrimeHelper x (currentDivisor + 1)

-- findPrime :: Int -> Int
-- findPrime x = findPrimeHelper x 2
    
-- -- Compute a list of prime factors of an integer x ≥ 2, in ascending order
-- factors :: Int -> [Int]
-- factors x = 
--     if x <= 1 then [] 
--     else let p = findPrime x in p : factors (div x p)
    



-- factorsHelper :: Int -> Int -> Int -> [Int]
-- factorsHelper n 1 p = []
-- factorsHelper n x 2 = 
--     if x `mod` 2 == 0 then 2 : factorsHelper n (x `div` 2) 2
--     else factorsHelper n x 3
-- factorsHelper n x p =
--     if x `mod` p == 0 then p : factorsHelper n (x `div` p) p
--     else factorsHelper n x (p + (x `mod` p))

-- factors :: Int -> [Int]
-- factors x = factorsHelper x x 2


factorsHelper :: Int -> Int -> [Int]
factorsHelper 1 p = []
factorsHelper x p =
    if x < p*p then [x]   -- If no more factors, return x
    else if x `mod` p == 0 then p : factorsHelper (x `div` p) p  -- If p is a factor, include it and continue with x/p
    else factorsHelper x (if p == 2 then 3 else p + 2)  -- Increment p correctly for potential divisors

factors :: Int -> [Int]
factors x = factorsHelper x 2





-- b)

-- Sieve of Eratosthenes algorithm
sieve :: [Int] -> [Int]
sieve [] = []
sieve (p:xs) = p : sieve [x | x <- xs, (mod x p) /= 0]

-- Find all primes up to an integer x
findPrimes :: Int -> [Int]
findPrimes x = sieve [2..x]

-- Pair the consecutive elements in a list
consecutivePrimesPairs :: [Int] -> [(Int, Int)]
consecutivePrimesPairs primes = zip primes (tail primes)

-- Find the pairs of consecutive primes, where each prime is less or equal to x
primePairs :: Int -> [(Int, Int)]
primePairs x = consecutivePrimesPairs (findPrimes x)

-- Compute the largest prime gap in the range 2..x
gap :: Int -> (Int, Int)
gap x = let pairs = primePairs x
            maxPair = foldl (\(maxP, maxQ) (p, q) -> 
              if q-p > maxQ-maxP then (p, q) 
              else (maxP, maxQ)) (0,0) pairs
        in maxPair

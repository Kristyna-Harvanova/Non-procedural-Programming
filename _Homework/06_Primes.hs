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

-- Find the smallest divisor that is prime.
findPrime :: Int -> Int
findPrime x = head [p | p <- [2..x], (mod x p) == 0]

-- Compute a list of prime factors of an integer x ≥ 2, in ascending order
factors :: Int -> [Int]
factors x = 
    if x <= 1 then [] 
    else let p = findPrime x in p : factors (div x p)

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
-- A googolplex is the number 10^(10^100).
-- It is an unimaginably large number. Nevertheless we may determine its value modulo small integers.

-- To assist in this task, write a Haskell function
-- googolMod :: Integer -> Integer -> Integer
-- such that (googolMod n k) returns the value of 10^(10^n) mod k.

-- You may assume that 0 <= n < 1000 and that 0 < k < 100.

-- Example:
-- > googolMod 100 47
-- 9
-- Explanation:
-- 10^(10^100) mod 47 = 9.

-- Example #2:
-- > googolMod 100 2
-- 0


dec2BinHelper :: Integer -> [Int]
dec2BinHelper 0 = [0]
dec2BinHelper 1 = [1]
dec2BinHelper n = fromIntegral (n `mod` 2) : dec2BinHelper (n `div` 2)

-- Return list of 0 and 1 from LSB to MSB
decimal2Binary :: Integer -> [Int]
decimal2Binary n = dec2BinHelper n

-- Recursive function for modular exponentiation using binary digits of exponent
modExpBinary :: Integer -> Integer -> [Int] -> Integer
modExpBinary base k [] = 1
modExpBinary base k (bit:bits) = 
    (if bit == 1 then (base `mod` k) else 1)
    *
    (modExpBinary ((base * base) `mod` k) k bits) 
    `mod` 
    k

-- Computes 10^(10^n) mod k
googolMod :: Integer -> Integer -> Integer
googolMod n k = modExpBinary 10 k (decimal2Binary (10^n))
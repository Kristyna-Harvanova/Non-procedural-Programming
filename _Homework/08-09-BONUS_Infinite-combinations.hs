-- a) Write a function
-- subsets :: [a] -> [[a]]
-- that takes a possibly infinite list and returns a list of all finite subsets of its elements. 
-- You may list the subsets in any order, but every possible subset must appear somewhere in the output. 
-- The elements in each subset must be in the same order as in the original list.

-- Example:
-- > subsets "abc"
-- ["","a","b","ab","c","ac","bc","abc"]
-- > take 10 (subsets [1 ..])
-- [[],[1],[2],[1,2],[3],[1,3],[2,3],[1,2,3],[4],[1,4]]

-- b) Write a function
-- combinations :: Int -> [a] -> [[a]]
-- that takes an integer N >= 0 and a possibly infinite list, and returns a list of all combinations of N elements of the list. 
-- You may list the combinations in any order, but every possible combination must appear somewhere in the output. 
-- The elements in each combination must be in the same order as in the original list.

-- Example:
-- > combinations 2 "tower"
-- ["to","tw","ow","te","oe","we","tr","or","wr","er"]
-- > take 10 (combinations 3 [1 ..])
-- [[1,2,3],[1,2,4],[1,3,4],[2,3,4],[1,2,5],[1,3,5],[1,4,5],[2,3,5],[2,4,5],[3,4,5]]

-- c) Write a function
-- pairs :: [a] -> [b] -> [(a, b)]
-- that takes two possibly infinite input lists and returns a list of all pairs (x, y), where x is an element of the first list and y is an element of the second. 
-- You may list the pairs in any order, but every possible pair must appear somewhere in the output.

-- Example:
-- > pairs "ab" "xyz"
-- [('a','x'),('a','y'),('b','y'),('b','x'),('b','z'),('a','z')]
-- > take 10 (pairs [1 .. 3] [1 ..])
-- [(1,1),(2,1),(1,2),(3,1),(2,2),(3,2),(1,3),(2,3),(3,3),(1,4)]
-- > take 10 (pairs [1 ..] [1 .. 2])
-- [(1,1),(2,1),(1,2),(3,1),(2,2),(3,2),(4,1),(4,2),(5,1),(5,2)]
-- > take 10 (pairs [1 ..] [1 ..])
-- [(1,1),(2,1),(1,2),(3,1),(2,2),(3,2),(1,3),(4,1),(2,3),(4,2)]

-- For all the examples above, your program may actually produce somewhat different output, 
-- since the ordering of the output elements will depend on the details of your implementation.

-- a)
subsets :: [a] -> [[a]]
subsets [] = [[]]
subsets (x:xs) = concat [[x], [subsets xs]]


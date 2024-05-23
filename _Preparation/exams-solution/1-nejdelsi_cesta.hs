import Debug.Trace (trace)

import Data.List (maximumBy)
import Data.Ord (comparing)

-- type Graf = [ (String, [ (String, Int) ]) ]
type Graf a b = [ (a, [ (a, b) ]) ]

-- g :: Graf
g :: Graf String Int
g = [
        ("a", [("b", 1), ("c", 1), ("f", 3)]),
        ("b", [("d", 2)]),
        ("c", [("b", 2), ("e", 1)]),
        ("d", [("c", 2)]),
        ("e", [("d", 3)]),
        ("f", [("c", 4), ("e", 2)])
    ]

-- nc g "a" "e"
-- Just ( ["a", "f", "c", "e"], 8 )

-- nc g "e" "f"
-- Nothing

-- a) definice funkce nc

-- extractName :: (String, [ (String, Int) ]) -> String
-- extractName (vertex, neigbours) = vertex

-- findVertex :: Graf -> String -> (String, [ (String, Int) ])
-- findVertex [] _ = ("", [])
-- findVertex ((vertex, neighbours):graph) name = 
--     if vertex == name then (vertex, neighbours)
--     else findVertex graph name

-- findLongestEdge :: [ (String, Int) ] -> (String, Int)
-- findLongestEdge [] = ("", 0)  -- handle the empty list case
-- findLongestEdge [(vertex, length)] = (vertex, length)
-- findLongestEdge ((vertex, length):neighbours) = 
--     let (maxVertex, maxLength) = findLongestEdge neighbours
--     in if length > maxLength then (vertex, length)
--        else (maxVertex, maxLength)

-- findLongestPath :: Graf -> (String, [ (String, Int) ]) -> (String, [ (String, Int) ]) -> [ (String, Int) ] -> [ (String, Int) ]
-- findLongestPath graph (startV, startN) (endV, endN) path
--     | trace ("At vertex: " ++ startV ++ " with path: " ++ show path) $ startV == endV = path
--     -- | startV == endV = path
--     | otherwise = 
--         let (longestVertex, length) = findLongestEdge startN
--             newPath = 
--                 if any (\(v, _) -> v == longestVertex) path then error ("Cycle detected at vertex " ++ longestVertex)
--                 else path ++ [(longestVertex, length)]
--             (nextV, nextN) = findVertex graph longestVertex
--         in findLongestPath graph (nextV, nextN) (endV, endN) newPath



-- najit vsechny cesty a potom z nich vybrat tu nejdelsi:

-- vrati vzalenost mezi dvema sousednimi vrcholy (hodnotu hrany)
-- lookupEdge :: Graf -> String -> String -> Maybe Int
lookupEdge :: (Eq a, Num b) => Graf a b -> a -> a -> Maybe b
lookupEdge [] _ _ = Nothing
lookupEdge ((vertex, neighbours):graph) v1 v2
    | vertex == v1 = lookup v2 neighbours
    | otherwise = lookupEdge graph v1 v2 

-- najde delku cesty mezi dvema vrcholy grafu
-- pathLength :: Graf -> [String] -> Int
pathLength :: (Eq a, Num b) => Graf a b -> [a] -> b
pathLength _ [] = 0
pathLength _ [_] = 0
pathLength graph (v1:v2:path) = case lookupEdge graph v1 v2 of
    Nothing -> 0
    Just n -> n + pathLength graph (v2:path)

-- mezi vsemi cestami najde vsechny s danym zacatkem a koncem a jejich delky
-- findPath :: Graf -> String -> String -> [String] -> Maybe ([String], Int)
findPath :: (Eq a, Num b) => Graf a b -> a -> a -> [a] -> Maybe ([a], b)
findPath _ _ _ [] = Nothing
findPath _ _ _ [_] = Nothing
findPath graph start end (v:path)
    | v == start && (last path) == end = Just (v:path, pathLength graph (v:path))
    | otherwise = Nothing

-- vrati jmena sousednich vrcholu zadaneho vrcholu
-- successors :: Graf -> String -> [String]
successors :: (Eq a, Num b) => Graf a b -> a -> [a]
successors [] _ = []
successors ((vertex, neighbours):graph) v = 
    if v == vertex then map fst neighbours
    else successors graph v
    
-- successors2 :: Graf -> String -> [String]
-- successors2 graph node = case lookup node graph of
--     Just neighbors -> map fst neighbors
--     Nothing -> []

-- vygeneruje vsechny cesty z daneho vrcholu do vsech vrcholu.
-- dfs :: Graf -> String -> [String] -> [[String]]
dfs :: (Eq a, Num b) => Graf a b -> a -> [a] -> [[a]]
dfs graph node visited
    | node `elem` visited = []
    | otherwise = [node:path | next <- successors graph node, path <- dfs graph next (node:visited)] ++ [[node]]

-- hlavni funkce pro nalezeni nejdelsi cesty
-- nc :: Graf -> String -> String -> Maybe ([String], Int)
nc :: (Eq a, Ord b, Num b) => Graf a b -> a -> a -> Maybe ([a], b)
nc graph start end = 
    let pathsFromStart = dfs graph start []
        validPaths = [findPath graph start end path | path <- pathsFromStart]
        justValidPaths = [validPath | Just validPath <- validPaths]
    in if null justValidPaths
       then Nothing
       else Just (maximumBy (comparing snd) justValidPaths)


-- d) se zmenenou typovou signaturou nejen u funkce nc, ale i ostatnich pouzitych funkci bude kod fungovat stejne.
--    pro pouziti "comparing" musi byt ve funckci nc definovan typ b i jako typ Ord, ne jen typ Num.

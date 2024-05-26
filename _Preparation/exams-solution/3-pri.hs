-- 18:07 - 18:43

data FQueue a = FQueue [(a,Int)] -- v pořadí od minimální priority
  deriving (Show)

class (Functor q) => PQueue q where
  empty  :: q a
  insert :: (a,Int) -> q a -> q a
  remove :: q a -> ((a,Int), q a)
  merge  :: q a -> q a -> q a

instance Functor FQueue where
  fmap f (FQueue items) = FQueue $ map (\(v,p) -> (f v,p)) items

instance PQueue FQueue where
  empty :: FQueue a
  empty = FQueue []

  insert :: (a, Int) -> FQueue a -> FQueue a
  insert (val,priority) (FQueue items) = -- prostě zařadíme do seznamu podle priority
    let
      first = takeWhile (\(_,p) -> p <= priority) items
      second = dropWhile (\(_,p) -> p <= priority) items
    in FQueue (first ++ [(val,priority)] ++ second)

  remove :: FQueue a -> ((a, Int), FQueue a)
  remove (FQueue []) = undefined
  remove (FQueue (h:other)) = (h, FQueue other)

  merge :: FQueue a -> FQueue a -> FQueue a
  merge (FQueue xs) (FQueue ys) = FQueue (go xs ys)
    where
      go [] ys = ys
      go xs [] = xs
      go ((x,px):xs) ((y,py):ys)
        | px <= py  = (x,px) : go xs ((y,py):ys)
        | otherwise = (y,py) : go ((x,px):xs) ys

instance Foldable FQueue where
  foldr :: (a -> b -> b) -> b -> FQueue a -> b
  foldr f acc (FQueue items) = foldr f acc (map fst items)


import Data.List (minimumBy, maximumBy)
import Data.Ord (comparing)
-- 21:13 - 22:05

data FPole t = Nil | Node (FPole t) (Int,t) (FPole t)
  deriving (Show)

class Foldable m => Pole m where
  make :: [t] -> m t
  get :: m t -> Int -> t
  update :: m t -> Int -> t -> m t


instance Pole FPole where
  make :: [t] -> FPole t
  make xs = go xs 0 (length xs)
    where
      go []  _       _     = Nil
      go [x] fromIdx _     = Node Nil (fromIdx,x) Nil
      go xs  fromIdx toIdx =
        let
          half = (toIdx - fromIdx) `div` 2
          lxs = take half xs
          (v:rxs) = drop half xs
          halfIdx = fromIdx + half
        in Node (go lxs fromIdx halfIdx) (halfIdx,v) (go rxs (halfIdx+1) toIdx)

  get :: FPole t -> Int -> t
  get Nil              idx = undefined
  get (Node l (i,v) r) idx
    | idx == i  = v
    | idx < i   = get l idx
    | otherwise = get r idx

  update :: FPole t -> Int -> t -> FPole t
  update Nil              _   _   = Nil
  update (Node l (i,v) r) idx val
    | idx == i  = Node l (i,val) r
    | idx < i   = Node (update l idx val) (i,v) r
    | otherwise = Node l (i,v) (update r idx val)

flatten Nil = []
flatten (Node l (i,v) r) = flatten l ++ [v] ++ flatten r

instance Foldable FPole where
  foldr :: (a -> b -> b) -> b -> FPole a -> b
  foldr f acc pole = foldr f acc (flatten pole)

instance Functor FPole where
  fmap :: (a -> b) -> FPole a -> FPole b
  fmap f Nil              = Nil
  fmap f (Node l (i,v) r) = Node (fmap f l) (i,f v) (fmap f r)

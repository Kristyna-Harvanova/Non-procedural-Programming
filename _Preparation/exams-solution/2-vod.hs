-- 9:37 - 10:29

-- type Mapa = [ ((Int,Int), [(Int,Int)]) ]
type Mapa a = [ ((a,a), [(a,a)]) ]

-- vytvoří propojení zdrojů
-- zdroje :: Mapa -> [ ((Int,Int), (Int,Int)) ]
zdroje :: (Ord a, Num a) => Mapa a -> [ ((a,a), (a,a)) ]
zdroje mapa = do
  ((x,y), sousede) <- filter (\(xy,_) -> xy /= (0,0)) mapa -- do vodojemu hrany pouze vedou
  let povoleniSousede = filter (\(sx,sy) -> sx <= x && sy <= y) sousede -- splňující podmínku na souřadnice
  return ((x,y), vyberPrimehoSouseda (x,y) povoleniSousede)

  where
    -- vybírá takového povoleného souseda, aby žádný jiný neležel v obdélníku mezi ním a připojovaným zdrojem
    -- vyberPrimehoSouseda :: (Int,Int) -> [(Int,Int)] -> (Int,Int)
    vyberPrimehoSouseda (x,y) [] = error "Nenalezen žádný povolený soused" -- tohle by snad nemělo nastat, pokud je vždy vodojem v sousedech; jinak by tohle mělo vracet (0,0)
    vyberPrimehoSouseda (x,y) (s:sousede) =
      foldr (\(sx,sy) (ax,ay) -> if sx >= ax && sy >= ay then (sx,sy) else (ax,ay)) s sousede -- (sx,sy) je mezi (ax,ay) a (x,y) => vhodnější kandidát

-- d)
-- zdroje :: (Ord a, Num a) => (a -> a -> Ordering) -> Mapa a -> [ ((a,a), (a,a)) ]

import Data.List
import Data.Ord

class TMatice q where
    soucin    :: Num a => q a -> q a -> Maybe (q a)
    submatice :: q a -> (Int,Int) -> (Int,Int) -> Maybe (q a)


data RMatice a = Matica Int Int [((Int, Int), a)] -- Matica (počet riadkov) (počet stĺpcov) [(riadkok, stĺpec, hodnota prvku)] - seznam nenulových prvkov (súradnice, hodnota)
-- indexujeme od 1 do počet_riadkov/počet_stĺpcov

instance TMatice RMatice where
    soucin :: Num a => RMatice a -> RMatice a -> Maybe (RMatice a)
    soucin a@(Matica ra sa as) b@(Matica rb sb bs) 
        | sa /= rb = Nothing -- ak majú matice nesprávne rozmery, vraciame Nothing
        | otherwise = Just (Matica ra sb (concatMatrix (soucin2 as as bs []) []))
        -- ak sú rozmery správne tak vraciame maticu, ktorá má upravené rozmery a zoznam nenulových prvkov
        -- je vhodne upravený
            where
                -- soucin2 pre každý prvok matice A zkontroluje či sa nemôže prenásobiť s 
                -- nejakým prvkom matice B, ak áno, tak ich prenásobíme a a pridáme do výsledku
                -- takto ale nastáva problém, že máme vo výsledku viacero výskytov nenulového prvku
                -- pre jednu súradnicu, a to rieši concatMatrix
                soucin2 _ [] [] zs = zs
                soucin2 yys (x:xs) [] zs = soucin2 yys xs yys zs
                soucin2 yys xx@(((rx, sx), x):xs) yy@(((ry, sy),y):ys) zs
                    | sx == ry = soucin2 yys xx ys (((rx, sy), x * y):zs)
                    | otherwise = soucin2 yys xx ys zs


                -- prejde celý zoznam, a vždy zoberie všetky prvky, ktoré majú rovnaké súradnice, sčíta ich
                -- a vo výsledku zamení za jediný prvok, s rovnakými súradnicami a hodonota je suma predošlých prvkov
                concatMatrix [] result = result
                concatMatrix pp@(((rh, sh), p):ph) result = concatMatrix xsNew r:result
                    where
                        r = ((rh, sh), sum $ map (\(_,x) -> x) (filter (\(r, s) -> (r==rh) && (s==sh)) pp))
                        xsNew = filter (\(r, s) -> (r\=rh) || (s\=sh)) pp


    submatice a@(Matica ra sa xs) (r1, s1) (r2, s2)
        | r1 < 1 || s1 < 1 || r2 > ra || s2 > sa = Nothing
        | otherwise = Just (Matica (r2 - r1 + 1) (s2 - s1 + 1) (filter (\((rx, sx), _) -> (rx >= r1) && (rx <= r2) && (sx >= s1) && (sx <= s2)) xs))
    -- ak sú zadané súradnice submatrixu mimo našej matice, tak vraciame nothing
    -- ak sú súradnice správne, vrátime novú Maticu kde upravíme rozmery a zo zoznamu všetkých nenulových prvkov 
    -- vyfilteujeme tie, čo sú mimo submatice.

instance Show a => Show (RMatice a) where 
    -- predpokladám, že mám zoradené prvky lexikograficky podľa súradníc, ak nemám tak ich ešte tak zoradím, ale už nestíham
    show (Matica 0 _ _) = ""
    -- už nie sú žiadne riadky, tak vrátime prázdny string
    show m@(Matica r s prvky@(((rx,sx),x):xs))= (showR riadok 0 s) ++ "\n" ++ show (Matica (r-1), s, ostatok)
        where 
            riadok = takeWhile (\((rh, sh),_) -> (rh == rx)) prvky
            ostatok = dropWhile (\((rh, sh),_) -> (rh == rx)) prvky
    -- vypíšeme jeden riadok, potom end line, a znovu maticu bez prvého riadku, takto sa rekurzíme, kým nám nedojdu riadky
    -- riadok získavame takewhilom pretože máme lexikograficky zoradené prvky
    -- ostatok získame rovnakou podmienkou ale s dropWhile

            --vypíš riadok
            -- keď dojdu prvky, tak vrátime nuly až do konca riadku
            -- keď ešte máme prvky, vypíšeme nuly až kým sa nedostaneme k prvku, potom vypíšeme prvok a rekurzívne vypíšeme ostatok
            showR [] ss s= show (replicate (s-ss) "0")
            showR (((rx,sx),x):rs) ss s = show (replicate (sx - ss - 1) "0") ++ show x ++ (showR rs sx s)

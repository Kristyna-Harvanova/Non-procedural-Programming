import Data.List
import Data.Ord

type Plane = (Time, Time, Passangers, [Gate], Id)
-- (čas príletu, čas odjazdu, max počet cestujúcich, zoznam bŕan pri ktorých môže zastaviť, Id lietadla)
type Time = Int --čas meraní pre jednosuchosť v iba minútach (upraviteľné na poriadny čas)
type Passangers = Int

type Id = String

data Gate = Gate Id | Plocha 
-- Brána a ID
-- alebo Ploch = záchytná plocha
    deriving (Eq)

alokace :: [Plane] -> [Gate] -> [(Plane, Gate)]
alokace planes gates = alokace_ pls gatess
    where 
        pls = sortBy (comparing (\(x,_,_,_,_) -> x)) planes --zotriedenie poľa pomocou času príletu
        gatess = zip gates (repeat 0) -- ku bránam pridáme aj čas ich uvoľnenia (zo začiatku to je 0)
        
-- prejde cez všekty lietadlá, a každé priradí ku nejakej bráne, keď ku bráne lietadlo priradí
-- tak upravujeme brány, aby sme pri ďaľšom lietadle vedely, že brána je zabraná
alokace_ :: [Plane] -> [(Gate, Time)] -> [(Plane, Gate)]
alokace_ [] _ = []
alokace_ (p:ps) gs = pr:(alokace_ ps gsNew)
    where 
        (pr, gsNew) = alo_plane p gs []

-- alokuje lietadlo ku ku nejakej bráne. prejdeme cez všetky brány 
-- a pri prvej ku ktorej naše lietadlo môže ísť (liatadlo ju má medzi povolenými bránami
-- a zároveň bŕana je voľná) tak k takej ju priradíme
-- pokiaľ žiadna brána nám nevyhovuje, tak liedlo pošleme na záchytnú plochu
alo_plane :: Plane -> [(Gate, Time)] -> [(Gate, Time)] -> ((Plane, Gate), [(Gate, Time)])
alo_plane p [] acum = ((p, Plocha), acum) --poslanie na záchutnú plochu
alo_plane p@(t1, t2, _, gates, _) ((g, t3):gs) acum
    | elem g gates && t1 >= t3 =  ((p, g),(g,t1):(gs++acum)) --podmienka, či je brána vhodná pre lietadlo a voľná
    -- ak bránu pruradíme, tak jej uravujeme čas uvoľnenia
    | otherwise = alo_plane p gs ((g, t3):acum) -- pokiaľ nie je brána vhodná, skúšame ďaľšiu


-- d) Heruistika - problém je podobný problému rozvrhovania prednášok do učební tak aby bol minimálny
-- počet potrebných učební. S tým rozdielom źe tu to máme trochu zobecnené, pretože nie každé lietadlo môže stáť
-- pri akejkoľvek bráne

-- pri učebňiach sa dá nájsť optimum, tak, že prednášky zoradíme podľa začiatku hodiny, 
-- a potom iterujeme prednášky a pridávame ich do voľných učební
-- pridávame učebňu pokiaľ už žiadna nie je voľná

-- A kedže náš problém s lietadlom je podobný, tak som zvolil podobný prístup a zoradil som si lietadlá podľa
-- času príletu, a postupne ich priradím k prvej voľnej a vhodnej bráne kde sa zmestí, a pokiaľ taká nie je
-- tak aź potom lietadlo zaradíme na záchytnú plochu


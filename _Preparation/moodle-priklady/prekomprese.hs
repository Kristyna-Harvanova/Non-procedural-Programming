-- V této úloze budeme programovat zjednodušenou verzi klasické kompresní metody LZ77, která je jádrem řady v praxi používaných formátů jako .zip, .gz, .jar či .png.

-- Naším cílem je sestavit funkci prekomprese, která obdrží textový řetězec, a na výstupu vrátí jeho repreżentaci ve tvaru seznamu trojic (v,d,z).
-- Vstupní řetězec bude v obecném kroku metody rozdělen na dvě části: levou, která již byla komprimována, a dosud nezpracovanou pravou. 
-- Nyní najdeme nejdelší předponu p pravé části, která je podřetězcem levé části, a vrátíme

-- vzdálenost v začátku nalezené předpony v levé části od konce levé části,
-- pokud existuje více takových výskytů, zvolíme v jako nejmenší možnou vzdálenost,
-- délku d nalezené předpony, tj. d=|p|,
-- a znak z, který v pravé části následuje za předponou p.
-- Poté předponu pravé části délky d+1 můžeme považovat za zpracovanou, přesuneme ji tedy z pravé části do levé. Na začátku je levá část prázdná, 
-- na konci je pravá část prázdná. Předpokládejme, že vstup končí znakem '$', který se jinde nevyskytuje.

-- Příklad:

-- > prekomprese "anna_a_anna$"
-- [(0,0,'a'),(0,0,'n'),(1,1,'a'),(0,0,'_'),(2,2,'a'),(7,3,'$')]
-- Ve vašem řešení můžete používat knihovní funkce z naší referenční příručky na Moodle.

import Data.List
import Data.Ord

prekomprese :: String -> [(Int, Int, Char)]
prekomprese = go ""
  where
    go _  [] = []
    go ls rs = case rest of
        []      -> error "prekomprese: internal error"
        r:rest' -> (length ls - offset, len, r):go (ls ++ prefix ++ [r]) rest'
      where
        (offset, len)  = bestPrefix ls rs
        (prefix, rest) = splitAt len rs

    matchLen ls = length . takeWhile id . zipWith (==) ls
    bestPrefix ls rs = maximumBy (comparing snd) . zip [0..] . map (matchLen rs) . tails $ ls
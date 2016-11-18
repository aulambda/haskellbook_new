-- stringExercises.hs
module StringExercises where

exclam :: [Char] -> [Char]
exclam ls = concat [ls, "!"]

index4 :: [a] -> a
index4 ls = ls !! 4

drop9 :: [a] -> [a]
drop9 ls = drop 9 ls

thirdLetter :: [Char] -> Char
thirdLetter str = str !! 3

letterIndex :: Int -> Char
letterIndex i = list !! i
  where
    list = "Curry is awesome"

rvrs :: [Char] -> [Char]
rvrs str = concat [x, y, z]
  where
    x = drop 9 str
    y = take 4 $ drop 5 str
    z = take 5 str

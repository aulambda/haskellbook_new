module Reverse where

rvrs :: [Char] -> [Char]
rvrs str = concat [x, y, z]
  where
    x = drop 9 str
    y = take 4 $ drop 5 str
    z = take 5 str

main :: IO ()
main = print $ rvrs "Curry is awesome"

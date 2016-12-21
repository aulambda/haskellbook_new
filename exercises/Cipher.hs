module Cipher where

import Data.Char

numify :: String -> [Int]
numify = map ord

shiftr
  :: (Ord a, Num a)
  => a -> a
shiftr x =
  case (x + 3) > 122 of
    False -> x + 3
    True -> (x + 3) - 26

stringify :: [Int] -> String
stringify = map chr

caesar :: String -> String
caesar = stringify . map shiftr . numify

shiftl
  :: (Ord a, Num a)
  => a -> a
shiftl x =
  case (x - 3) < 97 of
    False -> (x - 3)
    True -> (x - 3) + 26

unCaesar :: String -> String
unCaesar = stringify . map shiftl . numify

caesarAdj :: String -> Int -> String
caesarAdj string num = stringify $ map inShift $ numify string
  where
    inShift x =
      case (num + x) > 122 of
        False -> (num + x)
        True -> (num + x) - 26

unCaesarAdj :: String -> Int -> String
unCaesarAdj string num = stringify $ map inShift $ numify string
  where
    inShift x =
      case (x - num) < 97 of
        False -> (x - num)
        True -> (x - num) + 26

module Exercises where

isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome x = x == y
  where
    y = reverse x

myAbs :: Integer -> Integer
myAbs num =
  if num >= 0
    then num
  else negate num

f :: (a, b) -> (c, d) -> ((b, d), (a, c))
f first second = ((snd first, snd second), (fst first, fst second))

a = (+)
add1 xs = a w 1
  where w = length xs

identity :: a -> a
identity i = i

return1 (z : zs) = z

myFst (a, b) = a

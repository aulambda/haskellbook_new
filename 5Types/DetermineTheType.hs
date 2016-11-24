{-# LANGUAGE NoMonomorphismRestriction #-}

module DeterimineTheType where

exampleA = (* 9) 6
exampleB = head [(0, "doge"), (1, "kitteh")]
exampleC = head [(0 :: Integer, "doge"), (1, "kitteh")]
exampleD = if False then True else False
exampleE = length [1, 2, 3, 4, 5]
exampleF = (length [1, 2, 3, 4, 5]) > (length "tacocat")

bigNum = (^) 5
wahoo = bigNum $ 10



functionH :: [a] -> a
functionH (x:_) = x

functionC :: (Ord a) => a -> a -> Bool
functionC x y = if (x > y) then True else False

functionS :: (a, b) -> b
functionS (x, y) = y

myFunc :: (x -> y)
       -> (y -> z)
       -> c
       -> (a, x)
       -> (a, z)
myFunc xToY yToZ _ (a, x) = (a, (yToZ (xToY x)))

i :: a -> a
i x = x

c :: a -> b -> a
c x y = x

c'' :: b -> a -> b
c'' x y = x

c' :: a -> b -> b
c' x y = y

f :: [a] -> [a]
f ls = reverse ls

co :: (b -> c)
   -> (a -> b)
   -> a
   -> c
co bc ab val = bc (ab val)

a :: (a -> c)
  -> a
  -> a
a f val = val

a' :: (a -> b) -> a -> b
a' func val = func val
         

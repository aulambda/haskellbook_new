module Exercises where

-- not :: Bool -> Bool
-- length :: [a] -> Int
-- concat :: [[a]] -> [a]
-- head :: [a] -> a
-- (<) :: (Ord a) => a -> a -> Bool

addStuff :: Integer -> Integer -> Integer
addStuff a b = a + b + 5

nonsense :: Bool -> Integer
nonsense True = 805
nonsense False = 31337

-- the functions below are identical
curriedFunction :: Integer -> Bool -> Integer
curriedFunction i b = i + (nonsense b)

uncurriedFunction :: (Integer, Bool) -> Integer
uncurriedFunction (i, b) = i + (nonsense b)
anonymous :: Integer -> Bool -> Integer
anonymous = \i b -> i + (nonsense b)

anonNested :: Integer -> Bool -> Integer
anonNested = \i -> \b -> i + (nonsense b)

-- only possible implementations of  (a -> a -> a) are
-- (f a b = a) and (f a b = b)

f :: (Num b) => a -> b -> b
f a b = b + 1
  

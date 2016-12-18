module ChapterNine where

{- Exercises for Chapter 9, "Lists" of Haskell Programming from First Principles by Julie Moronuki and Chris Allen
   Solutions by Gerald Aulandez, December 2016
   Please use if you find them useful, check out #haskell-beginners on IRC or slack for any help you need. My readme.md
   for this repo also links to some good repos to check out for other approaches to solving the exercises.
-}

-- 9.3 Pattern Matching on Lists

myTail :: [a] -> [a]
myTail [] = []
myTail (_:xs) = xs

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:[]) = Nothing
safeTail (_:xs) = Just xs

safeHead :: [a] -> Maybe [a]
safeHead [] = Nothing
safeHead (x:_) = Just [x]

-- 9.5 EnumFromTo
etfBool :: Bool -> Bool -> [Bool]
etfBool False True = [False, True]
etfBool True _ = [True]
etfBool False _ = [False]

etfOrd :: Ordering -> Ordering -> [Ordering]
etfOrd start stop
  | start < stop = start : etfOrd (succ start) stop
  | start == stop = [stop]
  | start > stop = []

etfInt :: Int -> Int -> [Int]
etfInt from to
  | from < to = from : etfInt (succ from) to
  | from == to = [to]
  | from > to = []

etfChar :: Char -> Char -> [Char]
etfChar beginning ending
  | beginning < ending = beginning : etfChar (succ beginning) ending
  | beginning == ending = [ending]
  | beginning > ending = []

-- 9.6 Thy Fearful Symmetry
myWords :: String -> [String]
myWords [] = []
myWords string =
  let cond x = x /= ' '
  in (takeWhile (cond) string) : (myWords (drop 1 (dropWhile (cond) string)))

firstSen = "Tyger Tyger, burning bright\n"
secondSen = "In the forests of the night\n"
thirdSen = "What immortal hand or eye\n"
fourthSen = "Could frame thy fearful symmetry?"

sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines [] = []
myLines (x:xs)
  | x == '\n' = myLines xs
  | otherwise = takeWhile (/= '\n') (x:xs) : myLines (dropWhile (/= '\n') (x:xs))

-- myBreak :: (Char -> Bool) -> String -> [String]
-- myBreak _ [] = []
-- myBreak cond (x:xs)
    -- | otherwise = takeWhile cond (x:xs) : myBreak cond (dropWhile cond (x:xs))

-- 9.7 List Comprehensions
-- [x^2 | x <- [1..10], rem x 2 ==0]
--  1     2     3         4
-- 1 -> do this to all x
-- 2 -> all x
-- 3 -> all x from this list
-- 4 -> all x from list 3 that evaulate to true in this predicate function

mySqr = [x^2 | x <- [1..5]]

comp1 = [x | x <- mySqr, rem x 2 == 0] -- [4,16]
comp2 = [(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50] -- []
comp3 = take 5 [(x, y) | x <- mySqr, y <- mySqr, x < 50, y > 50] -- []

myString xs = [x | x <- xs, elem x "aeiou"]

myCube = [y^3 | y <- [1..5]]

myTuple = [(x, y) | x <- mySqr, y <- myCube]

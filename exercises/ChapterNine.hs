module ChapterNine where

import Data.Bool
import Data.Char

{- Exercises for Chapter 9, "Lists" of Haskell Programming from First Principles by Julie Moronuki and Chris Allen
   Solutions by Gerald Aulandez, December 2016
   Please use if you find them useful, check out #haskell-beginners on IRC or slack for any help you need. My readme.md
   for this repo also links to some good repos to check out for other approaches to solving the exercises.

   Formatted with Hindent, some of the formatting that Hindent comes up with can
   be a bit counter intuitive to newbies to Haskell unfortunately. If any multiline
   statements look weird to you, just ignore the line breaks and think of them as one
   continous statement.
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

etfChar :: Char -> Char -> String
etfChar beginning ending
  | beginning < ending = beginning : etfChar (succ beginning) ending
  | beginning == ending = [ending]
  | beginning > ending = []

-- 9.6 Thy Fearful Symmetry
myWords :: String -> [String]
myWords [] = []
myWords string =
  let cond x = x /= ' '
  in (takeWhile cond string) : (myWords (drop 1 (dropWhile cond string)))

firstSen = "Tyger Tyger, burning bright\n"

secondSen = "In the forests of the night\n"

thirdSen = "What immortal hand or eye\n"

fourthSen = "Could frame thy fearful symmetry?"

sentences = firstSen ++ secondSen ++ thirdSen ++ fourthSen

myLines :: String -> [String]
myLines [] = []
myLines (x:xs)
  | x == '\n' = myLines xs
  | otherwise =
    takeWhile (/= '\n') (x : xs) : myLines (dropWhile (/= '\n') (x : xs))

-- | otherwise = takeWhile cond (x:xs) : myBreak cond (dropWhile cond (x:xs))
-- myBreak :: (Char -> Bool) -> String -> [String]
-- myBreak _ [] = []
-- myBreak cond (x:xs)
-- 9.7 List Comprehensions
-- [x^2 | x <- [1..10], rem x 2 ==0]
--  1     2     3         4
-- 1 -> do this to all x
-- 2 -> all x
-- 3 -> all x from this list
-- 4 -> all x from list 3 that evaulate to true in this predicate function
mySqr =
  [ x ^ 2
  | x <- [1 .. 5] ]

comp1 =
  [ x
  | x <- mySqr 
  , rem x 2 == 0 -- [4,16]
    ]

comp2 =
  [ (x, y)
  | x <- mySqr 
  , y <- mySqr 
  , x < 50 
  , y > 50 -- []
    ]

comp3 =
  take
    5
    [ (x, y)
    | x <- mySqr 
    , y <- mySqr 
    , x < 50 
    , y > 50 -- []
      ]

myString xs =
  [ x
  | x <- xs 
  , elem x "aeiou" ]

myCube =
  [ y ^ 3
  | y <- [1 .. 5] ]

myTuple =
  [ (x, y)
  | x <- mySqr 
  , y <- myCube ]

myTupleLessThan50 =
  [ (x, y)
  | x <- mySqr 
  , y <- myCube 
  , x < 50 
  , y < 50 ]

tupleListLength = length myTupleLessThan50

{-
Normal Form: No more evaluation is possible
 Weak Head Normal Form: Evaluated as much as possible without a data constructor or a lambda being fully filled in. Anything in normal form is automatically in WHNF, not neccesarily the other way around. Square rectangle.

    (1, 2) -- WHNF & NF
    (1, 1 + 1) -- WHNF
    "Papu" ++ "chon" -- neither
    (1, "Papu" ++ chon") - WHNF
-}
length' :: [a] -> Int
length' [] = 0
length' (_:xs) = 1 + length xs

mySum
  :: Num a
  => [a] -> a
mySum [] = 0
mySum (x:xs) = x + mySum xs

-- 9.8 Nonstrictness and List Evaluation
{-
1. [1, 2, 3, 4, 5] -- NF, WHNF
2. 1 : 2 : 3 : 4 : _ -- WHNF
3. enumFromTo 1 10 -- Neither
4. length [1, 2, 3, 4, 5] -- Neither
5. sum (enumFrom 1 10) -- Neither
6. ['a'..'m'] ++ ['n'..'z'] -- Neither
7. (_, 'b') -- WHNF
-}
-- 9.9 Transforming Lists of Values
ifMap =
  map $
  \x ->
     if x == 3
       then (-x)
       else x

myIfMap = map $ \x -> bool x (-x) (x == 3)

-- 9.10 Filtering Lists of Values
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' pred (x:xs)
  | pred x = x : filter' pred xs
  | otherwise = filter' pred xs

filter3s = filter (\x -> rem x 3 == 0) [1 .. 30]

comp3s =
  [ x
  | x <- [1 .. 30] 
  , rem x 3 == 0 ]

filterLength = length filter3s

divFilter divBy = filter (\x -> rem x divBy == 0)

countDivBy divBy = length . divFilter divBy

myFilter xs =
  [ x
  | x <- words xs 
  , notElem x ["the", "a", "The", "A"] ]

-- 9.11 Zipping Lists
myZip :: [a] -> [b] -> [(a, b)]
myZip [] _ = []
myZip _ [] = []
myZip (x:xs) (y:ys) = (x, y) : myZip xs ys

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

-- 9.12 Chapter Exercises
capitalizeFst :: String -> String
capitalizeFst string = toUpper (head string) : tail string

capitalizeAll :: String -> String
capitalizeAll [] = []
capitalizeAll (x:xs) = toUpper x : capitalizeAll xs

capitalizeAllMap :: String -> String
capitalizeAllMap = map toUpper

capitalizeFstOnly :: String -> Char
capitalizeFstOnly = toUpper . head

myOr :: [Bool] -> Bool
myOr [] = False
myOr (x:xs) =
  if x
    then True
    else myOr xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny _ [] = False
myAny f (x:xs) =
  if f x
    then True
    else myAny f xs

myElem
  :: Eq a
  => a -> [a] -> Bool
myElem _ [] = False
myElem i (x:xs) =
  if i == x
    then True
    else myElem i xs

myElem'
  :: Eq a
  => a -> [a] -> Bool
myElem' x = myAny (== x)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

squish :: [[a]] -> [a]
squish [] = []
squish (x:xs) = x ++ squish xs

squishMap :: (a -> [b]) -> [a] -> [b]
squishMap _ [] = []
squishMap f (x:xs) = f x ++ squishMap f xs

squishAgain :: [[a]] -> [a]
squishAgain [] = []
squishAgain ls  = squishMap id ls 

myMaximumBy :: (a -> a -> Ordering) -> [a] -> a
myMaximumBy _ [] = undefined
myMaximumBy _ [x] = x
myMaximumBy f (x:y:ys) =
  case f x y of
    GT -> myMaximumBy f (x : ys)
    EQ -> myMaximumBy f (x : ys)
    LT -> myMaximumBy f (y : ys)

myMinimumBy :: (a -> a -> Ordering) -> [a] -> a
myMinimumBy _ [] = undefined
myMinimumBy _ [x] = x
myMinimumBy f (x:y:ys) =
  case f x y of
    LT -> myMinimumBy f (x : ys)
    EQ -> myMinimumBy f (x : ys)
    GT -> myMinimumBy f (y : ys)

myMaximum
  :: Ord a
  => [a] -> a
myMaximum = myMaximumBy compare

myMinimum
  :: (Ord a)
  => [a] -> a
myMinimum = myMinimumBy compare

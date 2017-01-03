
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module ChapterEleven where

import Data.Char

{-
   Exercises for Chapter 11, "Algebraic Datatypes" of Haskell Programming from First Principles by Julie Moronuki and Chris Allen
   Solutions by Gerald Aulandez, December 2016
   Please use if you find them useful, check out #haskell-beginners on IRC or slack for any help you need. My readme.md
   for this repo also links to some good repos to check out for other approaches to solving the exercises.

   Formatted with Hindent, some of the formatting that Hindent comes up with can
   be a bit counter intuitive to newbies to Haskell unfortunately. If any multiline
   statements look weird to you, just ignore the line breaks and think of (setq powerline-default-separator 'arrow)) them as one
   continous statement.
-}

-- 11.5 Data Constructors and Values

data PugType =
  PugData

data HuskyType a =
  HuskyData

data DogueDeBordeaux doge =
  DogueDeBordeaux doge

data Doggies a
  = Husky a
  | Mastiff a
  deriving (Eq, Show)

{-

1. Doggies is a type constructors
2. * -> *
3. *
4. Num a => Doggies a
5. Doggies Integer
6. Doggies [Char]
7. Both
8. doge -> DogueDeBordeaux doge
9. DogueDeBordeaux [Char]

-}

-- 11.6 What's a type and what's data?

data Price
  = Price Integer
  deriving (Eq, Show)

data Manufacturer
  = Mini
  | Mazda
  | Tata
  deriving (Eq, Show)

data Airline
  = PapuAir
  | CatapultsR'Us
  | TakeYourChancesUnited
  deriving (Eq, Show)

data Size
  = Size Integer
  deriving (Eq, Show)

data Vehicle
  = Car Manufacturer Price
  | Plane Airline Size
  deriving (Eq, Show)

myCar = Car Mini (Price 14000)

urCar = Car Mazda (Price 20000)

clownCar = Car Tata (Price 7000)

doge = Plane PapuAir (Size 500)-- 1. The type of myCar is Vehicle

isCar ::Vehicle -> Bool
isCar (Car _ _) = True
isCar _ = False

isPlane :: Vehicle -> Bool
isPlane vehicle =
  case vehicle of
    Plane _ _-> True
    _ -> False

areCars :: [Vehicle] -> [Bool]
areCars = map isCar

getManu :: Vehicle -> Manufacturer
getManu vehicle =
  case vehicle of
    Car x _ -> x
    Plane _ _-> undefined

safeGetManu :: Vehicle -> Maybe Manufacturer
safeGetManu vehicle =
  case vehicle of
    Car x _ -> Just x
    Plane _ _-> Nothing

-- 11.8 What makes thes datatypes algebraic?

{-
1. PugType has a cardinality of 1
2. Airline has a cardinality of 3
3. Int18 has a cardinality of 65536
4. Int has a limited cardinality, but Integer has no bounds
-}

data Example = MakeExample deriving Show

{-
1. The type of MakeExample is Example. You cant
   query the type of Example because it is not a
   data constructor.
2. Show is defined for Example
3. Int -> Example'
-}

data Example' = MakeExample' Int deriving Show

class TooMany a where
  tooMany :: a -> Bool

instance TooMany Int where
  tooMany n = n > 42

newtype Goats = Goats Int deriving (Eq, Show, TooMany)

newtype IntString = IntString (Int, String) deriving (Eq, Show)

instance TooMany IntString where
  tooMany (IntString (x, y)) = x > 42

instance TooMany (Int, String) where
  tooMany (x, y) = x > 42

instance TooMany (Int, Int) where
  tooMany (x, y) = (x + y) > 42

instance (Num a, TooMany a) => TooMany (a, a) where
  tooMany (x, y) = tooMany (x + y)

-- 11.10 Sum Types
{-
1. 4
2 258
-}

-- 11.11 Product types

-- data Person = MkPerson String Int deriving (Eq, Show)

-- jm = MkPerson "julie" 108
-- ca = MkPerson "chris" 16

-- namae :: Person -> String
-- namae (MkPerson s _) = s

data Person =
  Person { name :: String
         , age :: Int
         }
  deriving (Eq, Show)

jm = Person "Julie" 108
ca = Person "Chris" 16

-- 11.12 Normal form

data Fiction = Fiction deriving Show
data Nonfiction = Nonfiction deriving Show

data BookType
  = FictionBook Fiction
  | NonfictionBook Nonfiction
  deriving Show

type AuthorName = String

-- data Author = Fiction Authorname
--             | Nonfiction Authorname
--             deriving (Eq, Show)

{- The normal form of Garden is
data Garden
  = Gardener Gardenia
  | Gardener Daisy
(..)
-}

-- 11.13 Constructing and deconstructing values

data GuessWhat = Chickenbutt deriving (Eq, Show)

data Id a = MkId a deriving (Eq, Show)

data Product a b = Product a b deriving (Eq, Show)

data Sum a b
 = First a
 | Second b
 deriving (Eq, Show)

data RecordProduct a b =
  RecordProcuct { pfirst :: a
                , psecond :: b
                }
  deriving (Eq, Show)

newtype NumCow = NumCow Int deriving (Eq, Show)

newtype NumPig = NumPig Int deriving (Eq, Show)

-- Farmhouse and Farmhouse' are functionally equivalent
data Farmhouse = Farmhouse NumCow NumPig deriving (Eq, Show)

type Farmhouse' = Product NumCow NumPig

newtype NumSheep = NumSheep Int deriving (Eq, Show)

-- Bigfarmhouse and BigFarmhouse' are functionally equivalent
data BigFarmhouse = BigFarmhouse NumCow NumPig NumSheep
  deriving (Eq, Show)

type BigFarmhouse' = Product NumCow (Product NumPig NumSheep)

type Name = String

type Age = Int

type LovesMud = Bool

type PoundsOfWool = Int

data CowInfo =
  CowInfo Name Age
  deriving (Eq, Show)

data PigInfo =
  PigInfo Name Age LovesMud
  deriving (Eq, Show)

data SheepInfo =
  SheepInfo Name Age PoundsOfWool
  deriving (Eq, Show)

-- Animal and Animal' are functionally equivalent
data Animal
  = Cow CowInfo
  | Pig PigInfo
  | Sheep SheepInfo
  deriving (Eq, Show)

type Animal' =
  Sum CowInfo (Sum PigInfo SheepInfo)

trivialValue :: GuessWhat
trivialValue = Chickenbutt

data OperatingSystem
  = Linux
  | BSD
  | Mac
  | Windows
  deriving (Eq, Show)

data ProgrammingLanguage
  = Haskell
  | Agda
  | Idris
  | PureScript
  deriving (Eq, Show)

data Programmer = Programmer { os :: OperatingSystem
                             , lang :: ProgrammingLanguage
                        }
             deriving (Eq, Show)

allOperatingSystems :: [OperatingSystem]
allOperatingSystems = [ Linux
                      , BSD
                      , Mac
                      , Windows
                      ]

allLanguages :: [ProgrammingLanguage]
allLanguages = [Haskell, Agda, Idris, PureScript]

allProgrammers :: [Programmer]
allProgrammers = [Programmer x y | x <- allOperatingSystems, y <- allLanguages]

-- 11.14 Function type is exponential

{-
1. 16
2. 16
3. 256
4. 8
5. 16
6. 65536
-}

-- 11.15 Higher-kinded datatypes

hello = Chickenbutt


-- 11.17 Binary Trees

data BinaryTree a
  = Leaf
  | Node (BinaryTree a) a (BinaryTree a)
  deriving (Eq, Ord, Show)

insert' :: Ord a => a -> BinaryTree a -> BinaryTree a
insert' b Leaf = Node Leaf b Leaf
insert' b (Node left a right)
  | b == a = Node left a right
  | b < a  = Node (insert' b left) a right
  | b > a = Node left a (insert' b right)

-- Write map for BinaryTree

mapTree :: (a -> b) -> BinaryTree a -> BinaryTree b
mapTree _ Leaf = Leaf
mapTree f (Node left a right) =
  Node (mapTree f left) (f a) (mapTree f right)

testTree' :: BinaryTree Integer
testTree' =
  Node (Node Leaf 3 Leaf) 1 (Node Leaf 4 Leaf)

mapExpected =
  Node (Node Leaf 4 Leaf) 2 (Node Leaf 5 Leaf)

mapOkay =
  if mapTree (+1) testTree' == mapExpected
  then print "yup okay!"
  else error "test failed!"

-- Convert binary trees to lists

preorder :: BinaryTree a -> [a]
preorder Leaf = []
preorder (Node left a right) = a : preorder left ++ preorder right

inorder :: BinaryTree a -> [a]
inorder Leaf = []
inorder (Node left a right) = preorder left ++ [a] ++ preorder right

postorder :: BinaryTree a -> [a]
postorder Leaf = []
postorder (Node left a right) = preorder left ++ preorder right ++ [a]

testTree :: BinaryTree Integer
testTree = Node (Node Leaf 1 Leaf) 2 (Node Leaf 3 Leaf)

testPreorder :: IO ()
testPreorder =
  if preorder testTree == [2, 1, 3]
  then putStrLn "Preorder fine!"
  else putStrLn "Bad news bears!"

testInorder :: IO ()
testInorder =
  if inorder testTree == [1, 2, 3]
  then putStrLn "Inorder fine!"
  else putStrLn "Bad news bears."

testPostorder :: IO ()
testPostorder =
  if  postorder testTree == [1, 3, 2]
  then putStrLn "Postorder fine!"
  else putStrLn "Bad news bears!"


-- 11.18 Chapter Exercises

{-
1. Weekday is a type with five data constructors 
2. f :: Weekday -> [String]
3. Must begin with a capital letter
4. Delivers the final element of xs
-}


doubleUp :: [a] -> [a]
doubleUp [] = []
doubleUp xs@(x : _) = x : xs

-- isSubsequenceOf ::(Eq a) => [a] -> [a] -> Bool
isSubsequenceOf [] _ = True
isSubsequenceOf _ [] = False
isSubsequenceOf a@(x:xs) b@(y:ys)
  | x == y = True && isSubsequenceOf xs ys
  | otherwise = isSubsequenceOf a ys

capitalizeWord :: String -> String
capitalizeWord "" = ""
capitalizeWord (x:xs) = toUpper x : xs

capitalizeWords :: String -> [(String, String)]
capitalizeWords =  map (\x -> (x, (capitalizeWord x))) . words 

capitalizeParagraph :: String -> String
capitalizeParagraph [] = []
capitalizeParagraph (x:y:xs)
  | x == '.' && y == ' ' = '.' : ' ' : capitalizeParagraph (capitalizeWord xs) 
  | otherwise = toUpper x : y : capitalizeParagraph xs

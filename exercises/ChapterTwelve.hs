module ChapterTwelve where

{-
   Exercises for Chapter 12, "Signaling Adversity" of Haskell Programming from First Principles by Julie Moronuki and Chris Allen
   Solutions by Gerald Aulandez, December 2016
   Please use if you find them useful, check out #haskell-beginners on IRC or slack for any help you need. My readme.md
   for this repo also links to some good repos to check out for other approaches to solving the exercises.

   Formatted with Hindent, some of the formatting that Hindent comes up with can
   be a bit counter intuitive to newbies to Haskell unfortunately. If any multiline
   statements look weird to you, just ignore the line breaks and think of (setq powerline-default-separator 'arrow)) them as one
   continous statement.
-}
ifEvenAdd2 :: Integer -> Maybe Integer
ifEvenAdd2 n =
  if even n
    then Just (n + 2)
    else Nothing

type Name = String

type Age = Integer

type ValidatePerson a = Either [PersonInvalid] a

data Person =
  Person Name
         Age
  deriving (Show)

data PersonInvalid
  = NameEmpty
  | AgeToLow
  deriving (Eq, Show)

ageOkay :: Age -> Either [PersonInvalid] Age
ageOkay age =
  case age >= 0 of
    True -> Right age
    False -> Left [AgeToLow]

nameOkay :: Name -> Either [PersonInvalid] Name
nameOkay name =
  case name /= "" of
    True -> Right name
    False -> Left [NameEmpty]

mkPerson :: Name -> Age -> ValidatePerson Person
mkPerson name age = mkPerson' (nameOkay name) (ageOkay age)

mkPerson' :: ValidatePerson Name -> ValidatePerson Age -> ValidatePerson Person
mkPerson' (Right nameOk) (Right ageOk) = Right (Person nameOk ageOk)
mkPerson' (Left badName) (Left badAge) = Left (badName ++ badAge)
mkPerson' (Left badName) _ = Left badName
mkPerson' _ (Left badAge) = Left badAge

safeTail :: [a] -> Maybe [a]
safeTail [] = Nothing
safeTail (x:[]) = Nothing
safeTail (_:xs) = Just xs

-- 12.5 Chapter Exercises

{-
1. *
2. * -> *
-}

notThe :: String -> Maybe String
notThe str
  | str == "the" = Nothing
  | otherwise = Just str
 
replaceThe :: String -> String
replaceThe = unwords . map unMaybe . map notThe . words 
  where
    unMaybe Nothing = "a"
    unMaybe (Just a) = a


vowels = "aeiou"

vowelInitial str@(x:xs) = undefined

countTheBeforeVowel :: String -> Integer
countTheBeforeVowel = undefined


countVowels :: String -> Integer
countVowels = undefined
 

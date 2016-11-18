module GreetIfCool1 where

greetIfCool :: String -> IO ()
greetIfCool coolness =
  if cool
    then putStrLn "eyy. What's shakin'?"
  else
    putStrLn "pssh."
  where cool = coolness == "downright frosty yo"

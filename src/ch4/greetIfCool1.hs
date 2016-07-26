module GreetIfCool1 where

greetIfCool :: String -> IO ()
greetIfCool coolness =
  if cool
    then putStrLn "eyyy, wht's shkin'?"
  else
    putStrLn "pshhh."
  where cool = coolness == "downright frosty yo"

--
-- How to read: I take an Integer argument and return a function that
-- takes an Integer and returns an Integer
--
addStuff :: Integer -> Integer -> Integer
addStuff a b = a + b + 5

--
-- With explicit parenthese
--
addStuff2 :: Integer -> (Integer -> Integer)
addStuff2 a b = a + b + 5


funcIgnoresArgs :: a -> a -> a -> String
funcIgnoresArgs x y z = "Blah"


--
-- currying vs. uncurrying
--
nonsense :: Bool -> Integer
nonsense True = 805
nonsense False = 31337

typicalCurriedFunction :: Integer
                        -> Bool
                        -> Integer
typicalCurriedFunction i b =
  i + (nonsense b)

uncurriedFunction :: (Integer, Bool)
                  -> Integer
uncurriedFunction (i, b) =
  i + (nonsense b)

anonymous :: Integer -> Bool -> Integer
anonymous = \i b -> i + (nonsense b)

anonymousAndManuallyNested :: Integer -> Bool -> Integer
anonymousAndManuallyNested = \i -> \b -> i + (nonsense b)

--
-- Currying and uncurrying existing functions
--


-- Exercise: Mood Swing
--
-- stack ghci
-- :load mood-swing.hs
--
data Mood = Blah | Woot deriving Show

changeMood :: Mood -> Mood
changeMood _ = Woot
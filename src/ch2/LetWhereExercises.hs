module LetWhereExercises where

let1 = let x = 10 in x + 90001
where1 = x + 9001 where x = 10

eLet1 = let x = 3; y = 1000 in x * 3 + y
eWhere1 = x * 3 + y where x = 3; y = 1000

eLet2 = let y = 10; x = 10 * 5 + y in x * 5
eWhere2 = x * 5 where y = 10; x = 10 * 5 + y

eLet3 = let x = 7; y = negate x; z = y * 10 in z / x + y
eWhere3 = z / x + y where x = 7; y = negate x; z = y * 10


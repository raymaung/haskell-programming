# Chpater 3 Strings

## 3.1 Printing Strings

## 3.2 A first look at types

* Types are a wat if categorizing values
    * Integers
    * Fractional numbers
    * `True` and `False`
    * `Char` and `String`
        * `String` is a list of *characters*
* `:type 'a'` to find out the type
    * returns `'a' :: Char`
    * `'a'` - single quote tells Haskell, it is not variable
    * `::` reads *has the type* 
* `:type 'a'` reads as *what is the type of 'a'?*
* `'a' :: Char` reads as *'a' has the type of Char*

### Printing Simple Things

* `print "hello world!"`
    * `print` tells GHCi to print the string to the display.
* `putStrLn "hello world"` and `putStr "hello world"`
    * `putStrLn` and `putStr` are similar to each other with one key difference
    * Both print the string to the display without quotation marks
    * *superficially* similar to `print` but differnt type than `print` does

* `main` function is the default function when you build an executable and run it in a REPL
* Has the type `IO ()`
    *  Printing to the screen is a side-effect so printing the output of a module must be wrapped in this `IO` type

### String Concatenation

* Concatenation or to *concatenate* something means to *link together*
* Linera sequences such as lists or strings of text

> `:m` to return to `Prelude`


### Global versus local definitions

```
module GlobalLocal where

topLevelFunction :: Integer -> Integer
topLevelFunction x = x + woot + topLevelValue
  where woot :: Integer
        woot = 10

topLevelValue :: Integer
topLevelValue = 5
```

* `topLevelFunction` or `topLevelValue` can be imported to another module
* `let` and `where` introduce local bindings or declarations
    * to bind or declare something means to give an expression a name
* `woot` is effectively invisible outside of `topLevelFunction`
    * we are explicitly declared the type of `woot` but not necessary
        * Haskell type inference would've figured out fine.

## 3.4 Type signatures of concatenation functions

* `(++)` vs. `concat`
    * `(++)` is an infix operator
    * `concat` is a normal (not infix) function
* `(++)` has the type `[a] -> [a] -> [a]`
* `concat` has the type `[[a]] -> [a]`

* `:t concat` returns `Foldable t => t [a] -> [a]`
    * `Fodable t` can be thought as another like `Foldable t => t [a]`
    * 
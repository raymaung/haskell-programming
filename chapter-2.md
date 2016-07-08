# Chapter 2 - Hello Haskell

* [https://github.com/bitemyapp/learnhaskell](https://github.com/bitemyapp/learnhaskell)

## Installation
* [http://docs.haskellstack.org/en/stable/install_and_upgrade/#mac-os-x](http://docs.haskellstack.org/en/stable/install_and_upgrade/#mac-os-x)
    * `brew install haskell-stack`

## Running

```
stack ghci
:load ch2.hs
```

## 2.2 Interacting with Haskell Code

### Using the REPL

* `:quit` or `:q` to quit the REPL
* `:info` or `:i` for info

### Saving scripts and loading them

* `*.hs` haskell source file
* `:load test.hs` to load the source in the REPL

    ```
    sayHello :: String -> IO ()
    sayHello x = putStrLn ("Hello, " ++ x ++ "!") 
    ```
* `sayHello :: String -> IO ()` reads as
    * `::` reads as *has-a-type-signature*
        * `sayHello` *has a type* `String -> IO ()`

## 2.3 Understanding expressions

* Everything in Haselll is an expression or declaration
* Expressions evaluate to a result
    * for *literals*, it evaluates to itself

* *Normal Form*: expressions are in *normal form* whn there are no more evaluation steps
    * i.e when they've reached an irreducible form
    * the normal form of `1 + 1` is `2`
* *redexes*: Reducible expression expression; referred to as *reduction*, or *normalizing* or *executing* an expression


## 2.4 Functions

* *Functions* are a specific type of expression
* Functions (as in Mathematics) maps an input or set of inputs to an out put
* A function is an expression that is applied to an argument (or parameter) and always returns a result
* They always revaluate to the same result when given the same values

* As in the lambda calculus, all functions in Haskell take *one* argument and return *one result*.
    * when it seems we are passing multiple arguments to a functions, we are actually applying a series of nested functions, each to one argument
    * aka *currying*


### Defining functions

* start with the name of hte function
* followed by the formal arguments or parameters of the function separated only by white space
* `=` equal sign
* and expression

* Defining functions in a normal Haskell source code file and in *GHCi* are a little different.
    * In *GHCi*, you must use `let`
        * `let triple x = x * 3`
    * In source file
        * `triple x = x * 3`
            * `triple` the function name - notice all lower case
            * `x` argument to the function, the arguments correspond to the *head* of a lambda
            * `=` is used to defined or *declare* - it is not expressing *equality*
            * `x * 3` the function body

**Capitalization matters!**
* Names for modules and names of types such as `Integer` start with a capital letter, they can also be `CamelCase` for multiple word names
* Function names start with lower case letters, they can be in `camelBack` for multiple words
* Variables are lower case


### Evaluating functions

* In a pure functional language like Haskell, we can replace applications of functions with their definitions and get the same result

* `triple 2` is equivalent
    * `(triple x = x * 3) 2`
        * `(triple 2 = 2 * 3)`
            * `2 * 3`
                * `6`
* Expression `triple 2` is in canonical or *normal form* when it reaches the number `6` because the value `6` has no remaining reducible expressions

> `:m` is short for `:module`

### Conventions for variables

* Type variables general start at `a`, then `b`, `c` and so son
    * or `a1`, `a2` and etc.
* Functions can be used as arguments and typically labeled variables starting at `f` then `g` and so on
    * sometimes, `f1`, `f2`
    * sometime `f'`, read *eff-prime*
        * usually denotes a functions that is closely related to or a helper function function `f`
    * may also be given variable names that are not on this spectrum as mnemonic
* Arguments to functions are most given names starting at `x`, or `x1`  
    * mnemonic role, ie `r` for role
* If you have alist of thins you have named `x`, will usually e called `xs`, the pural of `x`
    * `(x:xs)` means you have a list of which the head of the list is `x` and the rest of the list is `xs`

### Intermission: Exercises

## 2.5 Infix operators

* Functions in Haskell default to prefix syntax
    * the function being applied at the beginner of the expression rather than the middle
*  Arithmetic operators are infix functions
*  Operators are functions which can be used in infix style
*  All operators are functions; not all functions are operators
*  `triple`, `id` are prefix functions and the `+` is an infix operator
*  You can sometimes use functions in an infix or prefix style with a small change in syntax
    *  `10 ``div`` 4` vs. `div 10 4`

### Associativity and precedence

* There's a default associativity and precedence to the infix operators `(*)`, `(+)`, and `(-)` and `(/)`
* You can asked *GHCi* for information such as associativity and precedency of operations functions using `:info` command
    * `:info (+)`
    ```
    *Main> :info (+) (-)
    class Num a where
      (+) :: a -> a -> a
      ...
      	-- Defined in ‘GHC.Num’
    infixl 6 +
    ```
    * `infixl` means infix operator left associative
    * `6` is the precedence - higher is applied first on a scale of 0-9

* `infixl` means the operator associates to the left
    * `2 * 3 * 4` => `(2 * 3) * 4`
* `infixr` means a right associative infix operator

## 2.6 Declaring values
 
* In GHCi `let x = 10`
* In source file `x = 10`

```
module Learn where-- First, we declare the name of our module so
-- it can be imported by name in a project.
-- We won't be doing a project of this size
-- for a while yet.x = 10 * 5 + y
myResult = x * 5
y = 10
```

### Troubleshooting

* Indentation of Haskell code is significant
* Uses spaces, not tab
* Whitespace is significant
* Whitespace is often the only mark of a function call
    * unless parentheses are necessary due to conflicting precedence.
* Trailing whitespaces are consider bad style

```
-- Valid
let
  x = 3
  y = 4

let x = 3
    y = 4
    
-- Invalid
let x = 3
  y = 4

let
  x = 3
    y = 4
```

* Multi-parts expression example
```
foo x =
    let y = x * 2
        z = x ^ 2
    in 2 * y * z
```
* Note: the definitions of `y` and `z` line up
* the definitions of `let` and `in` are also aligned

```
-- Error
x = 10
* 5 + y

-- Valid
x = 10
    * 5 + y

-- Valid - but not recommended
x = 10
  * 5 + y
```

* All declarations within a module must start in is determined by the first declaration in the module
    * Good style to start at the leftmost margin


## 2.7 Arithmetic functions in Haskell

## 2.8 Negative numbers

* Due to the interaction of parentheses, currying and infix syntax, negative numbers get special treatments In Haskell
* The negation of numbers in Haskell by the user of a unary `-` is a form of *syntactic sugar*
    * `2000 + (-123)`
        * `-` is translated into `negate` 
        * Equivalent to `2000 + (negate 123)`
    * `2000 - 123`
        * `-` is used for substration

## 2.9 Parenthesizing infix functions

* If infix function is `>>`, then you must write `(>>)` to refer to it as a value
    * `(+)` is the addition infix function without any arguments applied yet
    * `(+1)` is the same addition function but with one argument applied
        * also know as *sectioning*; allow to passs around partially applied functions
    * `1 + 2`
    * `(+) 1 2`
    * `(+1) 2`

* If the sectioning with a function is not *commutative*, the order matters
    * `(1/) 2` returns `0.5`
    * `(/1) 2` return `2.0` 

* Special case for `(-)`
    * `(-) 2 1` returns `1`
    * `(-2) 1` won't work as the value inside the parentheses with the `-` indicates that itis the argument of a function because `-` represents ngation

```
let x = 5
let y = (1 - )
y x
```
* Not immediately obvious but this syntax is used throught the book

## 2.10 Laws for quotients and remainders

## 2.11 Evaluation

* Haskell uses a *non-strict* evaluation - sometime called *lazy evaluation*


## 2.12 `Let` and `where`

```
module FunctionWithWhere where

printInc n = print plusTwo
  where plusTwo = n + 2
```
* Using `where`


```
module FunctionWithLet where

printInc2 n = let plusTwo = n + 2  in print plusTwo
```
* Same function, but using `let`
* `let` followed by `in` is a `let` expression

### Defining multiple let examples

`let x = 3; y = 4 in x * y`

```
mult1 = x * y
  where x = 5
        y = 6
```

### The lambdas beneath `let` expressions

* Anonymous function syntax in Haskell uses a backslash
    * `(\x -> x) 0` returns 0
    * `(\x -> x) 1` returns 1
    * `let id x = x`
    * `let id = \x -> x`

* `let a = b in c` is equivalent to
    * `(\a -> c) b`
* `let x = 10 in x + 9001` is equivalent to
    * `(\x -> x + 90001) 10`
* `c where a = b` is equivalent to
    * `(\a -> c) b`
* `x + 9001 where x = 10`  is 
    * `(\x -> x + 9001) 10`
* `add = x + y` is equivalent to 
    * `add = (\x y = x + y)`


¡### More Exercises

```
-- Exercise 1
eLet1 = let x = 3; y = 1000 in x * 3 + y
eWhere1 = x * 3 + y where x = 3; y = 1000

-- Exercise 2
eLet2 = let y = 10; x = 10 * 5 + y in x * 5
eWhere2 = x * 5 where y = 10; x = 10 * 5 + y

-- Exercise 3
eLet3 = let x = 7; y = negate x; z = y * 10 in z / x + y
eWhere3 = z / x + y where x = 7; y = negate x; z = y * 10

```

### Parenthesization

```
:info (^)
:info (*)
:info (-)
:info ($)
```

#### `($)` Operator

* Does almost nothing
* Reads as *evaluate everything to the right of me first*
* `f $ a = f a`
* `(2^) $ 2 + 2` returns `16`
* `(2^) (2 + 2)` returns `16`
* `(2^) 2 + 2` returns `16`

* `(2^) $ (+2) $ 3 * 2` returns `256`
    * Evaluate `3 * 2` first; that's `6`
    * Then `(+2) 6`; that's `8`
    * Then `(2^) 8` that's `256`
    * 

* `(2^) $ 2 + 2 $ (*30)` won't works, here is why
    * Evaluate everything right of after first `$` that's is `2 + 2 $ (*30)`
        * there is another `$`, evaluate everyting right after `$`, that's `(*30)`
        * then `(2 + 2) (*30)`
        * then `4 (*30)`
            * `4 (*30)` makes no sense, we can't apply `4` as if it was a function to the argument `(*30)`

* `(2^) $ (*30) $ 2+2` works
    * Reduce `(*30) $ 2+2` first
        * Reduce `2 + 2` returns `4`
    * `(*30) 4` returns `120`
* Then 1
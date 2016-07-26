# Chapter 4 Basic datatypes

## 4.1 Basic Datatypes

Types are a power means of classifying, organizing and delimiting.

* Standard Built-In Datatypes
    * numbers
    * characters
    * lists of characters

### Covers

* Review types
* Lean about datatypes, type constructors and data constructors
* work with predefined datypes
* learn more about type signatures and a bit about type classes

## 4.2 Anatomy of a data declaration

* Data declarations are how datatypes are defined

### Type Constrctor

    * type signatures - type level of your code
    * the name of the type
    * is *capitalized*

### Data Constructors

* the values that inhabit the type defined in
* the values show up in your code the term level instead of of the type level
    * *term level* means the values as they appear in the code
        * the values that your code evaluates to

### Starting with Basic


```
data Bool = False | True
```

* *data declaration*
    * `Bool` Type constructor for data type `Bool`
    * `False` value
    * `|` indicates logical disjunction, *or*; so a `Bool` value is `True` *or* `False`
    * `True` value

* Not always follow the same pattern
    * Some uses logical conjunction *and* instead of disjunction
    * Some type/data constructor may be arguments

* the common thing is the keyword `data`
    * followed by the type constructor.
    * `=` the equal sign denotes a definition
    * the data constructors.

### Querying Type Information for `not` function

```
> :t not
not :: Bool -> Bool
```

* Take `Bool` and returns another `Bool`
* Type signature makes reference to the type constructor or datatype name


* When we use the `not` function, we use the data constructors or values in our code.

### Exercise Mood Swing

```
data Mood = Blah | Woot deriving Show
```

* What is type constructor? `Mood`
* Possible values? `Blah`, `Woot deriving Show`
* What's wrong with `changeMood :: Mood -> Woot`?
    * `Woot` is data and invalid to appear in the function signature
* What's wrong with `changeMood Mood = Woot`
    * `Mood` is a type constructor - invalid to appear as argument


## 4.3 Numeric types

* Haskell does not just use one type of number

### Integral numbers

* whole numbers, positive, negatives
* `Int` fixed-precision integer
    * by **fixed* it has a range with max and min
* `Integer` also integers but arbitrarily large/small numbers

### Fractional

* Not *Integers*
* `Float`
    * single-precision floating point number
* `Double`
    * double-precision floating point number
* `Rational`
    * a fractional number represents a ratio of two integers
    * carry two `Integer` values; numerator and denominator
    * arbitrarily precise but not as efficient as `Scientific`
* `Scientific`
    * space efficient 
    * almost arbitrary precision scientific number type
    * represented by scientific notation
    * Store the coefficient as an `Integer` and exponent as `Int`

### `Num`

* All numeric datatypes all have instances of a type class called `Num`
* a type class for which most numeric types will have
    * there are standard functions that are covenient to have for all types of numbers
* Provide `(+)`, `(-)` and `(*)`

## Integral numbers

* Numbers are whole numbers with no fractional component


## Integer

* Positive/Negative whole numbers
* Extends in either direction

## Why do we have `Int`

* Artifact of what computer hardware has supported natively
* Related types `Int8`, `Int16`
* Cannot express arbitrarily large in the positive/negative sense


```
import GHC.Int
127 :: Int8
```

* `128 :: Int8` fails
* `(127 + 1) :: Int8` produces `-128`
    * `127` and `1` are within range
    * `(127 + 1)` overflow and resets back to its smallest numeric value
* `minBound :: Int8` returns `-128`
* `maxBound :: Int8` returns `127`
* These functions are from the type class `Bounded` and they will work to tell you the limitations of possible values

## Fractional Numbers

* `Float`, `Double`, `Rational`, and `Scientific`.
* `Rational`, `Double`, and `Float` come with your install of GHC
* `Scientific` comes from a library
* You almost never want `Float` unless you are doing graphics programming such as with OpenGL

* `:t (/)` returns `(/) :: Fractional a => a -> a -> a`
    * `Fractional a =>` reads *the type variable `a` must implement the `Fractional` type class*

### `Fractional`

* is a type class that requires types to already have an instance of the `Num` typeclass
* `Num` is a super class of `Fractional`
* `(+)` and other functions from the `Num` can be used with `Fractional`
* But not functions from `Fractional` be used with all types that have a `Num` instance

## 4.4 Comparing Values

* `==` reads as *is equal to*
* `/=` reads as *is not equal to* 
* `:t (==)`
    * returns `(==) :: Eq a => a -> a -> Bool`
* `:t (<)` 
    * returns `(<) :: Ord a => a -> a -> Bool` 

### `Eq`

* is a type class that can be compared and determined to be equal in value

### `Ord`

* is a type class that includes all things that can be ordered

> `Eq` and `Ord` are *not* limited to numbers
> Can be any values that can be said to have equal value or can be ordered

### Examples

* `'a' == 'a'`
    * `True`
* `'a' < 'b'` 
    * `True`
* `"Julie" == "Chris"`
    * `False`

* `['a', 'b'] > ['b', 'a']`
* `[Blah, Woot] > [Woot, Blah]`
    * Fail 
    * Datatype that has no instance of `Ord` will not work

## Go on and Bool me

* `Bool`
    * standard type
    * a sum type with two constructor
    * sum type means *or* or logical disjunction
* Six categories of entities that have names
    * variable constructor
    * data constructor
    *  type variables
    *  type constructores
    *  type classes
    *  modules

> term-level is where your values live
> type-level is used during the static analysis and verification of your program

### `data Bool = False | True`

* creates a datatype with the type constructor `Bool`
* Use type constructor `Bool` in type signatures
* `Bool` type constructor doesn't take argument
    * some type constructors do
* the definition of `Bool` also create two data constructors
    * `True` and `False`
        * both have type `Bool`
    * Any function that accepts `Bool` must allow for the possibility of `True` or `False`

> You cannot specify the type that should only accept one specific value

* Reads as *the datatype `Bool` is represented by the values `True` or `False`

## Conditionals with if-then-else

* Haskell doesn't have `if` statements
    * it has *if expressions*
* Built-in syntax that works with the Bool datatype
* `if True then "Truthin" else "Falsin"`

> Structure here is 
> *if CONDITION then EXPRESSION_A else EXPRESSION_B

## 4.5 Tuples

* a type that allows to store and pass around multiple values within a single value
* distinctive, built-in syntax used at both type and term levels
* Each tuple has a fixed number of constituents
* two-tuple or pair
* Aritys
* Most tuples sees 5-tuples or smaller

### Examples

* `fst :: (a, b) -> a`
* `snd :: (a, b) -> b`

## 4.6 Lists

* Type to contain multiple values within a single value
* Differ from *Tuples* in three ways
    * all constituents of a List must be of the same type
    * Lists have their own distinct `[]` syntax
        * Like *tuples*, it is used for both the type constructor in type signatures and at the term level to express lst values
    * the number of constituents within a list can change unlike *tuple*

```
> let awesome = [ "abc", "xyz", ":)" ]
> :t awesome
:: [[Char]]
```
* `awesome` is a list of lists `Char`
    * a string is *alias* for `[Char]`

```
> let awesome = ["Papuchon", "curry", ":)"]
> let alsoAwesome = ["Quake", "The Simons"] 
> awesome ++ alsoAwesome

[["Papuchon","curry",":)"],["Quake","The Simons"]]
 
```
* `:t (++)` returns `(++) :: [a] -> [a] -> [a]` 
* `:t concat` returns `concat :: [[a]] -> [a]`

## 4.8 Definitions

* *tuple*
    * an ordered grouping of values
    * a zero tuple is called *unit* or `()`
    * the usual means of expressing an anonymous product
* *typeclass*
    * a set of operations defined with respect to a polymorphic type
    * type classes are unique pairings of class and concrete instance
        *  ifa given type `a` has an instance of `Eq` it has only one instance of `Eq`
* *Data constructors*
    * a means of creating values of that inhabit a given type
    * Data constructors in Haskell have a type and can either be constant values *nullary) or take one or more arguments just like functions
    
    ```
    -- Why name a cat? They don't answer anyway
    type Name = String
    
    data Pet = Cat | Dog Name
    ```   
    * `Cat` is a nullary data constructor for `Pet`
    * `Dog` is a data constructor that takes an argument
* *Type constructors*
    * are *not* values - can only used in type signatures
    * just as data declarations generate data constructors to create values that inhabit that type, data declarations generate *type constructors* which can be used to denote that type.
    * the above example `Pet` is type constructor
    * Unlike Data Constructor, *type constructors* always go to the left of the `=` in a data declaration

* *Data Declarations*
    * define new datatypes
    * always create a new type constructor
    * *may or may not* create a new data constructors
    * how we refer to the entire definition that begins with the `data` keyword
* *type alias*
    * a way to refer to a type constructor or type constant by an alternate naem
    * to communite something more specific or for brevity

    ```
    type Name = String
    -- creates a new type alias Name of the type String
    -- *not* a data declaration,
    -- just a type alias declaration
    ``` 
* *Arity*
    * the number of arguments a function accepts
    * a little slippery in Haskell as, due to currying.
        * all functions are *1-arity* and we handle accepting multiple arguments by nesting functions
* *Polymorphism*
    * Being able to write code in terms of values which may be one of several or any type
    * Either *parametric* or *constrained*
        * `id` idenitty function, is an example of a parametrically polymorphic function

        ```
        id :: a -> a
        id x = x
        ```
        
        * `id` works for any value of any type - it doesn't use any information specific to a given type or set of types


        ```
        isEqual :: Eq => a -> a -> Bool
        isEqual x y = x == y
        ```
        
        * the above is *polymorphic* but *constrained* or *bounded* to the set of types which have an instance of the `Eq` type class.
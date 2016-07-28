# Chapte 5 - Types

## 5.1 Types

* Play important role in the readability, safey and maintainability
* Learn more about querying and reading type signatures
* see that currying has, unforunately nothing to do with food
* take a closer look at different kinds of polymorphism
* look at type inference and how to declare types for our functions

## 5.2 What are types?

* Every value has a type
* Types are how we group a set values together that share something in common
* A specific model of a particular concept or domain
* In Haskell, you cannot create untyped data

> Strong typing means that we are guranteed not to have certain sorts of errors in our code - if a function expects an integral, you must pass in integral.

> Static typing means that the types are known to the compiler and checked for mismaches or type errors at compile time.

> type inference - the compiler will infer the types for expressions that have no declared type.

## 5.3 Querying and Reading Types

```
> :type 't'
't' :: Char   -- 't' has the type Char

> :type "julie"
"julie" :: [Char] -- "julie" has the type String
```

```
> :type 13
13 :: Num a => a
```
* When you query the types of numeric values, we see type class information becaue the compiler doesn't know which specific numeric type a value is until the type is either declared or the compiler is forced to infer.


```
> :type not
not :: Bool -> Bool
```


```
> :info (->)
data (->) a b
```
* `->` is the type constructor for functions in Haskell
* syntatically it works in very much the same way
* `(->)` type constructor takes arguments and has no data constructors
* Since it has no data constructors, the value of type `(->)` that shows up at term-level is the function, *Functions are values*

```
> :info (,)
data (,) a b = (,) a b
```

```
fst :: (a, b) ->  a
--       [1]  [2] [3]
```
* Argument to `fst`, as the type `(a, b)`
    * the tuple type itself `(,)` takes two arguments `a` and `b` here
* The function type `(->)` has two parameters
    * One is `(a, b)`
    * one is the result `a`
* the result of the function which as type `a` it's the same `a` that was in the tuple `(a, b)`

## 5.4 Typeclass constrained type variables

```
> :type (+)
(+) :: Num a => a -> a -> a
```
* addition takes one numeric argument, adds it to a second numeric argument of the same type and returns a numeric value of the same type as result
* `Num` is a typeclasses, not concret types
* Each type classes offers a standard set of functions that can be used across several concrete types.
* When a type class is constraining a type variable in this way, the variable could represent any of the concrete types that have instances of that type

> *constrained* becasued we don't know the concrete type, but we do know it can only be one of the types that has a `Num` instance

```
> let fifteen = 15
> let fifteenInt = fifteen :: Int
```
* Casting to `Int`

```
(Ord a, Num a) => a -> Ordering
```
* A type signature might have multiple type class constraints on one or more of the variables.
* the constraints look like a tuple but they don't add another function argument that you must provide and they don't appeara as a tuple at the value or term level. they don't represent a product or conjunction of constraints.
* the example has two constraints

## 5.5 Currying

 * All functions in Haskell take one argument and return one result
     * no no support for multiple arguments
     * Just syntactic conveniences that construct curried functions by default

```
(+) :: Num a => a -> a -> a
--    |  [1]  | [2]     | [3]
```

1. Type class constraint saying that a must have an instance of `Num`
2. Looks like two arguments, but in Haskell, functions are nested like Matryoshka dolls
    * `(->)` is the type constructor for functions
    * `a -> a -> a` represents successive function applications
        * each taking one argument and returing one result
        * the function at the outer most layer is actually returing *another function* that accepts the next argument; it is called *currying*
3. the result type for this function.

> when `a -> a -> a` is parenthesized, it is equivalent to `a -> (a -> a)`
> *application is evalutation*

```
addStuff :: Integer -> Integer -> Integer
addStuff a b = a + b + 5
```
* `addStuff` appears to take two `Integer` arguments and returns `Integer` result

### Binding variables to types

```
> funcIgnoresArgs :: a -> a -> a -> String
> funcIgnoresArgs x y z = "Blah"

> :t funcIgnoresArgs (1 :: Integer)
funcIgnoresArgs :: a -> a -> a -> String

> :t funcIgnoresArgs (1 :: Integer)
funcIgnoresArgs (1 :: Integer) :: Integer -> Integer -> String

```
* `undefined` can pretend to be any type
    * `:t undefined` returns `undefined :: t`

### Manual currying and Uncurry

* Haskell is curried by default but you can uncurry functions
* *Uncurrying* means un-nesting the functions and replacing the two functions with a tuple of two values
* If you uncurry `(+)`, the type changes
    * from `Num a => a -> a -> a`
    * to `Num a => (a, a) -> a`
    * reads as *takes two arguments, returns one result*

> Uncurried functions: One function, many arguments
> Curried functions: Many functions, one argument apiece

### Currying and uncurrying existing functions

* Currying

    ```
    > let curry f a b = f (a,b)
    > :t curry
    curry :: ( (t1,t2) -> t ) -> t1 -> t2 -> t
    
    > :t fst
    fst :: (a, b) -> a
    
    > :t curry fst
    curry fst :: t -> b -> t
    
    > fst (1, 2)
    1
    
    > curry fst 1 2
    1
    ```
* Uncurrying

    ```
    > let uncurry f (a, b) = f a b
    > :t uncurry
    uncurry :: (t1 -> t2 -> t) -> (t1, t2) -> t
    
    > :t (+)
    (+) :: Num a => a -> a -> a
    
    > (+) 1 2
    3
    
    > uncurry (+) (1, 2)
    3
    ```  
    
## 5.6 Polymorphism

* *poly* means *many*
* *morph* means *form*
* *ic* suffix in polymorphic means *of*

* Polymorphic type variables give us the ability to implement expressions that can accept arguments and return results of different types without having to write variations
* Haskell Prelude are polymorphic by default

> Type signatures may have three kinds of types:
> *concret*, *constrained polymorphic* or *parametrically polymorphic*

### Polymorphic

* Two categories
    * parametric polymorphism
    * constrained polymorphism

If you've encountered polymorphism beore, it was probably a form of constrained, often called *ad-hoc* polymorphism

> *ad-hoc* polymorphism in Hasktll is implemented with typeclasses

#### Parametric Polymorphism

* broader than ad-hoc polymorphism
* Refers to type variables or *parameters* that are fully polymorphic
* When unconstrained by a typeclass, their funal concrete type could be anything.
* Constrained polymorphism, puts typeclass constrained on the variable, decreasing the number of concrete types it could be, but increasing as a set of operations

```
id :: a ->
-- For all 'a', get an argument of some type 'a',
-- return value of same type 'a'

> let inc = (+1)
> inc 2
3

> (id inc) 2
3
```

* Based on the type of `id`, we are guranteed this behavior
* `a` in the type signature cannot change because the type variable gets fixed to a concrete type
* If one applies `id` to a value of type `Int`, the `a` is fixed to type `Int`
* By default, type variables are resolved at the left-most part of the type signature and are fixed once sufficient information to bind them to a concrete type is available

> the arguments in parametrically polymorphic functions like `id` 
> are more restricted because there are no methods attached
>  to its parameter at all
> 
> On the other hand, a function like `negate` with `Num a => a -> a` signature,
> `a` must be a an instance of the `Num`, then `a` has fewer concrete types but
> there are a set of methods you can use, a set of things that can be done with `a`

* If a type is a set of possible values, then a type variable represents a set of possible types.
* When there is no type class constraint, the set of possible types a variable could represent is effectively unlimited
* Type class constraints limit the set of potential types (thus, potential values)


* Conscrete types have even more flexibility in terms of computation - this has to do with additive nature of type classes for one thing
    * for example, `Int` is only an `Int` but it can make use of the methods of the `Num` *and* `Integral` type classes.

* If a variable could be *anything*, then there's little that can be done to it because it has no methods.
* If a variable can be *some* types (ie. `Num`), then it has some methods.
* If a variable is a *concrete* type, you lose type flexibility but gamin more potential methods

> Type Inheritance extends downward from a super class (ie. `Num`) to
> subclasses (ie `Integral`) then `Int` but not the other way around.
> 
> A subclass cannot override the methods of its super class

* A function is polymorphic when its type signature has variables that can represent more than one type
    * its parameters are polymorphic
* Parametric polymorphism refers to fully polymorphic (unconstrained by a typeclass) parameters.
* Parametrcity is the property we get from having parametric polymorphism.
    * *Parametricity* means that the behavior of a function with respect to the types of its (parametrically polymorphic) arguments is uniform.
    * the behavior can not change just because it was applied to an argument of a different type.


### Polymorphic constants

```
> (-10) + 6.3
-3.7

> :t (-10) + 6.3
(-10) + 6.3 :: Fractional a => a

> :t (-10)
(-10) :: Num a => a
```

* Numeric literal like `10` and `6.3` are polymorphic and stay so until given a more specific type
* We can force the compiler to be more specific about the types of numbers by declaring the type
    ```
    > let x = 5 + 5
    > :t x
    x :: Num a => a
    
    > let x = 5 + 5 :: Int
    > :t x
    x :: Int
    ```

### Working around constraints

```
> 6 / length [1, 2, 3]
No instance for (Fractional Int) arising
from a use of ‘/’
In the expression: 6 / length [1, 2, 3]In an equation for ‘it’: it = 6 / length [1, 2, 3]
```

* the problem is `length` isn't polymorphic enough
* `Fractional` includes serveral types of numbers but `Int` isn't one of them.
* Haskel provides `fromIntegral` that takes an integral value and forces it to implement Num type class

    ```
    > :type fromIntegral
    fromIntegral :: (Num b, Integral a) => a -> b
    ```

    * it takes a vlue `a` of an `Integral` type and returns it as a value `b` of any `Num` type

## 5.7 Type inference

* Haskell doesn't require to asser a type for every expression or value
    * it has *type inference*
* *Damas-Hindley-Milner* type system
* Essentially, the compiler starts from the values who types it knows then works out the types of the other values

## 5.8 Asserting types for declarations

* Most of the type, we want to declare our types
* Adding type signatures to your code can provie guidance
* Also help compiler
* Possible to declare types locally with `let` and `where`

    ```
    triple x = tripleItYo x where tripleItYo :: Integer -> Integer
                tripleItYo y = y * 3     
    ```
* Worth remembering that GHC will pickup and propagate type information for inference from applications of functions, sub-expressions, definitions almost anywhere

* There *are* constraints on our ability to declare types
    * `letx=5+5::String` results in error, can't force to return `String` 

## 5.10 Definitions

* *Polymorphism* refers to type variables which may refer to more than one concrete type
    * *parametric* or *add-hoc* polymorphism
    * By having a larger set of types, we intersect the commonalities of them all to produce a smaller set of correct terms
* *Principal type* is the most generic type which will type checks
    * a property of the type system 
    * Principal typing holds for that type system if a type can be found for a term in an environment for which all other types for that terms are instances of the principal type

    ```
    -- Given the inferred types
    a
    Num a => a
    Int
    
    -- the principal type here is
    -- the parametrically polymorphic 'a'
    
    -- 
    (Ord a, Num a) => a
    Integer
    
    -- the principal type is
    -- (Ord a, Num a) => a
    ```    

* *Type inference* is to *infer* principal types from terms without needing explicit type annotations.
    * there are some cases, terms in Haskell which can be well-typed but which have no principal type. In those cases, an explicit type annotation must be added
* *Type variable* is a way to refer to an unspecified type or a set of types in Haskell type signature
* *Type class* is a means of expressing faculties or interfaces that multiple data types may have in common.
* *Parametricity* is the properyt that oholds in the presence of parametric polymorphism. Parametricity states that the behavior of a function will be uniform across all concret applications of the function.
* *Ad-hoc polymorphism* sometime called *constrained polymorphism* is polymorphism that applices one or more typeclass constraints to what would've otherwise been a parametrically polymorphic type variable.
* 
    











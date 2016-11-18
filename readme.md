# Haskell Programming from First Principles
*Book by Julie Moronuki and Chris Allen
Notes by @aulambda*
October 2016

The [last time](https://github.com/aulambda/haskellbook/commits?author=aulambda) I started working through this book I left off around chapter 10. It was so fun and gratifying, but other things got in the way and I ended up pausing for a few months. Felt the urge to pick it back up today so I'm going to try and start learning again. I'm reviewing the first 8 chapters by taking notes and solving *most* of the exercises again, and then I'll start in earnest going through the chapters fully @ chapter 9.


## 1 Lambda Calculus
* Functional Programming
  : Programming focused on the combination of expressions, particularly functions. Expressions can be values, variable, or functions.
* Functions
  : Expressions that are applied to an argument or input and evaluated to return a result. The result isn't an action that the function does, but rather the true value of the function, the process of moving from a stated function to the final expression that expresses the value of the function is called *reduction* or *evaluation* A function is a relation between a set of possible inputs and possible outputs.
* Purity
  : Referential transparency. A pure function, given the same values, will always return the same result, no concept of *state*.

* Alpha equivalence
  : The sense in which functions represented with different variable that still perform the same action are actually the same function.
  * Examples of equivalent functions:

    ```
    λx.x
    λy.y
    λq.q
    ```
* Beta reduction
  : Evaluating a function with an argument by substituting the argument for any bound variables in the function declaraction.
  * Examples:
    ```
    (λx.x)2
    -> 2

    (λx.x + 4)4
    -> 4

    (λx.x + 4)27
    -> 31

    (λx.x)(λy.y)z
    ```
* Functions that require multiple arguments have multiple, nested heads.
  * Examples:
  ```
  λx.(λy.xy) = λxy.xy

  λxy.xy
  -> (λxy.xy)1 2
  -> (λx(λy.xy))1 2
  -> (λ[x := 1].(λx.xy))2
  -> (λy.1y) 2
  -> (λ [y := 2].1y)2
  -> 1 2
  ```




## 2 Hello Haskell
### Arithmetic
* + : Addition
* - : Subtraction
* * : Multiplication
* / : Fractional Division
* div : Integer division, rounded down
* rem : Remainder after Division
* quot : Integral division, rounded towards zero
* mod : N

## 3 Strings
### List Operations
* : : cons, adds to the front of a list
* head list : returns the first item of a list
* tail list : returns the list with the first item chopped off
* take x list : returns x number of elements from list
* drop x list : chops x number of elements off list and returns remainder
* (++) list1 list2 : merges two lists
* (!!) list x : returns the element of list at *index* x
* concat [list1, list2] : merges list1 and list2

## 4 Basic Datatypes
* Type Constructors : Names of a type, capitalized, express a set of values.
* Data Constructors : The possible values of a type
  *
  ```haskell
  -- a type constructor followed by two data constructors
  data Bool = False | True

  -- examples of how constructors are used in type and term level code
  input :: Bool -> Bool
  input True = False
  input False = True
  ```
## 5 Types

## 6 Typeclasses
## 7 Functions
## 8 Recursion
## 9 Lists
## 10 Folds
## 11 Algebraic datatypes
## 12 Signaling Adversity
## 13 Building projects in Haskell
## 14 Testing
## 15 Monoid, Semigroup
## 16 Functors
## 17 Applicative
## 18 Monad (SPOOKY? No.)
## 19 Abstract structure applied
## 20 Foldable
## 21 Traversable
## 22 Reader
## 23 State
## 24 Parsers
## 25 Composing Types
## 26 Monad Transformers
## 27 Non-strictness
## 28 Commonly used data structures
## 29 Demystifying IO
## 30 Exceptions
## 31 Final Project

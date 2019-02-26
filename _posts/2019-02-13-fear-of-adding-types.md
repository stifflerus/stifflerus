---
layout: post
title: "Fear of Adding Types: Model too big, model too small"
---

- existing antipatterns of "fear of adding classes" and "fear of adding tables"
- propose a new antipatter called "fear of adding types" or "fear of adding models" or "mega model"
- asdf

# Models the wrong size
A problem arises when the set of values that are valid for your type is a different
size than the set of values that are logically valid for your problem domain. This
can occur in two ways:

## Model Too Small
In *model too small*, the model space is smaller than the domain space. This means that the model does not cover all of the possible use cases in the problem domain. Some of the possible use cases are not representable in the model space.

### Example
Imagine a problem domain consisting of pets. Let us consider only cats and dogs for this example. Both cats and dogs share the common property of having a name. Cats have a property called `hasMeow` and dogs have a property called `hasWoof`.

An example of a model that is too small might look like this:
~~~ haskell
data Pet = Pet { name :: String, hasWoof :: Bool }
~~~

This model does well with representing a dog, but it falls short when it tries to represent a cat. A developer trying to remedy this shortcoming might designate that `hasWoof = False` to represent a cat. However, this actually makes things worse. In our problem domain, it is entirely possible for a dog to have `hasWoof = False` (perhaps the dog is mute). So, by reusing the property `hasWoof` in this way, the developer has eliminated the ability to distinguish between cats and dogs. Consider the following `Pet` instance:
``` haskell
Pet { name = "snowball", hasWoof = False }
```
Is this `Pet` a cat or a dog? Since the model space is smaller than the domain space, there must be either collisions in representation (ambiguous values), or domain values that are unrepresentable entirely.

### Typical Symptoms
In this example we see many of the typical symptoms of *model too small*
- Resuse of properties for more than one purpose
- Use of sentinel values to represent special conditions
- Difficult or impossible to distinguish between subtypes or special conditions

From a model that is too small, we can improve by extending the model to cover the missing use cases. Of course, care must be taken not to extend the model so much that it becomes a *model too big*.

## Model Too Big
In *model too big*, the model space is bigger than the domain space. This means that there are values in the model space which are not valid in the domain space.

### Example
Reconsidering our problem domain of cats and dogs, a model that is too big might look like this:
~~~ haskell
data Pet = Pet { name :: String, hasWoof :: Maybe Bool, hasMeow :: Maybe Bool }
~~~

This model has no problems representing both cats and dogs. Unlike in the *model too small* example, it is easy to tell a cat from a dog. Cats have `hasWoof = Nothing` and dogs have `hasMeow = Nothing`. It is possible to represent dogs with `hasWoof = False`, and cats with `hasMeow = False` unambiguously. These were the cases that were missing from the *model too small* example. However, too large a model presents another problem. It is possible to represent in the model values that are not valid in the domain.

~~~ haskell
Pet { name = "catdog", hasWoof = True, hasMeow = True }

Pet { name = "datcog", hasWoof = Nothing, hasMeow = Nothing }
~~~

### Typical Symptoms
- Many unrelated properties combined into one model ("melting pot model")
- Many or most properties are unnecessarily optional in the model
- Implicit rules for which optional properties are expected to be defined
  - "if property A is defined, then property B will also be defined"
  - "Either property A or property B will be defined"

## Model Just Right
The solution to this problem is to ensure that the model space matches the domain space as closely as possible.  From a model that is too big, we can improve by identifying distinct uses cases. Decompose the big model into many smaller models, one for each use case. Then, combine the models together into a sum type. Good languages should have direct support for sum types, but they can be used in languages that don't, by using tagged unions.

~~~ haskell
data Pet = Cat { name :: String, hasMeow :: Bool }
         | Dog { name :: String, hasWoof :: Bool }
~~~

# Exceptions
Some logical constraints cannot be encoded into standard type systems without introducing dependent types. Dependent types are a type system where type can depend on values, rather than depending only on other types. Dependent types allow the type system to encoded first-order logic properties, such as "a pair of integers where the first is greater than the second". There is virtually no support for dependent types in popular programming languages. Only research and experimental languages like Idris, Coq, et. al. support dependent types. We are not able to encode all first-order domain logic into models using non-dependent programming languages. For this reason, this article is about the failure to encode zeroeth-order domain logic (that which can be expressed using non-depedent types) into models.

# Common Rebuttals
- Fear or misunderstanding of sum types
- Perception that a singular big model is simpler than the sum of many smaller models, depsite the fact that a "too big" model contains implicit (and often undocumented) domain logic that many smaller models can encode in to the type system.
- Model too big is more common than model too small
- Big models tend to disperse validations logic throughout the program, wherever there is code that deals with the model. This is because many of the domain logic invariants that could be guaranteed by a smaller, more specific model are lacking in the big model. This means the invariants have to be checked anywhere the model is used.

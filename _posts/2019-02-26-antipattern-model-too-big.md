---
layout: post
title: "Antipattern: Model Too Big, Model Too Small"
---

The goal of any model is to create a logical system that can be used to simulate the behavior of a system (the problem domain). The properties, rules, and behaviors of interest in the problem domain should be reproduced in the model as closely as possible. In computer programming, models are created by defining types. Types are really a way of defining a set of values, so by creating a model, what is really happening is we are defining a set of values. In order for the model to most closely match the problem domain, we should strive for the model space to exactly equal the domain space.

A problem arises when the set of values that are valid in our model are different in size than the set of values that are valid in our problem domain. This can occur in two ways.

## Model Too Small
In *model too small*, the model space is smaller than the domain space. This means that the model does not cover all of the possible use cases in the problem domain. Some of the possible use cases are not representable in the model space.

### Example
Imagine a problem domain consisting of pets. Let us consider only cats and dogs for this example. Both cats and dogs share the common property of having a name. Cats have a property called `hasMeow` and dogs have a property called `hasWoof`.

An example of a model that is too small might look like this:
~~~ haskell
data Pet = Pet { name :: String, hasWoof :: Bool }
~~~

This model does well with representing a dog, but it falls short when it tries to represent a cat. A developer trying to remedy this shortcoming might designate that `hasWoof = False` to represent a cat. However, this actually makes things worse. In our problem domain, it is entirely possible for a dog to have `hasWoof = False` (perhaps the dog is mute). So, by reusing the property `hasWoof`, the developer has eliminated the ability to distinguish between cats and dogs. Consider the following `Pet` instance:
``` haskell
Pet { name = "snowball", hasWoof = False }
```
Is this `Pet` a cat or a dog? There is no way to distinguish between a cat and a dog with `hasWoof = False`. Since the model space is smaller than the domain space, there must be either collisions in representation (ambiguous values), or domain values that are unrepresentable entirely.

*Model too small* is bad because ambiguity in the representation of values is bad. Ambiguous models encourages incorrect, complex, or arbitrary logic for distinguishing between subtypes. *Model too small* can also set limitations, by limiting the values that can be represented in the model space. This can end up as an unnecessary technical restriction on the input data, that is only because of the inability of the model to represent it.

### Typical Symptoms
In this example we see many of the typical symptoms of *model too small*
- Reuse of properties for more than one purpose
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

This model has no problems representing both cats and dogs. Unlike in the *model too small* example, it is easy to tell a cat from a dog. Cats have `hasWoof = Nothing` and dogs have `hasMeow = Nothing`. It is possible to represent dogs with `hasWoof = False`, and cats with `hasMeow = False` unambiguously. These were the cases that were ambiguous in the *model too small* example. However, too large a model presents another problem. It is possible to represent values that are not valid in the domain.

~~~ haskell
Pet { name = "catdog", hasWoof = True, hasMeow = True }

Pet { name = "datcog", hasWoof = Nothing, hasMeow = Nothing }
~~~

The first example is invalid because neither a cat nor a dog can have both properties `hasWoof` and `hasMeow` defined. Only one should ever be defined. The second example has the opposite problem, where neither `hasWoof`, nor `hasMeow` is defined. These are examples of values which are inside the model space, but outside of our desired domain space.

*Model too big* is more common in practice than *model to small*. Big models tend to disperse validation logic throughout the program, to wherever there is code that deals with the model. This is because many of the domain logic invariants that could be guaranteed by a smaller, more specific model are lacking in a big model. This means that invariants have to be double checked everywhere the model is used. *Model too big* also encourages complex validation logic in general.

### Typical Symptoms
- Many unrelated properties combined into one big model (melting pot model)
- Many or most of the properties have to be made optional
- Care must be taken not to accept value outside of the domain space

From a model that is too big, we can improve it by identifying distinct uses cases. Decompose the big model into many smaller models, one for each use case. Then, combine the models together into a sum type. Good languages should have direct support for sum types, but they can be simulated in other languages by using tagged unions.


## Model Just Right
The solution to this problem is to ensure that the model space matches the domain space as closely as possible. Here is how a model can be defined for cats and dogs, that avoids all of the problems of the examples above.
~~~ haskell
data Pet = Cat { name :: String, hasMeow :: Bool }
         | Dog { name :: String, hasWoof :: Bool }
~~~

Notice that the sum type restricts the possible values so that only `hasMeow` xor `hasWoof` can be defined. This encodes a domain logic restraint into the type system that was not included in the model before.

### Exceptions
Some logical constraints cannot be encoded into standard type systems without introducing dependent types. Dependent types are a types system where type can depend on values, rather than depending only on other types. Dependent types allow the type system to encode first-order logic properties, such as "a pair of integers where the first is greater than the second". At the time of writing, here is virtually no support for dependent types in popular programming languages. Only research and experimental languages like Idris and Coq support dependent types. Unfortunately it is not possible to encode first-order domain logic into models using non-dependently typed programming languages.

For this reason, this article only applies to the failure to encode zeroeth-order domain logic (that which can be expressed using non-dependent types) into models.

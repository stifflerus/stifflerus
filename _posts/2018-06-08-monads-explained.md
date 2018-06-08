---
layout: post
title: Monads Explained
---

Not like: burrito, spaceship, boxes
Monads are a simple idea with a name derivied from category theory.

Monads are a typeclass / Monads are an interface

`return: T -> Monad<T>`

`bind: Monad<T> -> (T -> Monad<S>) -> Monad<S>`

also `>>` and `fail` but those are sorta haskell implementation things

So monad is a way of encapsulating a value inside of a type, and then applying
operations to that value while it's still encapsulated.

Why is this useful?

Because the encapsulation can perform computation.

Example
```typescript
let value = {
    x: {
        y: {
            z: "Hello world"
        }
    }
}
```
`return value["x"]["y"]["z"]` //this should bother you. It is extremely unsafe!

Because each property access can fail (by returning undefined), we should be checking
for that condition between each property access
```typescript
doIfSafe(object: any, func: (input: any) => any) {
    return object === undefined ? undefined : func(object);
}

getProperty(propertyName: string): (obj: any) => any {
    return function(obj: any) {
        return obj[propertyName];
    }
}
return doIfSafe(
            doIfSafe(
                doIfSafe(
                    value,
                    getProperty("x")),
                getProperty("y")),
            getProperty("z"));
```

This way wraps each operation with some additional computation (in this case, doIfSafe).
It is safe. If an undefined is returned by any of the functions, it propagates it's
way up through the call stack without causing a runtime error.

It is tedious to nest function calls like this. If only there was a better way.

If we abstract this pattern to give it cleaner syntax, what we get is a Monad. In
this case, doIfSafe is the computation encapsulated by the Maybe monad because 
when you access the property of an object,
the value may be undefined.
```typescript
Maybe {
    new Maybe(): T -> Maybe<T> (return)
    bind(): Maybe<T> -> (T -> Maybe<S>) -> Maybe<S> (bind >>=)
}
```

It probably isn't clear yet how this fits into the safePropertyAccess pattern above. Observe
```typescript
getProperty(propertyName: string): (obj: any) => Maybe<any> {
    return function(obj: any): Maybe<any> {
        return new Maybe(obj[propertyName]);
    }
}

return new Maybe(value)
    .bind(getProperty("x"))
    .bind(getProperty("y"))
    .bind(getProperty("z"));
```

That's a much more elegant than nesting function calls, but where is the checking
for undefined? That is the beauty of the Monad. Maybe encapsulates the checking for
undefined. It's actually hidden away in the implmenetation of `.bind()`. 

It's not just checking for undefined that monads are capable of doing. That is
specific to the Maybe monad. A monad can encapsulate any computation you want.
A monad changes a call stack like
`A(B(A(C(A(D(...))))))`
where each function call is nested and wrapped in some other function into
`Monad.return(value).bind(B).bind(C).bind(D)`
where the functions are chained together and the wrapping function is implicity called
by `.bind()`

If the idea of changing a nested pyramid of doom into a chain of function calls
seems familar, that because you are probably already familar with at least one monad: the Promise.

That's right. Javascript Promises are, in fact, monads!

Promises encapsulate complicated behavior. Promises are optional types like Maybe,
but they are also deferred or async types. So a Promise is not a "pure" monad, but
all the basic ideas still apply.

Promise:
`return: Promise.resolve(), Promise.reject()`
`bind: .then(), .catch()`

So just like the Maybe type, we can turn a stack of nested function calls into a
much cleaner chain

```typescript
first(cb) => {
    cb();
}

second(cb) => {
    cb();
}

third(cb) => {
    cb();
}

do() => {
    first(
        second(
            third(() => {

           })
        )
    );
}
```
Verses
```typescript
first() => Promise<any> {
    return Promise.resolve();
}

second() => Promise<any> {
    return Promise.resolve();
}

third() => Promise<any> {
    return Promise.resolve();
}

do() => {
    first()
        .then(second)
        .then(third);
}
```
---
layout: post
title: TypeScript is Not the Same Thing As JavaScript
---

This should probably go without saying, but here it is: 
**TypeScript and JavaScript are not the same programming language.**
Nevertheless, I often hear from colleages and read in stackoverflow posts that "TypeScript is the 
same thing as JavaScript", or "it compiles to JavaScript, so it's the same". TypeScript and JavaScript
are completely different programming languages, but related in a way that can mislead people into
thinking that they're the same.

## TypeScript is a Strict Superset of JavaScript
One of the design goals for TypeScript was for it be a superset of JavaScript.

- typescript is a strict superset, which means they aren't equal
- valid js is also valid ts, but not the other way around
- typescript has a ton of features that javascript doesn't - most notable,
  of course, being the type system.
- C++ is "C with classes" but that doesn't mean it's the same thing as C
- C/C++ also get grouped together for similar reasons

## Except For When It Isn't
- typescript uses "sliding scale" type system
- type checking ranges from entirely optional to extremely strict depending on
  compiler settings
- with strict compiler settings, ts is no longer a superset of javascript - js
  is no longer valid ts
- 


## Transcompiling is Just A Special Case of Compiling
- compilers translate computer code from one language to another
- many types of compilers
  - hi to low (what we normally think of as a compiler)
  - low to high (decompiler, actually a misnomer since a decompiler is a type of compiler)
  - hi to hi (transcompiler)



- Java/JavaScript??
- Various languages targeting the JVM or EVM don't make them equivalent
- Many languages target machine language and they're not equivalent either
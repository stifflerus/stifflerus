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

- another design goal was for ts to share semantics with js
  - this is likely necessary to achive the first goal
  - this means that js and ts have a lot in common semantically
- valid js is also valid ts
- but not the other way around, valid ts is not always valid js
- therein lies the difference
- typescript is a strict superset, which means they aren't equal
- typescript has a ton of features that javascript doesn't - most notable,
  of course, being the type system.
- also, older versions of typescript had modules and class features before they were incorportated into js
- C++ is "C with classes" but that doesn't mean it's the same thing as C
- C/C++ also get grouped together for similar reasons

## Except For When It Isn't
- typescript uses "sliding scale" type system
- the idea is to allow gradual addition of types to existing js programs
- type checking ranges from entirely optional to extremely strict depending on
  compiler settings
- actually creates a whole family of languages that depend on compiler settings
- with strict compiler settings, ts is no longer a superset of javascript - js
  is no longer valid ts

## Transcompiling is Just A Special Case of Compiling
- compilers translate computer code from one language to another
- many types of compilers
  - hi to low (what we normally think of as a compiler)
  - low to high (decompiler, actually a misnomer since a decompiler is a type of compiler)
  - hi to hi (transcompiler)
- just because the target languages is high level doesn't mean it's the same as the source language
- ts similarity to js is because it was designed that way, not because that's a requirement of transcompilation
- Various languages targeting the JVM or EVM don't make them equivalent to each other or the machine they run on
- Many languages target machine language and they're not equivalent to asm either
- example of a transcompiler where the source and target are very different

## Type Erasure
- ts types are erased during the compilation process
- program is compiled into javascript, which has it's own type system
- because of the semantic overlap some ts types are directly isomorphic to js type
- however, in general the ts types are erased by the compiler
- no nothing of the ts types exists in the emited javascript
- this is not unique to ts/js, not transcompilers. It's a common feature of many compilers
- any language that compiles to native code erases types since machine language doesn't have a type system
- arguing that because types don't exist at runtime in typescript mean they don't matter is like
  arguing that because types don't exist in machine language, c types don't matter.

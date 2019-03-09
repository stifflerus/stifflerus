---
layout: post
title: Filter, Map, Reduce: The Bread & Butter of Functional Programming Style in JavaScript
---

## Key Functions
### Filter
`filter` is the easiest of the three core functions to understand. `filter` acts
upon an array, taking one callback argument. The result
 is a new list, containing all the elements of the original array for which
the callback returned a truthy value. Put simply, it filters the list using the
callback.

```javascript
const data = [1, 2, 3, 4, 5, 6];

data.filter((num) => num % 2 === 0); // [2, 4, 6]
```

The callback function accepts an element from the array, and returns a boolean.
It is like a test to see if that element should be copied to the resultant list.
This type of function is sometimes called a [predicate](https://en.wikipedia.org/wiki/Predicate_(mathematical_logic)).

**You should use `filter` when you want to turn an array into a shorter array.**

#### Examples
```javascript
// Even 
const even = (nums) => nums.filter((num) => num % 2 === 0);

// Odd
const odd = (nums) => nums.filter((num) => num % 2 === 1);

// Compact
const compact = (elems) => elems.filter((elem) => elem);
```

### Map
`map` acts upon an array, taking one callback argument. The result is a new list,
containing all the elements of the original array, but with the callback function
applied to them.

```javascript
const data = [1, 2, 3, 4, 5, 6];

data.map((element) => 2 * element); //[2, 4, 6, 8, 10, 12]
```

**You should use `map` when you want to turn an array into an array of the same
length, but with different elements.**

#### Examples
```javascript
// Square
const square = (nums) => nums.map((num) => num * num);

// Selecting properties
const people = [
    {
        id: 123,
        firstName: 'Robert',
        lastName: 'Smith'
    },
    {
        id: 124,
        firstName: 'Bender',
        lastName: 'Rodriguez'
    }
].map((obj) => obj.id); // [123, 124]
```

### Reduce
`reduce` is the most difficult of the three core functions to understand. `reduce`
acts upon an array, taking one callback argument, and possibly a starting value.
`reduce` uses the callback function to combine elements together, "reducing" the
array into a single value.

```javascript
const data = [1, 2, 3, 4, 5, 6];

// Example with no initial value (sum)
data.reduce((accum, elem) => accum + elem); //21

//Example with initial value (product)
data.reduce((accum, elem) => accum * elem, 1) //720
```

Understanding the callback is key to understanding `reduce`. The callback takes
two parameters. The first parameter, called the accumulator, is the reduced value
of all the elements that have already been processed. The second parameter is the
element currently being processed. The return value of the callback function becomes
the accumulator in the next iteration.

`["h", "e", "l", "l", "o"].reduce((accum, elem) => accum + elem), "");`{.javascript}

|Iteration|Accumulator|Element|Array|Return of Callback
|-|-|-|-|-|
1|`""`{.javascript}|`"h"`|`["h", "e", "l", "l", "o"]`{.javascript}|`"h"`{.javascript}
2|`"h"`{.javascript}|`"e"`|`["e", "l", "l", "o"]`{.javascript}|`"he"`{.javascript}
3|`"he"`{.javascript}|`"l"`|`['l", "l", "o"]`{.javascript}|`"hel"`{.javascript}
4|`"hel"`{.javascript}|`"l"`|`["l", "o"]`{.javascript}|`"hell"`{.javascript}
5|`"hell"`{.javascript}|`"o"`|`["o"]`{.javascript}|`"hello"`{.javascript}

If the accumulator equals the value returned from the callback in the previous
iteration, then what is the value of the accumulator in the first iteration? There
are two obvious way to come up with an initial value for the accumulator. The first
is to pass the intial value as an argument. The second is to use the first element
as the accumulator, and begin iterating fromt the *second* element in the array.

This is why `reduce` accepts an initial value argument. When provided, the
accumulator in the first iteration will equal this intial value. It is common
for this initial value to be the [identity element](https://en.wikipedia.org/wiki/Identity_element)
of the reducing function. For example, 1 for multiplication, or 0 for addition.
When nothing is passed for the inital value, the first element of the array is
used, and interation begins at the second element.

**You should use `reduce` when you want to turn an array into a single value.**

#### Examples
```javascript
// Sum
const sum = (nums) => nums.reduce((accu, elem) => n1 + n2);

// Product
const product = (nums) => nums.reduce((n1, n2) => n1 * n2);

// Max
const max = (nums) => nums.reduce((oldMax, elem) => oldMax > elem ? oldMax : elem);

// Min
const min = (nums) => nums.reduce((oldMin, elem) => oldMin < elem? oldMin : elem);

// Any
const any = (bools) => bools.reduce((any, elem) => any || elem, false);

// None
const none = (bools) => bools.reduce((none, elem) => none && !elem, true)

// All
const all = (bools) => bools.reduce((all, elem) => all && elem, true);

// Join
const join = (chars) => chars.reduce((string, char) => string.concat(char), '');

// Head
const head = (elems) => elems.reduce((head, elem) => head);

// Last
const last = (elems) => elems.reduce((last, elem) => last);

// Contains
const contains = (elems, key) => elems.reduce((contains, elem) contains || (elem === key), false)
```

## Comparison With `for` Loops
### Clarifies Intention
### Separation of Scope
### Encourages Use of Pure Functions
### Composability
This is the beautiful part of the functional programming style. Since `filter`,
`map`, and `reduce` are pure functions, they are highly composable. They're also
fundemental functions and act like building blocks for many other functions. Let's
see some of the functions we can create by composing functions with `filter`, 
`map`, and `reduce`.

```javascript
// ConcatMap
const concatMap = (array, f) => array.map(f).reduce((accum, elem) => accum.concat(elem));

//CompactMap
const compactMap = (array, f) => array.map(f).filter((elem) => elem);
```

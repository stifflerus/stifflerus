---
layout: post
title: "Filter, Map, Reduce: The Bread & Butter of Functional Programming Style in JavaScript"
---

Functional programming is a style of programming that is distinguished by the
use of [higher order functions](https://en.wikipedia.org/wiki/Higher-order_function).
Higher order functions are functions that either take functions as a parameter,
or return a function as a result. In JavaScript, the functional style is a superior
way to perform many common operations due to is clarity and succinctness. To start
functional programming in JavaScript, there are three big functions that you need to know.

## Filter
[`filter`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/filter)
is the easiest of the three core functions to understand. `filter` acts
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

### Examples
```javascript
// Even
const even = (nums) => nums.filter((num) => num % 2 === 0);

// Odd
const odd = (nums) => nums.filter((num) => num % 2 === 1);

// Compact
const compact = (elems) => elems.filter((elem) => elem);
```

## Map
[`map`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)
acts upon an array, taking one callback argument. The result is a new list,
containing all the elements of the original array, but with the callback function
applied to them.

```javascript
const data = [1, 2, 3, 4, 5, 6];

data.map((element) => 2 * element); //[2, 4, 6, 8, 10, 12]
```

**You should use `map` when you want to turn an array into an array of the same
length, but with different elements.**

### Examples
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

## Reduce
[`reduce`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)
is the most difficult of the big three functions to understand. `reduce`
acts upon an array, taking one callback argument, and possibly a starting value.
`reduce` uses the callback function to combine elements together, "reducing" the
array into a single value.

```javascript
const data = [1, 2, 3, 4, 5, 6];

// Example with no initial value (sum)
data.reduce((accum, elem) => accum + elem); //21

//Example with initial value (product)
data.reduce((accum, elem) => accum * elem, 1); //720
```

Understanding the callback is key to understanding `reduce`. The callback takes
two parameters. The first parameter, called the accumulator, is the reduced value
of all the elements that have already been processed. The second parameter is the
element currently being processed. The return value of the callback function becomes
the accumulator in the next iteration.

`["h", "e", "l", "l", "o"].reduce((accum, elem) => accum + elem), "");`{:.javascript}

|Iteration|Accumulator|Element|Array|Return of Callback
|-|-|-|-|-|
1|`""`{:.javascript}|`"h"`|`["h", "e", "l", "l", "o"]`{:.javascript}|`"h"`{:.javascript}
2|`"h"`{:.javascript}|`"e"`|`["e", "l", "l", "o"]`{:.javascript}|`"he"`{:.javascript}
3|`"he"`{:.javascript}|`"l"`|`['l", "l", "o"]`{:.javascript}|`"hel"`{:.javascript}
4|`"hel"`{:.javascript}|`"l"`|`["l", "o"]`{:.javascript}|`"hell"`{:.javascript}
5|`"hell"`{:.javascript}|`"o"`|`["o"]`{:.javascript}|`"hello"`{:.javascript}

If the accumulator equals the value returned from the callback in the previous
iteration, then what is the value of the accumulator in the first iteration? There
are two obvious ways to come up with an initial value for the accumulator. The first
is to pass the initial value as an argument. The second is to use the first element
as the accumulator, and begin iterating from the *second* element in the array.

This is why `reduce` accepts an initial value argument. When provided, the
accumulator in the first iteration will equal this initial value. It is common
for this initial value to be the [identity element](https://en.wikipedia.org/wiki/Identity_element)
of the reducing function. For example, 1 for multiplication, or 0 for addition.
When nothing is passed for the initial value, the first element of the array is
used, and iteration begins at the second element.

**You should use `reduce` when you want to turn an array into a single value.**

### Examples

`reduce` might seem strange or arbitrary at first, but many commonly used function fit the
pattern of `reduce`. If a function takes an array and returns a single value,
chances are good that it can be written in terms of `reduce`.

```javascript
// Sum
const sum = (nums) => nums.reduce((accu, elem) => n1 + n2);

// Product
const product = (nums) => nums.reduce((n1, n2) => n1 * n2);

// Max
const max = (nums) => nums.reduce((max, elem) => max > elem ? max : elem);

// Min
const min = (nums) => nums.reduce((min, elem) => min < elem ? min : elem);

// Any
const any = (bools) => bools.reduce((any, elem) => any || elem, false);

// None
const none = (bools) => bools.reduce((none, elem) => none && !elem, true);

// All
const all = (bools) => bools.reduce((all, elem) => all && elem, true);

// Join
const join = (chars) => chars.reduce((string, char) => string.concat(char), '');

// Head
const head = (elems) => elems.reduce((head, elem) => head);

// Last
const last = (elems) => elems.reduce((elem, last) => last);

// Contains
const contains = (elems, key) => elems.reduce((contains, elem) => contains || (elem === key), false);
```

## Comparison With `for` Loops
Every example function above can be rewritten using plain old `for` loops. So what
is the advantage of the functional style using higher order functions? Let us
consider an example using `map`.

```javascript
const doubleWithMap = (nums) => nums.map((num) => num * 2);

const doubleWithFor = (nums) => {
  let doubledNums = [];

  for (i = 0; i < nums.length; i++) {
    doubledNums.push(nums[i] * 2);
  }

  return doubledNums;
};
```
### Clarification of Intention
When using the `for` loop, the act of iteration is not cleanly separated from the
action that is taken on each iteration. This tangles together two different concerns
of the operation, when they could be neatly separated.

Imagine someone reading these
two examples. Understanding the `for` loop version likely goes something like this:
1. Identify allocation of empty array. We likely going to put things in this new array.
2. Identify usage of `for` loop. Something is happening repeatedly here.
3. Identify how the `for` loop is being used. `for(i = 0; i < nums.length; i++)`{:.javascript}
   is a common pattern for iterating over a list. The code is iterating over a list.
4. Identify what happens in each iteration. The element is being multiplied by two and
   pushed to the new array.
5. Identify what happens to the new array. The array is returned.
6. Put it all together. The result is a new array with all the elements doubled.

Understanding the `map` example is much simpler:
1. Identify usage of `map`. We are returning a new array containing the result of
   applying a function to all of it's elements.
2. Identify the callback. It doubles an element. We are doubling all the elements.
3. Put it all together. The result is a new array with all the elements doubled.

The reason that `map` is easier to understand is because the ideas of "iterating over
an array, applying a function to each element", and "doubling an element" are separated.
In the `for` loop example, the two are tangled together. It takes more careful
analysis to recognize the pattern of iteration and function application using `for`.
`map` gives a name to this pattern, eliminating the need to deduce what is happening
by looking at the details of the operation.

### Separation of Scope
Separating the concerns of iteration and the doubling has another benefit.
The scope of the two contexts is also separated, preventing interference between
the two. Notice how in the `for` loop, nothing prevents the programmer from modifying
the iterator ,`i`, from within the body of the loop. The scope of the two contexts
is tangled.  Modification of the variables
concerning iteration withing the body of a `for` loop is almost certainly a mistake.
In the `map` example, the callback function has no access to the surrounding
scope in which it is called. This is a good thing. The `map` function does the job
of deciding when to call the callback function. This type of control flow
is sometimes called [inversion of control](https://en.wikipedia.org/wiki/Inversion_of_control).

### Composability
This is the beautiful part of the functional programming style. Since `filter`,
`map`, and `reduce` are pure functions, they are highly composable. Pure functions
are like Lego bricks and can be combined together in myriad ways to create new
functions. There are no side effects, tangled scopes, or non-separation of concerns.
This makes composability a very powerful tool without the risk of [spaghettification](https://en.wikipedia.org/wiki/Spaghetti_code) that comes with composing imperatively styled code. Consider this example:

```javascript
const doubleEvensFunctions = (nums) => nums
  .filter((num) => num % 2 === 0)
  .map((num) => num * 2);

const doubleEvensWithFor = (nums) => {
  let doubledEvens = [];

  for (i = 0; i < nums.length; i++) {
    if(nums[i] % 2 == 0) {
      doubledEvens.push(nums[i] * 2);
    }
  }

  return doubledEvens;
};
```

Notice how in the `for` loop, things have become a mess already. There is now
four different concerns tangled together.
1. Iterating over an array, applying a function to each element.
2. The function that gets applied to each element.
3. Iterating over an array, eliminating elements according to a predicate.
4. The predicate

Composing more functionality together only makes the problem worse. Function  
composition using `for` loops simply does not scale to many functions. Each additional
function would require modification of the `for` loop body, further entangling
context and obfuscating intention.

On the other hand, `map` and `filter` make function composition easy. Each context stays
separated, even when functions are combined together. To someone reading the code,
it is extremely clear what is happening. Furthermore,
function composition using pure functions scales to many functions. Composing
more functions together is only a matter of chaining more things together.

## Conclusion
`map`, `filter`, and `reduce` are key functions in the functional style of
programming in Javascript. Many common functions can be reduced to one of these three
patterns. If you master the use of these three functions, you
are off to a good start in your journey into functional programming.

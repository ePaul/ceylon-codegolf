# Type uniqchars!

The [Question on PPCG][q] asks:

> Given a string consisting of printable ASCII chars, produce an output consisting of its unique chars in the original order. In other words, the output is the same as the input except that a char is removed if it has appeared previously.

Functions were allowed, so here some functions doing this.

* [using a comprehension](comprehensionWithIndex.ceylon) seems to be the shortest non-cheating solution (68).
* [using the same approach with `filter`](indexedFilter.ceylon) is longer (79).
* [using a hash set](uniqueWithHashSet.ceylon) is one byte longer (69) – half of its length
   comes from importing the HashSet class from ceylon.collections.
* Clearly cheating is [using `Iterable.distinct`](uniqueWithDistinct.ceylon) (39) (the rules said not to .
* Using the new Ceylon 1.2 `set` function [is even shorter](uniqueWithSet.ceylon) (35),
   but doesn't actually work: the characters in the resulting set are not in the original
   order, but semi-randomly shuffled.

My answers: [without sets][a1], [with sets][a2]. Those have also variants reading the input from std-in and printing the result to stdout.s

[q]: http://codegolf.stackexchange.com/q/59625/2338
[a1]: http://codegolf.stackexchange.com/a/59789/2338
[a2]: http://codegolf.stackexchange.com/a/59785/2338
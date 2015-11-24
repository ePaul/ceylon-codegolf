// zip-sort
//
// Question:  http://codegolf.stackexchange.com/q/64526/2338
// My answer: http://codegolf.stackexchange.com/a/64600/2338

// Takes a list of strings (same length), and produces
// a string made by concatenating the results of sorting
// the characters at each position.

String z(String+ l) =>
        String(expand(t(l).map(sort)));

// Narrow an iterable of potential optionals to their non-optional values,
// throwing an AssertionError if a null is in there.
[T+] n<T>(T?+ i) =>
        [for (e in i) e else nothing];

// Transpose a nonempty sequence of iterables, producing an iterable of
// sequences.
// If the iterables don't have the same size, either too long ones are
// cut off or too short ones cause an AssertionError while iterating.
{[X+]*} t<X>([{X*}+] l) =>
        l[0].empty
        then {}
        else { n(*l*.first), *t(l*.rest) };

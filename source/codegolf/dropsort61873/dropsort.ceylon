// dropsort: "sorts" a sequence of integers by dropping all elements which don't fit.
//
// Question:  http://codegolf.stackexchange.com/q/61808/2338
// My answer: http://codegolf.stackexchange.com/a/61873/2338
//
// Input and output are (possible empty) sequences of integers.
Integer[] d(Integer[] l) =>
// construct a sequence with a comprehension
        [
    // iterate over the input sequence, with indexes.
    for (i->x in l.indexed)
        // only if x it is the maximum of ...
        if (x == max
            // .. an iterable made from x and the part of the input sequence just before the current index ...
                { x, *l[0:i] })
            // ... include x in the iteration.
            x];

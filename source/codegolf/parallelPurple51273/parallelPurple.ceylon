// Find (enumerate) all halting programs in (a non-I/O subset of) Purple.
//
// Question:  http://codegolf.stackexchange.com/q/51273/2338
// My answer: http://codegolf.stackexchange.com/a/65820/2338

// We use a turing-complete subset of the Purple language,
// with input and output (i.e. the `o` command) removed.

import ceylon.language {
    l=variable,
    I=Integer,
    m=map,
    S=String
}

// an interpreting machine.
class M(S d) {
    // The memory tape, as a Map<Integer, Integer>.
    // We can't modify the map itself, but we
    // can replace it by a new map when update is needed.
    l value t = m {
        // It is initialized with the code converted to Integers.
        // We use `.hash` instead of `.integer` because it is shorter.
        *d*.hash.indexed
    };

    // three registers
    l I a = 0;
    l I b = 0;
    l I i = 0;

    // get value from memory
    I g(I j) =>
            t[j] else 0;

    // Map of "functions" for fetching values.
    // We wrap the values in iterable constructors for lazy evaluation
    //  – this is shorter than using (() => ...).
    // The keys are the (Unicode/ASCII) code points of the mapped
    // source code characters.
    value f = m {
        // a
        97 -> { a },
        // b
        98 -> { b },
        // A
        65 -> { g(a) },
        // B
        66 -> { g(b) },
        // i
        105 -> { i },
        // 1
        49 -> { 1 }
    };

    // Map of functions for "storing" results.
    // The values are void functions taking an Integer,
    // the keys are the ASCII/Unicode code points of the corresponding
    // source code characters.
    value s = m {
        // a
        97 -> ((I v) => a = v),
        // b
        98 -> ((I v) => b = v),
        // Modification of the memory works by replacing the map with
        // a new one.
        // This is certainly not runtime-efficient, but shorter than
        // importing ceylon.collections.HashMap.
        // A
        65 -> ((I v) => t = m { a->v, *t }),
        // B
        66 -> ((I v) => t = m { b->v, *t }),
        // i
        105 -> ((I v) => i = v)
    };

    // Exit the interpretation, throwing an exception with the machine's
    // source code as the message.  The return type is effectively `Nothing`,
    // but shorter (and fits the usages).
    I&I(I) x {
        throw Exception(d);
    }

    // accessor function for the f map
    I h(I v) =>
            f[v]?.first else x;

    // a single step
    shared void p() {
        (s[g(i)] else x)(h(g(i + 1)) - h(g(i + 2)));
        i += 3;
    }
}

// the main entry point
shared void run() {
    // the alphabet of "Purple without I/O".
    value a = '!'..'~';
    //// possible alternative to use a command line argument:
    // value a = process.arguments[0] else '!'..'~';

    // an iterable consisting of all programs in length + lexicographic order
    {S*} s =
            // `expand` creates a single iterable (of strings, in this case)
            // from an iterable of iterables (of strings).
             expand(
        // `loop` creates an iterable by applying the given function
        // on the previous item, repeatedly.
        // So here we start with the iterable of length-zero strings,
        // and in each iteration create an iterable of length `n+1` strings
        // by concatenating the length `n` strings with the alphabet members.
        loop<{S*}>{ "" }((g) =>
                {
                    for (c in a)
                        for (p in g)
                            p + "``c``"
                }));

    // This is a (variable) iterable of currently running machines.
    // Initially empty.
    l {M*} r = {};

    // iterate over all programs ...
    for(p in s) {
        // Create a machine with program `p`, include it
        //  in the list of running machines.
        //
        // We use a sequence constructor here instead of
        //  an iterable one (i.e. `r = {M(p, *r)}` to prevent
        // a stack overflow when accessing the deeply nested
        // lazy iterable.
        r = [M(p), *r];
        // iterate over all running machines ...
        for(e in r) {
            try {
                // run a step in machine e.
                e.p();
            } catch(x) {
                // exception means the machine halted.
                // print the program
                print(x.message);
                // remove the machine from the list for further execution
                r = r.filter(not(e.equals));
            }
        }
        // print(r.last);
    }
}

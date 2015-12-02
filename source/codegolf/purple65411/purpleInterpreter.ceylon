// Purple – a self-modifying, "one-instruction" language.
//
// Question:  http://codegolf.stackexchange.com/q/65411/2338
// My answer: http://codegolf.stackexchange.com/a/65492/2338

import ceylon.collection {
    H=HashMap
}

alias I => Integer;

// "Exit" the program (= throw an exception which is caught outside of the main loop).
// That properly should be a proper subclass of Exception (and only this would be
// caught), but this would be longer :-/
//
// class X() extends Exception();
// I & I() ex {
//    throw X();
// }

class E(String code) {
    // Memory (HashMap<Integer, Integer>), can be modified.
    value m = H {
        // It is initialized with the code converted to Integers.
        // We use `.hash` instead of `.integer` because it is shorter.
        *code*.hash.indexed };

    // three registers
    variable I a = 0;
    variable I b = 0;
    variable I i = 0;

    // get value from memory
    I g(I j) =>
            m[j] else 0;

    // cached input which is still to be read
    variable {I*} c = [];

    // get value from stdin.
    // we can only comfortably access stdin by line, so we read a whole line
    // and cache the rest for later.
    I gO {
        if (c == []) {
            if (exists l = process.readLine()) {
                c = l*.hash.chain { 10 }; // convert string into ints, append \n
            } else {
                // EOF – return just -1 from now on.
                c = { -1 }.cycled;
            }
        }
        assert (is I r = c.first);
        c = c.rest;
        return r;
    }

    // output a value
    void pO(I v) {
        process.write("``v.character``");
    }

    // Map of "functions" for fetching values.
    // We wrap the values in iterable constructors
    // for lazy evaluation – this is shorter than using (() => ...).
    // The keys are the (Unicode/ASCII) code points of the mapped
    // source code characters.
    value f = map {
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
        // o
        111 -> { gO },
        // 1
        49 -> { 1 }
    };

    // Map of functions for "storing" results.
    // The values are void functions taking an Integer,
    // the keys are the ASCII/Unicode code points of the corresponding
    // source code characters.
    value p = map {
        // a
        97 -> ((I v) => a = v),
        // b
        98 -> ((I v) => b = v),
        // A
        65 -> ((I v) => m.put(a, v)),
        // B
        66 -> ((I v) => m.put(b, v)),
        // i
        105 -> ((I v) => i = v),
        // o
        111 -> ((I v) => pO(v))
    };

    // accessor function.
    I vf(I v) =>
            f[v]?.first else nothing;

    //value ex {
    //    throw this;
    //}

    // a single step.
    shared void s() {
        (p[g(i)] else nothing)(vf(g(i + 1)) - vf(g(i + 2)));
        i += 3;
    }
}

shared void run() {
    try {
        // Reading code from file certainly takes more than 79 characters,
        // this isn't worth the 10% bonus.
        if (exists l = process.arguments[0]) {
            //  value l = "bbboobiii";
            E e = E(l);
            while (true) {
                e.s();
            }
        }
    } catch (AssertionError e) {
        // e.printStackTrace();
        // abort silently
    }
}

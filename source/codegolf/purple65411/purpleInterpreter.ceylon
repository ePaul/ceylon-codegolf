// Purple – a self-modifying, "one-instruction" language.
//
// Question:  http://codegolf.stackexchange.com/q/65411/2338
// My answer: http://codegolf.stackexchange.com/a/65492/2338

import ceylon.language {
    l=variable,
    I=Integer,
    x=nothing,
    p=process,
    m=map
}

shared void run() {
    try {
        // Reading code from file certainly takes more than 73 characters,
        // this isn't worth the 10% bonus.
        if (exists d = p.arguments[0]) {

            // The memory tape, as a Map<Integer, Integer>.
            // We can't modify the map itself, but we
            // can replace it by a new map when update is needed.
            l value t = m {
                // It is initialized with the code converted to Integers.
                // We use `.hash` instead of `.integer` because it is shorter.
                *d*.hash.indexed };

            // three registers
            l I a = 0;
            l I b = 0;
            l I i = 0;

            // get value from memory
            I g(I j) =>
                    t[j] else 0;

            // cached input which is still to be read
            l {I*} c = [];

            // get value from stdin.
            // we can only comfortably access stdin by line, so we read a whole line
            // and cache the rest for later.
            I o {
                if (c == []) {
                    if (exists e = p.readLine()) {
                        c = e*.hash.chain { 10 }; // convert string into ints, append \n
                    } else {
                        // EOF – return just -1 from now on.
                        c = { -1 }.cycled;
                    }
                }
                assert (is I r = c.first);
                c = c.rest;
                return r;
            }


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
                // o
                111 -> { o },
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
                // Modification of the memory works by replacing the map with a new one.
                // This is certainly not runtime-efficient, but shorter than importing
                // ceylon.collections.HashMap.
                // A
                65 -> ((I v) => t = m { a->v, *t }),
                // B
                66 -> ((I v) => t = m { b->v, *t }),
                // i
                105 -> ((I v) => i = v),
                // o – output as a character.
                111 -> ((I v) => p.write("``v.character``"))
            };

            // accessor function for the f map
            I h(I v) =>
                    f[v]?.first else x;

            // the main loop, can only be left by exception
            while (0 < 1) {
                (s[g(i)] else x)(h(g(i + 1)) - h(g(i + 2)));
                i += 3;
            }
        }
    } catch (AssertionError e) {
        // abort silently
    }
}

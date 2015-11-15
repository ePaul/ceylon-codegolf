// Count up forever (in decimal).
//
// Question:  http://codegolf.stackexchange.com/q/63834/2338
// My Answer: http://codegolf.stackexchange.com/a/63885/2338

// It seems we need big numbers, since we are supposed to count up to at least 2^128.
// Integer goes just below 2^63.
import ceylon.math.whole {
    o=one
}

shared void run() {
    loop(o)(o.plus).each(print);
}

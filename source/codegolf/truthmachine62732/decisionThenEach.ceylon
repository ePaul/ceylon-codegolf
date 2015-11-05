// The truth machine.
// If input is 1, print 1 forever.
// If input is 0, print 0 once, then finish.
//
// Question: http://codegolf.stackexchange.com/q/62732/2338
// My answer: http://codegolf.stackexchange.com/a/62897/2338
// 
// This is a "functional" solution, meaning that
// the function definition consists of a single
// expression, with no explicit imperative statement.
//
// Gives 88 bytes after whitespace + comment removal.

shared void run() => (
    // do input (with fallback to the empty string if EOF),
    // then compare the result with "0". 
    "0" < (process.readLine() else "")
            then
    // if the result was larger than "0" (e.g. "1"), take
    // the infinite stream of ones.
    { 1 }.cycled
            else
    // otherwise, e.g. for "0", take the stream of a single 0. 
    { 0 })
// for each element invoke the print function with this element.
    .each(print);

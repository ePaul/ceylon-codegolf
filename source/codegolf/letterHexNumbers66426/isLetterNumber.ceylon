// check if an integer, when written in hexadecimal, contains only letters.
//
// Question:  http://codegolf.stackexchange.com/q/66426/2338
// My answer: http://codegolf.stackexchange.com/a/66444/2338

Boolean l(Integer n) =>
        !any(formatInteger(n, 16)*.digit);

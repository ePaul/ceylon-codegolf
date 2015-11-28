// Count the divisors of a (natural) number
//
// Question:  http://codegolf.stackexchange.com/q/64944/2338
// My answer: http://codegolf.stackexchange.com/a/65124/2338

Integer d(Integer n) =>
        (1..n).count((i) => n%i < 1);

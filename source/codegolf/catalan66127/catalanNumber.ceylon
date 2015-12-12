// Catalan number C_n
//
// Question:  http://codegolf.stackexchange.com/q/66127/2338
// My answer: http://codegolf.stackexchange.com/a/66425/2338

Integer c(Integer n) =>
        // sequence of length n, starting at 1.
        (1:n)
        // starting with 1, for each element i, multiply the result
        // of the previous step by (n+i) and then divide it by i.
    .fold(1)((p, i) => p * (n + i) / i)
        // divide the result by n+1.
        / (n + 1);

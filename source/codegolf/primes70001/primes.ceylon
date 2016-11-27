// Print the first n primes.
//
// Question:  http://codegolf.stackexchange.com/q/70001/2338
// My answer: http://codegolf.stackexchange.com/a/70021/2338

void p(Integer n) =>
        // the infinite sequence of integers, starting with 2.
        loop(2)(1.plus)
        // filter by primality (using trial division)
        .filter((c) => !  (2 : c-2).any((d) => c%d < 1) )
        // then take the first n elements
        .take(n)
        // print each element
        .each(print);

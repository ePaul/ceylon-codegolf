// Sum pyramid of primes
//
// Question:  http://codegolf.stackexchange.com/q/65822/2338
// My answer: http://codegolf.stackexchange.com/a/65879/2338

alias I => Integer;

// Calculate the pyramid sum of some sequence.
I s(I* l) =>
        // If less than two elements ...
        l.size < 2
        // then use the first (only element), or 0 if no such.
        then (l[0] else 0)
        // otherwise,
        else s(*
               // take the iterable of pairs of consecutive elements,
               l.paired
               // and add each of them together.
                .map((I[2] i) => i[0] + i[1])
               // then apply s (recursively) on the result.
               );

// Calculate the pyramid sum of the first n primes.
I p(I n) => s(*
              // the infinite sequence of integers, starting with 2.
              loop(2)(1.plus)
              // filter by primality (using trial division)
              .filter((c) => !(2 : c-2)
                              .any((d) => c%d < 1))
              // then take the first n elements
              .take(n)
              // then apply s on the result.
             );

import ceylon.language { S=String, I=Integer,e=expand }

// output a base-proof Ceylon expression for an integer
// (i.e. using only 0 and 1 as digits).
//
// Question: http://codegolf.stackexchange.com/q/58084/2338
// My Answer:  http://codegolf.stackexchange.com/a/58122/2338
//
// The goal is to produce an expression as short as possible, with
// the code staying under 512 bytes in length.
//
// This approach is to represent a positive integer as a square
// of a positive integer plus some remainder (where the remainder
// can be negative), and for negative integers replace the + on the
// outer level by -.

S q(I n) =>
        n == 0 then "0"
        else (n < 0 then "-" + p(-n, "-")
            else p(n, "+"));

// cache for values of p
variable Map<[I, S],S> c = map { };

// Transforms a positive number into a base-proof term, using
// the given sign for the summation on the outer level.
S p(I n, S s) {
    S v =
    // look into the cache
            c[[n, s]] else (
        // hard-code small numbers
        n < 8 then s.join([1].repeat(n)))
            else
    // do the complicated stuff
    (let (a = "+-".replace(s,""))
            e(e {
                    for (x in 2..8) // try these exponents
                        let (l = (n ^ (1.0 / x)).integer) // \[ sqrt[exp]{n} \] in LaTeX
                            { for (r in l:2) // lowerRoot, lowerRoot + 1
                                    if (r > 1)
                                        let (w = r ^ x)
                                            { if (w-n < n) // avoid recursion to larger or same number
                                                    // format the string as  r^x + (n-w)
                                                    "(" + p(r, "+") + ")^(" + p(x, "+") + ")" +
                                                            (w < n then s + p(n - w, s)
                                                                else (n < w then a + p(w - n, a)
                                                                    else ""))
                                            } } })
            // and now find the shortest formatted string
                .reduce<S>((x, y) => x.size < y.size then x else y))
    // this should never happen, but we can't tell the compiler
    // that at least some of the iterables are non-empty due to the if clause.
            else "";
    
    // this builds a new cache in each step – quite wasteful,
    // as this also happens when the value was found in the cache,
    // but we don't have more characters remaining.
    //// c = map { [n, s] -> v, *c };
    ///better way:
     c = [n,s] in c then c else map{[n,s]->v, *c}; 
    return v;
}

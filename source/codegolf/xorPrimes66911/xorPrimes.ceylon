// primes for XOR-multiplication.
//
// Question:  http://codegolf.stackexchange.com/q/66911/2338
// My Answer: http://codegolf.stackexchange.com/a/66972/2338

{Integer*} p(Integer n) =>
        loop(2)(1.plus).filter((m) => {
            for (i in 2 : m-2)
                for (j in 2 : m-2)
                    if (m == [
                            for (k in 0:64)
                                if (j.get(k))
                                    i * 2^k
                        ].fold(0)((y, z) => y.xor(z))) i
        }.empty).take(n);

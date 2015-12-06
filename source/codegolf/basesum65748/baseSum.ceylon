// Find sum of all possible base representations.
//
// Question:  http://codegolf.stackexchange.com/q/65748/2338
// My Answer:

Integer b(String s) =>
        // take the sum of ...
        sum(
            // span from 2 to 36
            (2..36)
            // map each r of them to ...
            .map((r) =>
                // if r is 10 and s contains a letter, 0.
                r==10 && any(s*.letter)
                        then 0
                        // otherwise try parsing s as a number using base r
                        else parseInteger(s, r)
                        // if that didn't succeed, use 0 again.
                        else 0
            )
        );

// Find sum of all possible base representations.
//
// Question:  http://codegolf.stackexchange.com/q/65748/2338
// My Answer: http://codegolf.stackexchange.com/a/65836/2338

Integer b(String s) =>
// take the sum of ...
        sum(
    // span from 2 to 36. (Though
    // if there are letters in there, we start at 11,
    // because the other ones can't be valid.
    // Also, parseInteger(s, 10) behaves a bit strange in Ceylon.)
    ((any(s*.letter) then 11 else 2) .. 36)
    // map each r of them to ...
        .map((r) =>
            // try parsing s as a number using base r
            parseInteger(s, r)
            // if that didn't succeed, use 0.
                    else 0
    )
);

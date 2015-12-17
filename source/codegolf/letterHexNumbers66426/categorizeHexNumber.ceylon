// Categorize hexadecimal numbers.
// (Bonus version for the same question.)
//
// Question:  http://codegolf.stackexchange.com/q/66426/2338
// My answer: http://codegolf.stackexchange.com/a/66444/2338

String c(Integer n) =>
        let (d = formatInteger(n,16)*.digit)
    (every(d) then "Only numbers"
                else (any(d) then "Mix"
                    else "Only letters"));

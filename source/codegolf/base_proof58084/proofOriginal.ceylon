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

String proofed(Integer n) {
    if (n == 0) { return "0"; }
    if (n < 0) { return "-" + pr(-n, "-"); }
    return pr(n, "+");
}
// Transforms a positive number into a base-proof term, using
// the given sign for the summation on the outer level.
String pr(Integer n, String sign) { 
    if (n < 9) {
        return sign.join([1].repeat(n));
    }
    value anti = (sign == "+") then "-" else "+";
    value root = ((n^0.5) + 0.5).integer;
    return "(" + pr(root, "+") + ")^(1+1)" +
            ( (root^2 < n) then sign + pr(n - root^2, sign) else
        ((n < root^2) then anti + pr(root^2 - n, anti) else ""));
}
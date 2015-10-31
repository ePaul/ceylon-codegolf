// Programming with Bits and Bytes.
// Question at http://codegolf.stackexchange.com/q/57204/2338
// Answer (variant with shorter function name and xor instead of or) postet at
//     http://codegolf.stackexchange.com/a/57236/2338
shared void run() {
    // read input (one line) as a string (or use the empty string if there was no input)
    value t = process.readLine() else "";
    // accumulator A (lowercase here).
    variable Byte a = 0.byte;
    // iterate over the input
    for (c in t) {
        // do different things for the commands:
        switch (c)
        case ('!') {
            // inversion: invert each bit.
            a = a.not;
        }
        case ('>') {
            // shift right
            a = a.rightLogicalShift(1);
        }
        case ('<') {
            // shift left
            a = a.leftLogicalShift(1);
        }
        case ('@') {
            // swap nibbles (half-bytes).
            a = a.and(#f0.byte).rightLogicalShift(4).or(a.and(#f.byte).leftLogicalShift(4));
        }
        // ignore all non-command letters.
        else {}
    }
    // print the accumulator at the end.
    print(a);
}

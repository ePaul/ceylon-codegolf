// The truth machine.
// If input is 1, print 1 forever.
// If input is 0, print 0 once, then finish.
//
// Question: http://codegolf.stackexchange.com/q/62732/2338
// My answer: http://codegolf.stackexchange.com/a/62897/2338
// 
// This is a solution which actually parses the input into an integer
// and uses the numeric value.
// Gives 107 bytes after whitespace + comment removal.

shared void fun() {
    // parse the input line into a number, or 2 (this is arbitrary) if it is not a number.
    value i = parseInteger(process.readLine() else "") else 2;
    // the range of length i, starting at 1.
    // Will be {} if i == 0, {1} if i = 1, and {1,2} if i == 2.
    // (Other values are possible, the first two are relevant.)
    (1:i)
    // cycle this range forever.
    // Will give {} (if i == 0) or {1,1,1,1,1,1...} (if i == 1).
        .cycled
    // prepend a single [i].
    // Will result in {0} if i == 0, {1, 1,1,1,1,1,1,...} (if i == 1)
        .follow(i)
    // for each element x, call `print(x)`.
        .each(print);
}

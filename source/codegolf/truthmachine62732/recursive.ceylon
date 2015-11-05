// The truth machine.
// If input is 1, print 1 forever.
// If input is 0, print 0 once, then finish.
//
// Question: http://codegolf.stackexchange.com/q/62732/2338
// My answer: http://codegolf.stackexchange.com/a/62897/2338
// 
// This is a try of a recursive solution, where just the loop is
// replaced by a recursion.
// (It will pretty soon finish with a stack overflow.)
// 97 bytes after whitespace removal.

shared void rec() {
    if ("0" < (process.readLine() else "")) {
        void p() {
            print(1);
            p();
        }
        p();
    } else {
        print(0);
    }
}

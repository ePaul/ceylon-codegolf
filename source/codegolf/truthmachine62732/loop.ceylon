// The truth machine.
// If input is 1, print 1 forever.
// If input is 0, print 0 once, then finish.
//
// Question: http://codegolf.stackexchange.com/q/62732/2338
// My answer: http://codegolf.stackexchange.com/a/62897/2338
// 
// This is a straight-forward loop solution, with a
// optimized input + decision combination.
// This gives 88 bytes after removing spaces and comments.

shared void lun() {
    if("0"<(process.readLine() else "")) {
        while(0<1) {
            print(1);
        }
    } else {
        print(0);
    }
}
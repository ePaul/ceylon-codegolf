// print the current time (each second).
//
// Question:  http://codegolf.stackexchange.com/q/65020/2338
// My answer: http://codegolf.stackexchange.com/a/65130/2338

import ceylon.time {
    n=now
}

void p() {
    for(e in { n().time().string[0:8] }.cycled.paired) {
        if(e[0]!=e[1]) {
            print(e[1]);
        }
    }
}

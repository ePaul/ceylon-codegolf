// 99 bottles of beer
//
// Question:  http://codegolf.stackexchange.com/q/64198/2338
// My answer: http://codegolf.stackexchange.com/a/64522/2338
alias S => String;
alias I => Integer;
shared void run() {
    value [b, o, w, t, d] = [
        " bottle",
        " of beer",
        " on the wall",
        "Take one down and pass it around, ",
        ".\n"
    ];
    S l = "1" + b + o;
    S h(I n) => "``n``" + b + "s" + o;
    S f(I n) => h(n) + w + ", " + h(n);
    S c(I n) => t + h(n) + w + d + "\n" + f(n);
    print(d.join { f(99), *(98..2).map(c) }
                + d + t + l + d + "\n" + l + w + ", " + l + d +
                "Go to the store and buy some more, " + h(99) + w + ".");
}

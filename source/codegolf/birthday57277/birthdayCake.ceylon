// Make a birthday cake.
// Question: http://codegolf.stackexchange.com/q/57277/2338
// Answer: http://codegolf.stackexchange.com/a/57347/2338
shared void run() {
    // parse first line of input into an integer.
    if (exists t = process.readLine(), exists n = parseInteger(t)) {
        // define a shorter repeat function
        String r(String s) => s.repeat(n);
        // print 
        print(
            // use then + else operators to distinguish the cases.
            n > 0 then
                    // several layers of candles and cake, each repeated one time,
                    // with maybe one more sign, and then a line break. 
                    r(" $") + "\n" +
                    r(" |") + "\n" +
                    r("--") + "-\n" +
                    r("~~") + "~\n" +
                    r("--") + "-"
                    else (n < 0
                        // negative number → trivial cake.
                        then "---\n~~~\n---"
                        // zero → no cake, but special text
                        else "Congratulations on your new baby! :D"));
    }
}

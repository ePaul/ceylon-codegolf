// A quine program (after removing comments and whitespace)
// Question at http://codegolf.stackexchange.com/q/69/2338
// Answer posted at http://codegolf.stackexchange.com/a/57935/2338
shared void e(){
    // a triple quotation mark, used several times.
    value q="\"\"\"";
    // the top part of the program (up to the = sign).
    value t="""shared void e(){value q="\"\"\"";value t=""";
    // the bottom part of the program (starting from the last ;):
    value b=""";print(t+q+t+q+";value b="+q+b+q+b);}""";
    // print top + quoted top + some middle part + quoted bottom + bottom.
    print(t+q+t+q+";value b="+q+b+q+b);
}
[TValue*] parse(String input) {
    value tokens = expand(input.split(Character.whitespace).map(
            (word) => word.split("()".contains, false, false))).filter(not(String.empty));
    variable [[TValue*]*] stack = [];
    variable [TValue*] currentList = [];
    //print("tokens: ``tokens``");
    for(t in tokens) {
        if(t == "(") {
            stack = stack.withLeading(currentList);
            currentList = [];
        } else if (t == ")") {
            currentList = (stack[0] else []).withTrailing(TList(*currentList));
            stack = stack.rest;
        } else if (exists i = parseInteger(t), i >= 0) {
            currentList = currentList.withTrailing(TInteger(i));
        } else {
            currentList = currentList.withTrailing(TSymbol(t));
        }
        //print("token: »``t``«");
        //print("stack: ``stack``");
        //print("currentList: ``currentList``");
    }
    return currentList;
}

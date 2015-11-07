"Run the module `codegolf.tinylisp62886`."
shared void run() {
    value b = StringBuilder();
    while (exists line = process.readLine()) {
        b.append(line).appendNewline();
    }
    value examples = parse(b.string);
    Context c = GlobalContext(map(defineBuiltIns().map((entry) =>
                    TSymbol(entry.key) -> TBuildIn(entry.item))));
    for (example in examples) {
        try {
            // print("``example`` → ``example.evaluate(c)``");
            print(example.evaluateFully(c));
        } catch (AssertionError ex) {
            print("``example`` → error: »``ex.message``«");
            ex.printStackTrace();
        }
    }
}

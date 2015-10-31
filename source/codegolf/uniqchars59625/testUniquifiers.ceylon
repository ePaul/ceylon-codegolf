shared void run() {
    value inputs = {
        "Type unique chars!",
        """"I think it's dark and it looks like rain", you said""",
        "3.1415926535897932384626433832795",
        "Hello World!",
        "A quick movement of the enemy will jeopardize six gunboats.",
        "Voyez le brick géant que j’examine près du wharf",
        "Schweißgequält zündet Typograf Jakob verflixt öde Pangramme an.",
        "" };
    for (s in inputs) {
        for (f in { `i`, `d`, `n`, `j`, `u` }) {
            print("``f.declaration.name``(»``s``«) → »``f(s)``«");
        }
    }
}

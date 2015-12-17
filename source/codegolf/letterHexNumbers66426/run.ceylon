"Run the module `codegolf.letterHexNumbers66426`."
shared void run() {
    [10, 100, 161, 11259375, 0].map((n)=>n->l(n)).each(print);
    print("----");
    [10, 100, 161, 11259375, 0].map((n)=>n->c(n)).each(print);
}
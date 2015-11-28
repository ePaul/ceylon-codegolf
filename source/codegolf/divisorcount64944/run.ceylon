"Run the module `codegolf.divisorcount64944`."
shared void run() {
    for(c->n in {1->1,2->2, 12 ->6, 30->8, 60->12, 97->2, 100->9}) {
        print("ndiv(``c``)=``d(c)``, expected ``n``.");
    }
}
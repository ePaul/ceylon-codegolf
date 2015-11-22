"Run the module `codegolf.ackermann40141`."
shared void run() {
    if (exists mS = process.arguments.first,
        exists nS = process.arguments.rest.first,
        exists m = parseInteger(mS),
        exists n = parseInteger(nS)) {
        print(a(m, n));
    }
}

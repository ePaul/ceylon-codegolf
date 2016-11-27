
shared void run() {
    // the infinite sequence of integers, starting with 2.
    loop(2)(1.plus)
        // filter by primality (using trial division)
        .filter((c) => !  (2 : c-2).any((d) => c%d < 1) )
        // then take the first n elements
        .take(parseInteger(process.readLine() else "") else 0)
        // print each element
        .each(print);
}
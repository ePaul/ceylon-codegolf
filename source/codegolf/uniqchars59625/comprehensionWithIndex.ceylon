String i(String s) =>
// create a string from an iterable ...
        String {
    // ... build by a comprehension, which iterates over the
    // string's characters with their indexes ...
    for (x->c in s.indexed)
        // ... for each character checking whether its in the string so far ...
        if (!c in s[0:x])
            // ... and including it only if not there.
            c
};

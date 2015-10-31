// unfortunately we need to import the Hashset class.
import ceylon.collection {
    // while doing so, we give it a shorter name, so we don't have to give it twice.
    H=HashSet
}

String n(String i) =>
        // build a string from ...
        String(
               // ... a hashset built with a "named argument list", ...
               H {
                   // ... which actually has no named arguments, but just
                   // an iterable spread into its iterable argument.
                  *i });

// An implementation of a part of the functions of the standard unix utility `cat`.
// This program simply copies bytes from standard input to standard output, ignoring
// any command line arguments.
// Question: http://codegolf.stackexchange.com/q/62230/2338
// My answer: http://codegolf.stackexchange.com/a/62462/2338

// It turns out that there is no pure-Ceylon way of accessing standard input
// in a non-line-based way (which would break when given long input without
// line breaks).
// But when compiling for and running on the JVM, we can use Java's library.

// we need to import stuff from java.lang.  
import java.lang {
    // this has the standard streams in and out.
    S=System,
    // this corresponds to `byte[]`.
    B=ByteArray
}

shared void run() {
    // create an array of size 1.
    B a = B(1);

    // As `in` is a keyword in Ceylon, we need to prefix it
    // with \i to be able to use it as an identifier. Same
    // for `out`. If used those more than once, using an
    // alias import would be better. 
    
    // read one byte from System.in into the array.
    // if nothing was read (→ -1), we stop. 
    while (0 < S.\iin.read(a)) {
        // write the written byte to stdout. 
        S.\iout.write(a);
    }
}

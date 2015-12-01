// print a diagonal cake out of slashes.
//
// Question:  http://codegolf.stackexchange.com/q/65229/2338
// My Answer: http://codegolf.stackexchange.com/a/65267/2338

String s(Integer n) =>
        "\n".join{
            "/\\".repeat(n),
            for (i in 2*n + 1 .. 3)
                "\\".repeat(i % 2)
                        + "/ ".repeat(i / 2)
        };
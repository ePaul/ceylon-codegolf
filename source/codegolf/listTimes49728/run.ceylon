// List all times in the day at a half hour rate
//
// Question:  http://codegolf.stackexchange.com/q/49728/2338
// My answer: http://codegolf.stackexchange.com/a/63695/2338
//
// This function has several solutions. The count mentioned
// includes the boilerplate.

shared void run() {
    // original (101)
    print(",\n".join {
            for (h in 0..23)
                for (m in [0, 3])
                    "'``"``h``".pad(2, '0')``:``m``0'"
        });
    // forth try (102)
    print(",\n".join(
            (0..23)
                *.string
                *.pad(2, '0')
                .map((x) => "'``x``:00',\n'``x``:30'")
        ));
    // second try (104)
    print(",\n".join {
            for (h in 0..23)
                let (x = "``h``".pad(2, '0'))
                    "'``x``:00',\n'``x``:30'"
        });
    // third try (111)
    print(",\n".join(
            (0..23)
                .map((i) => "``i``".pad(2, '0'))
                .map((x) => "'``x``:00',\n'``x``:30'")));
}

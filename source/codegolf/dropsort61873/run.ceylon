"""test program for dropsort."""
shared void run() {
    for (input->expectedOutput in {
        [1, 2, 5, 4, 3, 7] -> [1, 2, 5, 7],
        [10, -1, 12] -> [10, 12],
        [-7, -8, -5, 0, -1, 1] -> [-7, -5, 0, 1],
        [9, 8, 7, 6, 5] -> [9],
        [10, 13, 17, 21] -> [10, 13, 17, 21],
        [10, 10, 10, 9, 10] -> [10, 10, 10, 10] }) {
        value output = d(input);
        print("input: ``input``, output: ``output``,
               expected output: ``expectedOutput``, correct: `` output == expectedOutput ``");
    }
}

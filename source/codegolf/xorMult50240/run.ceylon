"Run the module `codegolf.xorMult50240`."
shared void run() {
    for ([i, j, ex] in {
        [0, 1, 0], [1, 2, 2], [9, 0, 0], [6, 1, 6], [3, 3, 5],
        [2, 5, 10], [7, 9, 63], [13, 11, 127], [5, 17, 85],
        [13, 14, 70], [19, 1, 19], [63, 63, 1365]
    }) {
        value p = x(i, j);
        print("``i`` ``j`` ``p`` | `` ex == p ``");
    }
}

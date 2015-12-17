// XOR-multiplication
//
// Question:  http://codegolf.stackexchange.com/q/50240/2338
// My answer: http://codegolf.stackexchange.com/a/66942/2338

alias I => Integer;

I x(I a, I b) =>
      [
        for (i in 0:64)
            if (b.get(i))
                a * 2^i
      ].fold(0)((y, z) => y.xor(z));

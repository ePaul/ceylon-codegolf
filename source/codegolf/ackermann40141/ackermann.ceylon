// The Ackermann function.
//
// Question:  http://codegolf.stackexchange.com/q/40141/2338
// My answer: http://codegolf.stackexchange.com/a/64502/2338

alias I=>Integer;
I a(I m, I n) =>
        m < 1
        then n + 1
        else (n < 1
            then a(m - 1, 1)
            else a(m - 1, a(m, n - 1)));

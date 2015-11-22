"Run the module `codegolf.functional58588`."
shared void run() {
    I g(I a, I b, I c) => a + b * c;
    I h(I a) => 5*a-1;
    I d(I a, I b) => a * b - 1;
    print(y(g, [1, 2, 3]));
    print(r(5));
    print(m(h, r(5)));
    print(t(h, [4, 7]));
    print(t(h, [7, 5]));
    print(f(d, 2, [1]));
    print(f(d, 2, [1,2]));
    print(f(d, 2, [1,2,3]));
    print(f(d, 2, [1,2,3,4]));
    print(n(h, 2, 4));
}
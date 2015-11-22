// implement functional paradigms
//
// Question: http://codegolf.stackexchange.com/q/58588/2338
// My Answer: http://codegolf.stackexchange.com/a/64515/2338

alias J => Integer;

// map – using a sequence comprehension:
R[] p<A, R>(R(A) g, A[] l) =>
        [for (a in l) g(a)];

// nest – based on fold + range, throwing away the second
//        argument in a proxy function.
A e<A>(A(A) g, A a, J t) =>
        d((A x, J y) => g(x), a, r(t));

// apply – this looks quite heavy due to type safety.
//         This uses the "spread operator" *.
R l<A, R>(Callable<R,A> g, A v)
        given A satisfies Anything[] =>
        g(*v);

// fold – a plain list recursion.
A d<A, O>(A(A, O) g, A a, O[] o) =>
        if (nonempty o) then f(g, g(a, o[0]), o.rest) else a;

// range – based two-limit range
J[] g(J i) =>
        q(1, i);

// two-limit range implemented recursively
J[] q(J i, J j) =>
        j < i then [] else [i, *q(i + 1, j)];

// table – map with an integer range.
//        (Not sure why the min/max parameters need
//         to be passed in one argument.)
R[] b<R>(R(J) g, [J, J] i) =>
        p(g, q(i[0], i[1]));

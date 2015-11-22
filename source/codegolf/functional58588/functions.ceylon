// implement functional paradigms
//
// Question: http://codegolf.stackexchange.com/q/58588/2338
// My Answer: http://codegolf.stackexchange.com/a/64515/2338

alias I => Integer;

// map – based on fold.
R[] m<A, R>(R(A) g, A[] l) =>
        f((R[]x,A y) => x.append([g(y)]), [], l);

// nest – based on fold + range, throwing away the second
//        argument in a proxy function.
A n<A>(A(A) g, A a, I t) =>
        f((A x, I y) => g(x), a, r(t));

// apply – this looks quite heavy due to type safety.
//         This uses the "spread operator" *.
R y<A, R>(Callable<R,A> g, A v)
        given A satisfies Anything[] =>
        g(*v);

// range – based on table (using the identity function)
I[] r(I i) =>
        t((j) => j, [1, i]);

// fold – a plain list recursion.
A f<A, O>(A(A, O) g, A a, O[] o) =>
        if (nonempty o) then f(g, g(a, o[0]), o.rest) else a;

// table – an integer recursion.
//        (Not sure why the min/max parameters need
//         to be passed in one argument.)
R[] t<R>(R(I) g, [I, I] i) =>
        i[1] < i[0] then [] else [g(i[0]), *t(g, [i[0] + 1, i[1]])];

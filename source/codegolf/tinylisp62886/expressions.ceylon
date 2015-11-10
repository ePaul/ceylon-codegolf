//  Tiny Lisp, tiny interpreter
//
// An interpreter for a tiny subset of Lisp, from which most of the
// rest of the language can be bootstrapped.
//
// Question:   http://codegolf.stackexchange.com/q/62886/2338
// My answer:  http://codegolf.stackexchange.com/a/63352/2338
//

// some alias-imports of often used annotation/classes
import ceylon.language {
    sh=shared,
    va=variable,
    fo=formal,
    O=Object
}
import ceylon.language.meta.model {
    F=Function
}

/*

  Overview
 ----------

 Our lisp doesn't distinguish between expression and value – each expression
 is a value by itself, and the result of evaluating an expression (i.e. a
 value) is an expression again (which could possibly be evaluated again).

 Expressions/Values are represented by the interface V, and can be of one of
 these types (implemented by those classes):
   * L – list of values (If nonempty, evaluates by evaluating its
                         first element and then calling that as a
                         function or macro with the remaining arguments.
                         If empty, evaluates to itself.)
   * I – integer (Evaluates to itself)
   * S – symbol (Evaluates to its binding in the current local
                 or global context, or an error if undefined)
   * B – builtin (function or macro) (Can't be evaluated, just called.)

 These also implement the ceylon `equals` method as one would think.

 Builtins and lists can be called as functions or macros (by putting
 something evaluating to them as the first element of a list which
 is being evaluated). Functions get their arguments in evaluated form,
 macros in un-evaluated form (they might evaluate some of them internally).

 For evaluating an expression, you need a context (here represented by the
 interface X). There are two implementations of that, a global context G
 and a local context LC. Variables in the global context can be set,
 the local ones are immutable function parameters.

 Evaluating an expression (with `vO`) might return the final value
 immediately, or a continuation object (Co) when a function/macro call
 is done. In the latter case you'll have to call its step method to do
 the next step – this is tail recursion optimization.
 "Evaluate fully" (`vF`) will follow these continuations until done.

 `p` is the parse function – it will parse a string into a sequence
 of expressions. The `run` function (at the end) is the entry point, it
 reads input, calls the parser, evaluates each expression (in the same
 global context) and prints the results.

 */

// context

interface X {
    sh fo V v(S t);
    sh fo G g;
}
// global (mutable) context, with the buildins
class G(va Map<S,V> m) satisfies X {
    // get entry throws error on undefined variables.
    v(S t) => m[t] else nV;
    g => this;
    sh S d(S s, V v) {
        // error when already defined
        assert (!s in m);
        // building a new map is cheaper (code-golf wise) than having a mutable one.
        m = map { s->v, *m };
        return s;
    }
}

// This is simply a shorter way of writing "this is not an allowed operation".
// It will throw an exception when trying to access it.
// nV stands for "no value".
V nV => nothing;

// local context
class LC(G c, Map<S,V> m) satisfies X {
    g => c;
    v(S t) => m[t] else g.v(t);
    // sh actual String string => "[local: ``m``, global: ``g``]";
}

// continuation or value
alias C => V|Co;

// continuation
interface Co {
    sh fo C st();
}

// value
interface V {
    // use this as a function and call with arguments.
    // will not work for all types of stuff.
    sh fo C l(X c, V[] a);
    // check the truthiness. Defaults to true, as
    // only lists and integers can be falsy.
    sh default Boolean b => 0 < 1;
    // evaluate once (return either a value or a continuation).
    // will not work for all kinds of expression.
    sh fo C vO(X c);
    /// evaluate fully
    sh default V vF(X c) {
        va C v = vO(c);
        while (is Co n = v) {
            v = n.st();
        }
        assert (is V r = v);
        return r;
    }
}
class L(sh V* i) satisfies V {

    vO(X c) => if (nonempty i) then i[0].vF(c).l(c, i.rest) else this;
    equals(O o) => if (is L o) then i == o.i else 1 < 0;
    b => !i.empty;
    string => "(``" ".join(i)``)";
    hash => i.hash;

    sh actual C l(X c, V[] p) {
        value [h, ns, x] =
                i.size < 3
                then [f, i[0], i[1]]
                else [m, i[1], i[2]];
        // parameter names – either a single symbol, or a list of symbols.
        // If it is a list, we filter it to throw out any non-symbols.
        // Should throw an error if there are any, but this is harder.
        value n = if (is L ns) then [*ns.i.narrow<S>()] else ns;
        assert (is S|S[] n, is V x);
        V[] a = h(c, p);

        // local context
        LC lC = if (is S n) then
            LC(c.g, map { n -> L(*a) })
        else
            LC(c.g, map(zipEntries(n, a)));
        // return a continuation instead of actually
        // calling it here, to allow stack unwinding.
        return object satisfies Co {
            st() => x.vO(lC);
        };
    }
}

// symbol
class S(String n) satisfies V {
    // evaluate: resolve
    vO(X c) => c.v(this);
    // call is not allowed
    l(X c, V[] a) => nV;
    // equal if name is equal
    equals(O o) => if (is S o) then n == o.n else 1 < 0;
    hash => n.hash;
    string => n;
}

// integer
class I(sh Integer i) satisfies V {

    vO(X c) => this;
    l(X c, V[] a) => nV;
    equals(O o) => if (is I o) then i == o.i else 1 < 0;
    hash => i;
    b => !i.zero;
    string => i.string;
}

// argument handlers for functions or macros
V[] f(X c, V[] a) => [for (v in a) v.vF(c)];
V[] m(X c, V[] a) => a;

// build-in functions
// construct
L c(X c, V h, L t) => L(h, *t.i);
// head
V h(X c, L l) => l.i[0] else L();
// tail
V t(X c, L l) => L(*l.i.rest);
// subtract
I s(X c, I f, I s) => I(f.i - s.i);
// lessThan
I l(X c, I f, I s) => I(f.i < s.i then 1 else 0);
// equal
I e(X c, V v1, V v2) => I(v1 == v2 then 1 else 0);
// eval (returns potentially a continuation)
C v(X c, V v) => v.vO(c);

// build-in macros
// quote
V q(X c, V a) => a;
// if (also returns potentially a continuation)
C i(X c, V d, V t, V f) => d.vF(c).b then t.vO(c) else f.vO(c);
// define symbol in global context
S d(X c, S s, V x) => c.g.d(s, x.vF(c));

// buildin function or macro, made from a native function and an argument handler
class B<A>(F<C,A> nat, V[](X, V[]) h = f)
        satisfies V
        given A satisfies [X, V+] {
    vO(X c) => nV;
    string => nat.declaration.name;
    // this "apply" is a hack which breaks type safety ...
    // but it will be checked at runtime.
    l(X c, V[] a) => nat.apply(c, *h(c, a));
}

// define buildins
{<S->V>*} b => {
    S("c") -> B(`c`),
    S("h") -> B(`h`),
    S("t") -> B(`t`),
    S("s") -> B(`s`),
    S("l") -> B(`l`),
    S("e") -> B(`e`),
    S("v") -> B(`v`),
    S("q") -> B(`q`, m),
    S("i") -> B(`i`, m),
    S("d") -> B(`d`, m)
};

// parses a string into a list of expressions.
[V*] p(String inp) {
    // split string into tokens (retain separators, don't group them –
    // whitespace and empty strings will be sorted out later in the loop)
    value ts = inp.split(" \n()".contains, 1 < 0, 1 < 0);
    // stack of not yet finished nested lists, outer most at bottom
    va [[V*]*] s = [];
    // current list, in reverse order (because appending at the start is shorter)
    va [V*] l = [];
    for (t in ts) {
        if (t in " \n") {
            // do nothing for empty tokens
        } else if (t == "(") {
            // push the current list onto the stack, open a new list.
            s = [l, *s];
            l = [];
        } else if (t == ")") {
            // build a lisp list from the current list,
            // pop the latest list from the stack, append the created lisp list.
            l = [L(*l.reversed), *(s[0] else [])];
            s = s.rest;
        } else if (exists i = parseInteger(t), i >= 0) {
            // append an integer to the current list.
            l = [I(i), *l];
        } else {
            // append a symbol to the current list.
            l = [S(t), *l];
        }
    }
    return l.reversed;
}

// Runs the interpreter.
// This handles input and output, calls the parser and evaluates the expressions.
sh void run() {
    va value u = "";
    while (exists l = process.readLine()) {
        u = u + l + "\n";
    }
    V[] e = p(u);
    // create global context
    X c = G(map(b));
    // iterate over the expressions, ...
    for (v in e) {
        // print("  '``v``' → ...");
        // ... evaluate each (fully) and print the result.
        print(v.vF(c));
    }
}

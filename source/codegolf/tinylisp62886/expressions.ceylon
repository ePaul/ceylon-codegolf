import ceylon.language.meta.model {
    Function
}

interface Context {
    shared formal TValue getVariable(TSymbol t);
    shared formal GlobalContext globalContext;
}

class GlobalContext( Map<TSymbol,TValue> builtIns) satisfies Context {
    variable Map<TSymbol,TValue> m = builtIns;
    
    shared actual TValue getVariable(TSymbol t) {
        value r = m[t];
        if (exists r) {
            return r;
        } else {
            throw AssertionError("Symbol ``t`` is not defined!");
        }
    }
    
    shared actual GlobalContext globalContext => this;
    
    shared void define(TSymbol s, TValue v) {
        assert (!s in m);
        m = map { s->v, *m };
    }
    shared actual String string => m.string;
}

class LocalContext(shared actual GlobalContext globalContext, Map<TSymbol,TValue> m)
        satisfies Context {
    shared actual TValue getVariable(TSymbol t) => m[t] else globalContext.getVariable(t);
    shared actual String string => "[local: ``m``, global: ``globalContext``]";
}

interface TValue {
    shared formal TValue|Continuation evaluate(Context c);
    shared formal TValue|Continuation call(Context c, [TValue*] arguments);
    shared formal Boolean truthy;
    shared default TValue evaluateFully(Context c) {
        print("   evaluating ``this`` fully in ``c`` ...");
        value input = evaluate(c);
        print("   first level eval: ``input``");
        if (is TValue input) {
            return input;
        }
        
        variable Continuation next = input;
        while (true) {
            value nextOrResult = next.nextStep();
            print("   nextOrResult: ``nextOrResult``");
            if (is TValue nextOrResult) {
                return nextOrResult;
            } else {
                next = nextOrResult;
            }
        }
    }
}
class TList(shared TValue* items) satisfies TValue {
    shared actual TValue|Continuation evaluate(Context c) =>
            if (nonempty items)
    then items.first.call(c, items.rest)
    else this;
    shared actual TValue|Continuation call(Context c, [TValue*] arguments) =>
            callable(items).call(c, arguments);
    shared actual Boolean equals(Object that) =>
            if (is TList that) then items == that.items else false;
    shared actual Boolean truthy => !items.empty;
    shared actual String string => "(``" ".join(items)``)";
    hash => items.hash;
}
class TSymbol(shared String name) satisfies TValue {
    shared actual TValue evaluate(Context c) => c.getVariable(this);
    shared actual TValue|Continuation call(Context c, [TValue*] arguments) =>
            c.getVariable(this).call(c, arguments);
    shared actual Boolean equals(Object that) {
        if (is TSymbol that) {
            return name == that.name;
        } else {
            return false;
        }
    }
    hash => name.hash;
    shared actual Boolean truthy => true;
    shared actual String string => name;
}
class TInteger(shared Integer intValue) satisfies TValue {
    shared actual TValue evaluate(Context c) => this;
    
    shared actual TValue|Continuation call(Context c, [TValue*] arguments) {
        "an integer can't be called!"
        assert (false);
    }
    shared actual Boolean equals(Object that) =>
            if (is TInteger that) then intValue == that.intValue else false;
    hash => intValue;
    shared actual Boolean truthy => !intValue.zero;
    shared actual String string => intValue.string;
}

class TBuildIn(TCallable callable) satisfies TValue {
    shared actual TValue|Continuation call(Context c, TValue[] arguments) => callable.call(c, arguments);
    evaluate(Context c) => nothing;
    truthy => nothing;
    string => callable.string;
}

interface Continuation {
    shared formal TValue|Continuation nextStep();
}

interface TCallable {
    shared formal TValue|Continuation call(Context c, [TValue*] arguments);
}

TCallable callable([TValue*] list) {
    print("   building a callable from ``list`` ...");
    TCallable constructor(TSymbol|[TSymbol*] paramNames, TValue expression);
    TValue? params;
    TValue? expression;
    switch (list.size)
    case (2) {
        constructor = TUserFunction;
        params = list[0];
        expression = list[1];
    }
    case (3) {
        constructor = TUserMacro;
        params = list[1];
        expression = list[2];
    }
    else {
        throw AssertionError("Not a function or macro: ``list``");
    }
    assert (exists expression);
    value paramNames = if (is TList params) then params.items else params;
    assert (is TSymbol|[TSymbol*] paramNames);
    return constructor(paramNames, expression);
}

interface TFunction satisfies TCallable {
    shared formal Continuation|TValue reallyCall(Context c, TValue[] arguments);
    shared actual TValue|Continuation call(Context c, TValue[] arguments) =>
            reallyCall(c, [for (a in arguments) a.evaluateFully(c)]);
}

abstract class TUserCallable(TSymbol|[TSymbol*] paramNames, TValue expression) {
    shared Continuation makeEvalContinuation(Context c, TValue[] evaluatedArguments) {
        LocalContext newContext;
        if (is TSymbol paramNames) {
            newContext = LocalContext(c.globalContext, map { paramNames -> TList(*evaluatedArguments) });
        } else {
            newContext = LocalContext(c.globalContext, map(zipEntries(paramNames, evaluatedArguments)));
        }
        return object satisfies Continuation {
            shared actual TValue|Continuation nextStep() => expression.evaluate(newContext);
            shared actual String string => "[»``expression``« in ``newContext``]";
        };
    }
}

class TUserFunction(TSymbol|[TSymbol*] paramNames, TValue expression)
        extends TUserCallable(paramNames, expression)
        satisfies TFunction {
    shared actual Continuation|TValue reallyCall(Context c, TValue[] arguments) =>
            makeEvalContinuation(c, arguments);
}

class TUserMacro(TSymbol|[TSymbol*] paramNames, TValue expression)
        extends TUserCallable(paramNames, expression) satisfies TCallable {
    shared actual TValue|Continuation call(Context c, TValue[] arguments) =>
            makeEvalContinuation(c, arguments);
}

TCallable makeFunction<Arguments>(Function<TValue|Continuation,Arguments> nativeFun)
        given Arguments satisfies [Context, TValue+]
        => object satisfies TFunction {
    string => nativeFun.declaration.name;
    shared actual Continuation|TValue reallyCall(Context c, TValue[] arguments)
            => nativeFun.apply(c, *arguments);
};
TCallable makeMacro<Arguments>(Function<TValue|Continuation,Arguments> nativeFun)
        given Arguments satisfies [Context, TValue+]
        => object satisfies TCallable {
    string => nativeFun.declaration.name;
    shared actual Continuation|TValue call(Context c, TValue[] arguments)
            => nativeFun.apply(c, *arguments);
};

// build-in functions
TList construct(Context c, TValue head, TList tail) => TList(head, *tail.items);
TValue head(Context c, TList list) => list.items[0] else nothing;
TValue tail(Context c, TList list) => TList(*list.items.rest);
TInteger subtract(Context c, TInteger first, TInteger second)
        => TInteger(first.intValue - second.intValue);
TInteger lessThan(Context c, TInteger first, TInteger second)
        => TInteger(first.intValue.smallerThan(second.intValue) then 1 else 0);
TInteger equals(Context c, TValue first, TValue second)
        => TInteger(first == second then 1 else 0);
TValue|Continuation eval(Context c, TValue val) => val.evaluate(c);

// build-in macros

TValue quote(Context c, TValue arg) => arg;
TValue|Continuation iff(Context c, TValue condition, TValue ifTrue, TValue ifFalse) =>
        condition.evaluateFully(c).truthy then ifTrue.evaluate(c) else ifFalse.evaluate(c);
TValue define(Context c, TSymbol s, TValue expr) {
    value val = expr.evaluateFully(c);
    c.globalContext.define(s, val);
    return s;
}

{<String->TCallable>*} defineBuiltIns() => {
    "c" -> makeFunction(`construct`),
    "h" -> makeFunction(`head`),
    "t" -> makeFunction(`tail`),
    "s" -> makeFunction(`subtract`),
    "l" -> makeFunction(`lessThan`),
    "e" -> makeFunction(`equals`),
    "v" -> makeFunction(`eval`),
    "q" -> makeMacro(`quote`),
    "i" -> makeMacro(`iff`),
    "d" -> makeMacro(`define`)
};

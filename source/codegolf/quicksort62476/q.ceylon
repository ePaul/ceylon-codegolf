// numerical (randomized) Quicksort. 
// Question: http://codegolf.stackexchange.com/q/62476/2338
// My Answer: http://codegolf.stackexchange.com/a/62482/2338
import ceylon.math.float {
    r=random
}

{Float*} q({Float*} l) =>
        if (exists p = l.getFromFirst((r() * l.size).integer))
        then q(l.filter((e) => e < p)).chain { p, *q(l.filter((e) => p < e)) }
        else [];

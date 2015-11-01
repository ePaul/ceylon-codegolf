// a non-random version of quicksort.
{Float*} r({Float*} l) =>
        if (exists p = l.first)
        then r(l.filter((e) => e < p)).chain { p, *r(l.filter((e) => p < e)) }
        else [];

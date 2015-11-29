// find most common element of a list.
//
// Question:  http://codegolf.stackexchange.com/q/42529/2338
// My answer: http://codegolf.stackexchange.com/a/65214/2338

E m<E>(E+ l) =>
        (l
        .frequencies()
        .max(increasingItem)
            else nothing)
    .key;

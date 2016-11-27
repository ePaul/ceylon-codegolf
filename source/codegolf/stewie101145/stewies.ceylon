// Print the first n entries of the Stewies sequence with given starting entries.
//
// Question:  http://codegolf.stackexchange.com/q/101145/2338
// My answer: http://codegolf.stackexchange.com/a/101251/2338

// Declare a function `s` which takes three integers, and returns a tuple
// of floats. (The more common syntax for the return value is [Float*],
// but Float[] is shorter.)
Float[] s(Integer a, Integer b, Integer n)
       // it is implemented by evaluating the following expression for each call.
		 =>
		// start a loop with ...
		loop([
	          // ... float versions of the integers, and ...
	          a.float, b.float,
              // ... an infinite sequence of the four operators, ever repeating.
              // I needed the `.rest` here so the whole thing gets a {...*} type
              // instead of {...+}, which doesn't fit to what o.rest returns.
              // Each operator has the type Float(Float)(Float), i.e. you apply
              // it twice to one float each to get a Float result.
              [Float.divided, Float.plus, Float.times, Float.minus].cycled.rest])
               // in each iteration of the loop, map the triple of two numbers
               // and a sequence of operators to a triple of ... 
            (([x, y, o]) => [
               // the second number, 
                y,
               //the result of the first operator with both numbers
               // (using this "else nothing" here to convince the
               //  compiler that o.first is not null),
                   (o.first else nothing)(x)(y),
               // and the sequence of operators without its first element.
               // (that one unfortunately has a {...*} type, i.e. a possibly
               //  empty sequence.)
                                                 o.rest])
		    // now we got an infinite sequence of those triples.
			// We just want the first n of them ...
				.take(n)
			// and of each triple just the first element.
            // (The *. syntax produces a tuple, non-lazily.
            //  We could also have used .map((z) => z.first)
			//  or .map(Iterable.first) or .map((z) => z[0]), each of
			//  which would return a (lazy) sequence, but they all would be
            //  longer.)
				*.first;
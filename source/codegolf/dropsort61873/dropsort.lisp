(q(
// Dropsort: "sorts" a sequence of integers by dropping all elements which don't fit.
//
// Question:  http://codegolf.stackexchange.com/q/61808/2338
// My answer: http://codegolf.stackexchange.com/a/63633/2338
//
// Input and output are (possibly empty) lists of integers.
// `ds` is the actual sorting function.
// dropsort-examples.lisp runs the examples from the question.
))
(d r
   (q((m a)
      (i a
         (i (l (h a) m)
            (r m (t a))
            (c (h a)
               (r (h a) (t a))
             )
          )
         ()
       )
   ) )
 )
(d ds
  (q(
      (b)
      (i b
        (c (h b)
           (r (h b) (t b))
         )
        ()
       )
   ) )
 )

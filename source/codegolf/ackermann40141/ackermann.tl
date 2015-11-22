(q (
 The Ackermann function.
 
 Question:  http://codegolf.stackexchange.com/q/40141/2338
 My Answer: http://codegolf.stackexchange.com/a/64503/2338
))

(d A
   (q( (m n)
       (i m
          (i n
             (A (s m 1)
                (A m
                   (s n 1)
                 )
              ) 
             (A (s m 1)
                1
              )
           )
          (s n
             (s 0 1)
           )
        )
    ) )
 )
(A 3 5)
(A 2 164)
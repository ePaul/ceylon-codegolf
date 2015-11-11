(q (
 "Curried addition" with two different programming languages.

  Question:  http://codegolf.stackexchange.com/q/63391/2338
  My Answer: http://codegolf.stackexchange.com/a/63552/2338
 
  Tiny Lisp → Ceylon
))

(d u(q((n)(c(q(Integer x))(c(q =>)(c(c(q x+)(c n()))()))))))

(d curry-add
   (q ( (n)
        (c (q (Integer x))
           (c (q =>)
              (c (c (q x+)
                    (c n
                       ()
                     )
                  )
                 ()
               )
            )
         )
      )
    )
 )
//  (curry-add 7)
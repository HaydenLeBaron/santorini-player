#|This file contains auxilary functions for make-turn.rkt|#

#lang racket

(provide cspout->setofboard
         rand-elt-of
         listof-set->set
         )


#|Takes the output of a csp solver function and converts it to a
set of boards.|#
(define (cspout->setofboard cspout)
  (void)
  )


#| Pick a random element from a set s |#
(define (rand-elt-of s)
  (list-ref s (random (length (set->list s)))))


#|Takes a list of sets `los`. Returns a set containing all elements
of each set in the list. |#
(define (listof-set->set los)
  (void)
  )


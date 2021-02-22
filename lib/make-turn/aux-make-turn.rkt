#|This file contains auxilary functions for make-turn.rkt|#

#lang racket

(provide rand-elt-of
         listof-set->set
         )


#| Pick a random element from a set s |#
;; TODO: DELETEME?
(define (rand-elt-of s)
  (list-ref s (random (length (set->list s)))))


#|Takes a list of sets `los`. Returns a set containing all elements
of each set in the list. |#
(define (listof-set->set los)
  (void)
  )


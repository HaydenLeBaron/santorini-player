#|This file contains auxilary functions for make-turn.rkt|#

#lang racket

(require "../board.rkt")
(provide rand-elt-of
         strip-unnecessary-keys)


#| Pick a random element from a set s |#
;; TODO: DELETEME?
(define (rand-elt-of s)
  (list-ref s (random (length (set->list s)))))


#|Returns an identical board (hash) except with only the required
keys and associated values needed to create the JSON represenation.|#
(define (strip-unnecessary-keys board)
  (hash
   'spaces (boardq-spaces board)
   'players (boardq-players board)
   'turn (boardq-turn board)))


#lang racket

(require "make-turn/aux-make-turn.rkt")
(provide choose-best-board)

#|Take a board list as input and choose the board
that is most advantageous for the player whose turn it is
(all boards in the board-set encode the same player whose
turn it is.)|#
(define (choose-best-board board-list)
  ;; TODO: implement for real
  (rand-elt-of board-list)
  )

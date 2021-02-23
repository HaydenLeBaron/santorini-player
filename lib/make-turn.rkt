#|This file contains the make-turn function.|#

#lang racket

(require "make-turn/aux-make-turn.rkt"
         "make-turn/choose-best-board.rkt"
         "make-turn/cspsolve-buildstep.rkt"
         "make-turn/cspsolve-movestep.rkt"
         "make-turn/get-wins-from-boardlist.rkt")

(provide make-turn)

#|"Takes a turn" on the board. In other words,
Takes a valid board as input, and returns
another board that represents the input board
transformed in such a way that a valid turn has
been made (in accordance with the rules of Santorini.)|#
(define (make-turn board)
  (let* ([post-move-board-list (cspsolve-movestep board)]
         [winning-board-list (get-wins-from-boardlist post-move-board-list)])
    (if (not (empty? winning-board-list))
        (strip-unnecessary-keys (car winning-board-list))
        (choose-best-board
         (flatten (map cspsolve-buildstep post-move-board-list))))))


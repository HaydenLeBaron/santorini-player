#|This file contains the make-turn function.|#

#lang racket

(require "make-turn/aux-make-turn.rkt"
         "make-turn/choose-best-board.rkt"
         "make-turn/cspsolve-buildstep.rkt"
         "make-turn/cspsolve-movestep.rkt"
         "make-turn/get-wins-from-boardset.rkt")



#|"Takes a turn" on the board. In other words,
Takes a valid board as input, and returns
another board that represents the input board
transformed in such a way that a valid turn has
been made (in accordance with the rules of Santorini.)|#
(define (make-turn board)
  (let ([post-move-board-set (cspout->setofboard (cspsolve-movestep board))])
    (let ([winning-board-set (get-wins-from-boardset post-move-board-set)])

      (if (not (empty? winning-board-set))
        (rand-elt-of winning-board-set)
        (choose-best-board (cspout->setofboard
                            (listof-set->set
                             (map cspsolve-buildstep
                                  (set->list post-move-board-set)))))))))


;; TODO: implement listof-set->set (or find one that exists)


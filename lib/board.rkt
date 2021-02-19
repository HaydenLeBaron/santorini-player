#|This file contains a model of a board, which contains all of the state
of a Santorini game in a single snapshot. A board knows about:
- the spaces of the game's grid
- the position of the players' tokens
- which player's turn it is
- the position and level of each tower.
- the total number of elapsed turns since the start of the game.

This file also contains functions for querying the board. Such
functions are named boardq-*. |#

#lang racket

(provide boardq-turn
         boardq-spaces
         boardq-players
         boardq-my-tokens
         boardq-enemy-tokens
         boardq-levelof-space
         boardq-space-capped?
         boardq-adjacent-spaces)



;; * A board is a dictionary with three keys:
;;   * "turn" mapped to a nonnegative integer, where 0 corresponds to the first turn of the game
;;   * "spaces" mapped to an array of 5 rows in order
;;   * "players" mapped to an array of 2 players, where the first player in the array takes the next turn
;; * A row is an array of 5 levels, one for each column in order
;; * A level is 0, 1, 2, 3, or 4
;; * A player is an array of 2 spaces, where the order of the spaces in the array does not matter
;; * A space is an array of 2 dimensions, row then column
;; * A dimension is 1, 2, 3, 4, or 5


(define (boardq-turn board)
  (hash-ref board 'turn))

(define (boardq-spaces board)
  (hash-ref board 'spaces))

(define (boardq-players board)
  (hash-ref board 'players))

(define (boardq-my-tokens board)
  (car (hash-ref board 'players)))

(define (boardq-enemy-tokens board)
  (cadr (hash-ref board 'players)))

;; space ordered pair is 1-idxed
(define (boardq-levelof-space board row col)
  (list-ref (list-ref (boardq-spaces board) (- row 1)) (- col 1)))

(define (boardq-space-capped? board row col)
  (= (boardq-levelof-space board row col) 4))


;; space ordered pair is 1-idxed
(define (boardq-adjacent-spaces board row col)
  (filter
   (lambda (l) (not (or (= (list-ref l 0) 0)  (= (list-ref l 0) 6)
                        (= (list-ref l 1) 0)  (= (list-ref l 1) 6))))
   (list
    `(,(+ row 1) ,col)
    `(,(+ row 1) ,(+ col 1))
    `(,row ,(+ col 1))
    `(,(- row 1) ,(+ col 1))
    `(,(- row 1) ,col)
    `(,(- row 1) ,(- col 1))
    `(,row ,(- col 1))
    `(,(+ row 1) ,(- col 1)))))

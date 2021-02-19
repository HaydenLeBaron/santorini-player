#|This file contains the io functions that encapsulate making a turn.|#

#lang racket

(require json)

(provide jsonstr->board
         board->stdout)


#|Takes a json-str representation of a board, and
returns a board representation. |#
(define (jsonstr->board board)
  ;; Convert read-in board from hasheq to hash
  (make-hash (hash->list (string->jsexpr board))))

#|Takes a board representation and flushes it to stdout.
THIS FUNCTION IS IN CHARGE OF FLIPPING THE ORDER OF THE PLAYERS
TO INDICATE A SWITCH IN TURNS.|#
;; TODO: May also have to do some work switching key types since this is not longer a hasheq
(define (board->stdout board)
  (print (jsexpr->string (swap-players board))))

#|Return a new board that is identical to the last
board except that the players are in swapped order.|#
(define (swap-players board)
  (raise 'NotImplementedError))

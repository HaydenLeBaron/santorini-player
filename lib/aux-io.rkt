#|This file contains the io functions that encapsulate making a turn.|#

#lang racket

(require json
         "board.rkt"
         )

(provide jsonstr->board
         stdin->board
         board->stdout)

;(define-values (in out) (make-pipe))


#|Takes a json string representation of a board, and
returns a board representation. |#
(define (jsonstr->board json-str)
  ;; Convert read-in board from hasheq to hash
  (make-hash (hash->list (string->jsexpr json-str))))

(define (stdin->board)
  (let ([a-jsexpr (read-json)])
    (if (hash? a-jsexpr) (make-hash (hash->list a-jsexpr)) a-jsexpr)))


#|Takes a board representation and flushes it to stdout.
THIS FUNCTION IS IN CHARGE OF FLIPPING THE ORDER OF THE PLAYERS
TO INDICATE A SWITCH IN TURNS.|#
(define (board->stdout board)
  (begin
    (if (hash? board)
        (write-json (swap-players board))
        (write-json board))
    (flush-output)))


#|Return a new board that is identical to the last
board except that the players are in swapped order.|#
(define (swap-players board)
  (hasheq
   'spaces (boardq-spaces board)
   'players (list (boardq-enemy-player board) (boardq-my-player board))
   'turn (boardq-turn board)))

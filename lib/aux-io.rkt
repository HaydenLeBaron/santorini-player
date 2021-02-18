#|This file contains the io functions that encapsulate making a turn.|#

#lang racket

(require json)

(provide json->board
         board->stdout
         board->json)


#|Takes a json-str representation of a board, and
returns a board representation. |#
(define (json->board json-str)
  (string->jsexpr json-str))



#|Takes a board representation and returns a JSON string
representation of that board.|#
(define (board->json board)
  (jsexpr->string board))



#|Takes a board representation and flushes it to stdout|#
(define (board->stdout board)
  (print (board->json board)))

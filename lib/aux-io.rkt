#|This file contains the io functions that encapsulate making a turn.|#

#lang racket

(provide json->board
         board->stdout
         board->json)


#|Takes a json-str representation of a board, and
returns a board representation|#
(define (json->board json-str)
  ;; TODO: implement
  ""
  )


#|Takes a board representation and flushes it to stdout|#
(define (board->stdout board)
  ;; TODO: implement
  ;; print(board->json(board))

  (print "Not yet implemented"))


#|Takes a board representation and returns a JSON string
representation of that board.|#
(define (board->json board)
  ;; TODO: Implement
  "Not yet implemented")

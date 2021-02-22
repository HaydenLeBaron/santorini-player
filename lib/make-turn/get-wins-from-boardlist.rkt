#lang racket


(require "../board.rkt")
(provide get-wins-from-boardlist)

#|Take a set of boards and return a set of boards such that the game is won|#
;; TODO: write unit tests
(define (get-wins-from-boardlist boardlist)
  (let ([isa-winning-board?
         (λ (board)
           ;; Is there a friendly token at a height of 3?
           (let ([mytok1 (car (boardq-my-tokens board))]
                 [mytok2 (cadr (boardq-my-tokens board))])
             (or
              (= 3 (boardq-levelof-space board (car mytok1) (cadr mytok1)))
              (= 3 (boardq-levelof-space board (car mytok2) (cadr mytok2))))))])
      (filter
       isa-winning-board?
       boardlist)))



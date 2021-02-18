#lang racket

(require json)
(provide handle-beginning-game-cases)

;; TODO: Write unit tests for this function
#|Takes a board, and handles one of the beginning-game cases
Returns a resulting board.|#
(define (handle-beginning-game-cases board)
  (match board
    ;; If board contains only an array of 0 players,
    ;; this program is the first player and should
    ;; return an array of 1 player to represent
    ;; the starting placement of the program's tokens.
    ;; STRATEGY: place 1 builder in the middle, and the other close by.
    ['()
     (let ([builder-1-pos (list 3 3)]
           [builder-2-pos (list 4 5)])
         (list builder-1-pos builder-2-pos))]

    ;; If the board contains an array with 1 player, this program is the second player. The given
    ;; player represents the opponent's tokens. The program should now return an  array of 2 players.
    ;; The first player in the result array is the same  as the provided one.
    ;; The second player represent the starting placement of this program's tokens.
    [(list (list r1 c1) (list r2 c2))
     (let* ([spaces (cartesian-product (range 1 6) (range 1 6))]
           [pick-elt (λ (l) (list-ref l (random (length l))))])
      (let* ([get-first-space-options
            (lambda (l)
              (not (or (equal? l (list r1 c1))
                        (equal? l (list r2 c2)))))])
       (let* ([first-space-options (filter get-first-space-options spaces)]
             [builder-1-pos (pick-elt first-space-options)]
             [get-second-space-options
              (lambda (l)
                (not (or (equal? l (list r1 c1))
                         (equal? l (list r2 c2))
                         (equal? l builder-1-pos))))]
             [second-space-options
              (filter get-second-space-options spaces)]
             [builder-2-pos (pick-elt second-space-options)])

                 (list (list (list r1 c1) (list r2 c2))
                       (list builder-1-pos builder-2-pos)))))]

    ;; Else, this is not a beginning turn. Return the input board without doing anything.
    [ANY board]))



;; Manual testing
(handle-beginning-game-cases (read-json))

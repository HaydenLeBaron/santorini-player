#lang racket

(require json)
(provide handle-beginning-game-cases)

;; TODO: Write unit tests for this function
#|Takes a board, and handles one of the beginning-game cases
Returns a resulting board.|#
(define (handle-beginning-game-cases board)
  (match board

    ;; Handle 2 player's, no board case => turn into full empty board at turn 0
    [(list (hash-table ('card my-card-str)
                       ('tokens (list (list p1r1 p1c1) (list p1r2 p1c2))))
           (hash-table ('card enmy-card-str)
                       ('tokens (list (list p2r1 p2c1) (list p2r2 p2c2)))))
     (hash
      'spaces (list '(0 0 0 0 0) '(0 0 0 0 0) '(0 0 0 0 0) '(0 0 0 0 0) '(0 0 0 0 0))
      'players  (list (hash 'card my-card-str
                            'tokens (list (list p1r1 p1c1) (list p1r2 p1c2)))
                      (hash 'card enmy-card-str
                            'tokens (list (list p2r1 p2c1) (list p2r2 p2c2))))
      'turn 0)]
    ;; handle 1 player and 1 pre-player case
    [(list
      (hash-table ('card my-card-str))
      (hash-table ('card enmy-card-str)
                  ('tokens (list (list r1 c1) (list r2 c2)))))
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

         (list (hash 'card enmy-card-str
                     'tokens (list (list r1 c1) (list r2 c2)))
               (hash 'card my-card-str
                     'tokens (list builder-1-pos builder-2-pos))))))]
    ;; If board contains only an array of 2 pre-players,
    ;; this program is the first player and should
    ;; return an array of 1 player to represent
    ;; the starting placement of the program's tokens.
    ;; STRATEGY: place 1 builder in the middle, and the other close by.
    [(list (hash-table ('card my-card-str))
           (hash-table ('card enmy-card-str)))
     (let ([builder-1-pos (list 3 3)]
           [builder-2-pos (list 4 5)])
       (list
        (hash 'card enmy-card-str)
        (hash 'card my-card-str 'tokens (list builder-1-pos builder-2-pos))))]



    ;; Else, this is not a beginning turn. Return the input board without doing anything.
    [ANY board]))

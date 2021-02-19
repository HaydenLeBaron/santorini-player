#lang racket

(require "../board.rkt")

(provide cspsolve-buildstep)


#|Takes a single board as input. Calculates every possible
build step that could be taken, then returns a set of all
possible boards.|#
;; TODO: write tests
(define (cspsolve-buildstep board my-moved-tok my-other-tok)
  (let* ([enmytok1 (car (boardq-enemy-tokens board))]
         [enmytok2 (cadr (boardq-enemy-tokens board))]
         [spaces-my-moved-tok-can-build-on
          (get-spaces-tok-can-build-on my-moved-tok
                                       my-other-tok
                                       enmytok1
                                       enmytok2
                                       board)])
    (let ([new-spaces-lists
           (gen-valid-new-spaces-lists spaces-my-moved-tok-can-build-on
                                       board)])
      (map (λ (new-spaces-list)
             (hash 'players (boardq-players board)
                   'spaces new-spaces-list
                   'turn (boardq-turn board))) ;; Turn was incremented during the move step
           new-spaces-lists))))

#|Takes a list of coordinate pairs `build-candidate-coods` as well as a board
representation `board`, and returns a list of list of lists where each middle list
represents a 'spaces list in a new board.

EX:
board ==
"{
...
\"spaces\":[[0, 0, 0, 0, 2],
            [1, 1, 2, 0, 0],
            [1, 0, 0, 3, 0],
            [0, 0, 3, 0, 0],
            [0, 0, 0, 1, 4]],
...
}"

WE ARE BUILDING FROM (3, 3)
=> `build-candidate-coods` ==
      (list '(3 4) '(4 4) '(4 3) '(4 2) '(3 2) '(2 2) '(2 3) '(2 4))

So we have to increment each build candidate cood.
=>
ret == (. indicates same as before)
       (x indicates same as before, but also build candidate)
(list ;; outer list

(list ;; middle list
 '(. . . . .)
 '(. 2 x x .)
 '(. x . x .)
 '(. x x x .)
 '(. . . . .)
 )

(list
 '(. . . . .)
 '(. x 3 x .)
 '(. x . x .)
 '(. x x x .)
 '(. . . . .)
 )

....

)|#
;; TODO: write tests
(define (gen-valid-new-spaces-lists build-candidate-coods board)
  (map (lambda (cood)
         (change-at (boardq-spaces board)
                    (car cood) (cadr cood)
                    (+ 1 (boardq-levelof-space board (car cood) (cadr cood)))))
       build-candidate-coods))

;; [Listof [Listof Any]] Nat Nat Any -> [Listof [Listof Any]]
;; changes the element at (`r`, `c`) position in `l` (1-idxed) to `to`
(define (change-at l r c to)
  (for/list ([row l] [i (length l)])
    (for/list ([e row] [j (length row)])
      (if (and (= (- r 1) i) (= (- c 1) j))
          to
          e))))



#|Return a list of ordered pairs (coods are 1-idxed) such that building using the ordered
pair `tok` would result in a valid move. Takes `obstacle`s which are ordered pairs occupying
spaces that `tok` definitely can't build on (other tokens)--as well as the entire board
representation which is used to determine which of the adjacent spaces to tok
are capped |#
;; TODO: refactor so that this shares logic with `get-spaces-tok-can-move-to`
;; since they are almost identical
;; TODO: write tests
(define (get-spaces-tok-can-build-on tok obstacle1 obstacle2 obstacle3 board)
  (let ([adjspcs-to-tok (boardq-adjacent-spaces board (car tok) (cadr tok))])
    ;; Filter adjspcs-to-tok such that it does not contain:
    (filter
     (λ (spc-rc)
       (let ([r (car spc-rc)]
             [c (cadr spc-rc)])
         (not (or
               ;; - spaces obstructed by other (obstacle) tokens.
               (equal? spc-rc obstacle1)
               (equal? spc-rc obstacle2)
               (equal? spc-rc obstacle3)
               ;; - capped spaces (level 4 spaces)
               (boardq-space-capped? board r c)))))
     adjspcs-to-tok)))



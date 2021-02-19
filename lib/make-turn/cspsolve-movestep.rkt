#lang racket

(require racket/set
         json
         "../board.rkt")

(provide cspsolve-movestep)

#|Take a board and return a set of all possible boards, allowing
only one move step to be taken|#
(define (cspsolve-movestep board)
  (let* ([mytok1 (car (boardq-my-tokens board))]
         [mytok2 (cadr (boardq-my-tokens board))]
         [enmytok1 (car (boardq-enemy-tokens board))]
         [enmytok2 (cadr (boardq-enemy-tokens board))]
         [spaces-mytok1-can-move-to
          (get-spaces-tok-can-move-to mytok1
                                      mytok2
                                      enmytok1
                                      enmytok2
                                      board)]
         [spaces-mytok2-can-move-to
          (get-spaces-tok-can-move-to mytok2
                                      mytok1
                                      enmytok1
                                      enmytok2
                                      board)])
    (let ([new-players-lists
           (map (λ (mytok-new-posns)
                  (list mytok-new-posns (boardq-enemy-tokens board))) ;; DON'T REVERSE PLAYERS
                (gen-valid-mytok-new-posns-from-moves mytok1
                                                      mytok2
                                                      spaces-mytok1-can-move-to
                                                      spaces-mytok2-can-move-to))])
      (map (λ (new-players)
             (hash "players" new-players
                   "spaces" (boardq-spaces board)
                   "turn" (+ 1 (boardq-turn board))))
           new-players-lists))))


#|Generate a list of list of 1-idxed coordinate pairs possible....
e.g.

;; UNANNOTATED
(list
 (list '(1 2) '(3 4))
 ...
 (list '(1 3) '(3 4))
 )

;; ANNOTATED
(list
 ;; OUTER LIST 1
 (list ;; 2 INNER LISTS -- '(1 2) '(3 4)
  '(1 2) '(3 4))
 ...
 ;; OUTER LIST N
 (list ;; 2 INNER LISTS
  '(1 3) '(3 4))
 )

The resulting list may contain isomorphic new token positions.
;; TODO: remove isomporhic "duplicates" |#
(define (gen-valid-mytok-new-posns-from-moves
         mytok1
         mytok2
         spaces-mytok1-can-move-to
         spaces-mytok2-can-move-to)
  (remove-duplicates
   (append
    (cartesian-product spaces-mytok1-can-move-to `(,mytok2))
    (cartesian-product spaces-mytok2-can-move-to `(,mytok1))))
  )



#|Return a list of ordered pairs (coods are 1-idxed) such that moving the ordered pair `tok`
would result in a valid move. Takes `obstacle`s which are ordered pairs occupying
spaces that `tok` definitely can't move to (other tokens)--as well as the entire board
representation which is used to determine which of the adjacent spaces to tok
are too high or low for tok to move to (and which are capped), etc.|#
;; TODO: write tests
(define (get-spaces-tok-can-move-to tok obstacle1 obstacle2 obstacle3 board)
  (let ([adjspcs-to-tok (boardq-adjacent-spaces board (car tok) (cadr tok))])
    ;; Filter adjspcs-to-tok such that it does not contain:
    (filter-not
     (λ (spc-rc)
       (let ([r (car spc-rc)]
             [c (cadr spc-rc)])
         (or
          ;; - spaces obstructed by other (obstacle) tokens.
          (equal? spc-rc obstacle1)
          (equal? spc-rc obstacle2)
          (equal? spc-rc obstacle3)
          ;; - capped spaces (level 4 spaces)
          (boardq-space-capped? board r c)
          ;; - Spaces that are too high for the token to jump to.
          (> (boardq-levelof-space board r c)
             (+ 1 (boardq-levelof-space board (car tok) (cadr tok))))
          )))
     adjspcs-to-tok)))


;; TODO: DELETE ME AFTER TEST HAS BEEN WRITTEN
;; (cspsolve-movestep (string->jsexpr

;;                     "{\"players\":[[[2,5],[3,5]],[[3,4],[4,4]]], \"spaces\":[[0,0,0,0,2],[1,1,2,0,0],[1,0,0,3,0],[0,0,3,0,0],[0,0,0,1,4]], \"turn\":19}"
;; ))

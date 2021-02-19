#lang racket

(require racket/set
         json
         "../board.rkt")

(provide cspsolve-movestep)

#|Take a board and return a set of all possible boards, allowing
only one move step to be taken|#
(define (cspsolve-movestep board)
  (let* ([spaces (boardq-spaces board)]
        [players (boardq-players board)]
        [my-tokens (boardq-my-tokens board)]
        [enemy-tokens (boardq-enemy-tokens board)]
        [mytok1 (car (boardq-my-tokens board))]
        [mytok2 (cadr (boardq-my-tokens board))]
        [enmytok1 (car (boardq-enemy-tokens board))]
        [enmytok2 (cadr (boardq-enemy-tokens board))]
        [mytok1-r (car mytok1)]
        [mytok1-c (cadr mytok1)]
        [mytok2-r (car mytok2)]
        [mytok2-c (cadr mytok2)]
        [spaces-mytok1-can-move-to
         (get-spaces-tok-can-move-to mytok1
                                     mytok2
                                     enmytok1
                                     enmytok2
                                     board)
         ]
        [spaces-mytok2-can-move-to
          (get-spaces-tok-can-move-to mytok2
                                      mytok1
                                      enmytok1
                                      enmytok2
                                      board)
                                   ])
    ;;(set-union (list->set
    (list ;; TODO: delete outer list
                (gen-valid-boards-from-moves mytok1
                                             spaces
                                             spaces-mytok1-can-move-to)
               ;; )
               ;;(list->set
                (gen-valid-boards-from-moves mytok2
                                             spaces
                                             spaces-mytok2-can-move-to)
                )
                ;;))
    ))

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


#|Take the ordered-pair position  mytok, as well as a list of
ordered pairs containing the spaces mytok can move to, and generate every valid
board.|#
;; BKMRK:TODO: implement
(define (gen-valid-boards-from-moves mytok spaces spaces-mytok-can-move-to)
  (void)
  )

(cspsolve-movestep (string->jsexpr

                    "{\"players\":[[[2,5],[3,5]],[[3,4],[4,4]]], \"spaces\":[[0,0,0,0,2],[1,1,2,0,0],[1,0,0,3,0],[0,0,3,0,0],[0,0,0,1,4]], \"turn\":19}"
))

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
        [mytok2 (car (cdr (boardq-my-tokens board)))]
        [enmytok1 (car (boardq-enemy-tokens board))]
        [enmytok2 (car (cdr (boardq-enemy-tokens board)))]
        [adjspcs-to-mytok1
         (boardq-adjacent-spaces board (car mytok1) (car (cdr mytok1)))]
        [adjspcs-to-mytok2
         (boardq-adjacent-spaces board (car mytok2) (car (cdr mytok2)))]
        [mytok1-r (car mytok1)]
        [mytok1-c (car (cdr mytok1))]
        [mytok2-r (car mytok2)]
        [mytok2-c (car (cdr mytok2))]
        [spaces-mytok1-can-move-to
         (get-spaces-tok-can-move-to mytok1
                                     adjspcs-to-mytok1
                                     '(mytok2 enmytok1 enmytok2)
                                     board)
         ]
        [spaces-mytok2-can-move-to
          (get-spaces-tok-can-move-to mytok2
                                      adjspcs-to-mytok1
                                      '(mytok1 enmytok1 enmytok2)
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
would result in a valid move. Takes a list of `obstacles` which are ordered pairs occupying
spaces that `tok` definitely can't move to (other tokens)--as well as the entire board
representation which is used to determine which of the adjacent spaces to tok
`adjspcs-to-tok` are too high or low for tok to move to (and which are capped), etc.|#
(define (get-spaces-tok-can-move-to tok adjspcs-to-tok obstacles board)
  ;; BKMRK: TODO: implement
  (void)
  )


#|Take the ordered-pair position  mytok, as well as a list of
ordered pairs containing the spaces mytok can move to, and generate every valid
board.|#
;; BKMRK:TODO: implement
(define (gen-valid-boards-from-moves mytok
                                     spaces
                                     spaces-mytok-can-move-to)
  (list mytok ",1," spaces ",2," spaces-mytok-can-move-to)

  )

(cspsolve-movestep (string->jsexpr

                    "{\"players\":[[[2,5],[3,5]],[[3,4],[4,4]]], \"spaces\":[[0,0,0,0,2],[1,1,2,0,0],[1,0,0,3,0],[0,0,3,0,0],[0,0,0,1,4]], \"turn\":19}"
))

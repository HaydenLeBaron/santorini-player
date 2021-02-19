#lang racket

(require rackunit
         "../lib/make-turn/cspsolve-movestep.rkt"
         "../lib/board.rkt"
         json)


(define board1 (string->jsexpr
                "{\"players\":[[[2, 3], [4, 4]], [[2, 5], [3, 5]]],
                  \"spaces\":[[0, 0, 0, 0, 2],
                              [1, 1, 2, 0, 0],
                              [1, 0, 0, 3, 0],
                              [0, 0, 3, 0, 0],
                              [0, 0, 0, 1, 4]],
                  \"turn\": 18}"))

(define board2 (string->jsexpr
                "{\"players\":[[[2, 5], [3, 5]], [[3, 3], [4, 4]]],
                  \"spaces\":[[0, 0, 0, 0, 2],
                              [1, 1, 2, 0, 0],
                              [1, 0, 0, 3, 0],
                              [0, 0, 3, 0, 0],
                              [0, 0, 0, 1, 4]],
                  \"turn\": 18}"))




(define board3 (string->jsexpr
                "{\"players\":[],
                  \"spaces\":[],
                  \"turn\": 18}"
                ))

(define board4 (string->jsexpr
                "{\"players\":[],
                  \"spaces\":[],
                  \"turn\": 18}"
                ))


(check-equal? (length (remove-duplicates (boardq-adjacent-spaces board1 3 2))) 8)
(check-equal? (boardq-levelof-space board1 1 1) 0)
(check-equal? (boardq-levelof-space board1 1 2) 0)
(check-equal? (boardq-levelof-space board1 1 3) 0)
(check-equal? (boardq-levelof-space board1 1 4) 0)
(check-equal? (boardq-levelof-space board1 1 5) 2)
(check-equal? (boardq-levelof-space board1 2 1) 1)
(check-equal? (boardq-levelof-space board1 2 2) 1)
(check-equal? (boardq-levelof-space board1 2 3) 2)
(check-equal? (boardq-levelof-space board1 2 4) 0)
(check-equal? (boardq-levelof-space board1 2 5) 0)
(check-equal? (boardq-levelof-space board1 3 2) 0)
(check-equal? (boardq-levelof-space board1 5 5) 4)


(check-equal? (list->set (get-spaces-tok-can-move-to
            (car (boardq-my-tokens board1))    ;; '(2 3)
            (cadr (boardq-my-tokens board1)) ;; '(4 4)
            (car (boardq-enemy-tokens board1))
            (cadr (boardq-enemy-tokens board1))
            board1))
              (set '(1 2) '(1 3) '(1 4) '(2 2) '(2 4) '(3 2) '(3 3) '(3 4)))




(check-equal? (list->set (get-spaces-tok-can-move-to
                          (cadr (boardq-my-tokens board1)) ;(4 4)
                          (car (boardq-my-tokens board1))     ;; '(3 2)
                          (car (boardq-enemy-tokens board1))
                          (cadr (boardq-enemy-tokens board1))
                          board1))
              (set '(3 3) '(4 5) '(5 4) '(5 3)))

(check-equal? (length (cspsolve-movestep board1)) 12)


;(cspsolve-movestep board1)




(check-equal? (list->set (get-spaces-tok-can-move-to
                          (car (boardq-my-tokens board2))
                          (cadr (boardq-my-tokens board2))
                          (car (boardq-enemy-tokens board2))
                          (cadr (boardq-enemy-tokens board2))
                          board2))
              (set '(1 4) '(2 4)))




(check-equal? (list->set (get-spaces-tok-can-move-to
                          (cadr (boardq-my-tokens board2))
                          (car (boardq-my-tokens board2))
                          (car (boardq-enemy-tokens board2))
                          (cadr (boardq-enemy-tokens board2))
                          board2))
              (set '(2 4) '(4 5)))

(check-equal? (length (cspsolve-movestep board1)) 12)
(check-equal? (length (cspsolve-movestep board2)) 4)

;; (check-equal? (andmap
;;                (λ (brd)
;;                  (= 19 (boardq-turn brd)))
;;                (cspsolve-movestep board1))
;;                #t)

;(cspsolve-movestep board2)

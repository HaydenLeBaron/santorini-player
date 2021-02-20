#lang racket

(require "test-boards.rkt"
         "../lib/make-turn/cspsolve-buildstep.rkt"
         "../lib/board.rkt"
         rackunit)

;; (define board1 (jsonstr->board
;;                 "{\"players\":[[a[2, 3], b[4, 4]], [c[2, 5], d[3, 5]]],
;;                   \"spaces\":[[0, 0, 0, 0, 2],
;;                               [1, 1, 2a 0, 0c],
;;                               [1, 0, 0, 3, 0d],
;;                               [0, 0, 3b 0, 0],
;;                               [0, 0, 0, 1, 4]],
;;                   \"turn\": 18}"))

(check-equal? (list->set (map boardq-spaces
                              (cspsolve-buildstep
                               board1
                               (car (boardq-my-tokens board1))
                               (cadr (boardq-my-tokens board1)))))
              (list->set (list
               (list
                '(0 0 0 0 2)
                '(1 1 2 1 0)
                '(1 0 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )
               (list
                '(0 0 0 0 2)
                '(1 1 2 0 0)
                '(1 0 0 4 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )
               (list
                '(0 0 0 0 2)
                '(1 1 2 0 0)
                '(1 0 1 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )

               (list
                '(0 0 0 0 2)
                '(1 1 2 0 0)
                '(1 1 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )

               (list
                '(0 0 0 0 2)
                '(1 2 2 0 0)
                '(1 0 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )

               (list
                '(0 1 0 0 2)
                '(1 1 2 0 0)
                '(1 0 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )

               (list
                '(0 0 1 0 2)
                '(1 1 2 0 0)
                '(1 0 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )

               (list
                '(0 0 0 1 2)
                '(1 1 2 0 0)
                '(1 0 0 3 0)
                '(0 0 3 0 0)
                '(0 0 0 1 4)
                )
               ))
              )

(check-equal? (length (map boardq-spaces
                           (cspsolve-buildstep
                            board1
                            (car (boardq-my-tokens board1))
                            (cadr (boardq-my-tokens board1)))))
              8)

(check-equal? (length (map boardq-spaces
                           (cspsolve-buildstep
                            board1
                            (car (boardq-my-tokens board1))
                            (cadr (boardq-my-tokens board1)))))
              (length (remove-duplicates
                       (map boardq-spaces
                            (cspsolve-buildstep
                             board1
                             (car (boardq-my-tokens board1))
                             (cadr (boardq-my-tokens board1)))))))


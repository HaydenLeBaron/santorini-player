#|This file contains the main function for running a single santorini-player bot.|#

#lang racket

(require "handle-beginning-game-cases.rkt"
         "aux-io.rkt"
         "make-turn.rkt"
         )



#|Start santorini-player bot, given an initial board expressed in JSON
coming from stdin. Makes a move, then writes to std out in
a continuous, never ending loop. Termination is handled
by the referee program.|#
;; TODO: figure out if Termination of the program should be handled by a referee program.
;; TODO: BKMRK: Implement in a way so that it can play with itself
(define (santorini-player-main)

  ;; (begin
  ;;   if beginning-case, then board->stdout(handle-beginning-game-cases(read-from-stdin)), else:
  ;;   board->stdout(make-turn(handle-beginning-game-cases(json->board())))
  ;;   santorini-player-main
  ;;   )

  (begin
    ;(board->stdout (handle-beginning-game-cases (stdin->board)))
    ;(board->stdout (handle-beginning-game-cases (stdin->board)))
    (splayer-main-loop)
     )
  )

(define (splayer-main-loop)
  (let ([a-board (stdin->board)])
    (begin
      (board->stdout (if (not (hash? a-board))
                         (handle-beginning-game-cases a-board)
                         (make-turn a-board)))
      (splayer-main-loop)
    ))
  )


;; Call main
(santorini-player-main)

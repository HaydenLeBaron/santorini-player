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
(define (santorini-player-main)
  ;; TODO: implement

  ;; (begin
  ;;   if beginning-case, then board->stdout(handle-beginning-game-cases(read-from-stdin)), else:
  ;;   board->stdout(make-turn(json->board()))
  ;;   santorini-player-main
  ;;   )
  (void))


;; Call main
(santorini-player-main)

#lang racket

(require "../lib/aux-io.rkt")
(provide board1
         board2
         card-board1
         )

(define board1 (jsonstr->board
                "{\"players\":[[[2, 3], [4, 4]], [[2, 5], [3, 5]]],
                  \"spaces\":[[0, 0, 0, 0, 2],
                              [1, 1, 2, 0, 0],
                              [1, 0, 0, 3, 0],
                              [0, 0, 3, 0, 0],
                              [0, 0, 0, 1, 4]],
                  \"turn\": 18}"))

(define board2 (jsonstr->board
                "{\"players\":[[[2, 5], [3, 5]], [[3, 3], [4, 4]]],
                  \"spaces\":[[0, 0, 0, 0, 2],
                              [1, 1, 2, 0, 0],
                              [1, 0, 0, 3, 0],
                              [0, 0, 3, 0, 0],
                              [0, 0, 0, 1, 4]],
                  \"turn\": 18}"))

(define card-board1 (jsonstr->board
                "{\"players\":[{\"card\":\"Artemis\",\"tokens\":[[2,3],[4,4]]},
                               {\"card\":\"Prometheus\",\"tokens\":[[2,5],[3,5]]}],
                  \"spaces\":[[0, 0, 0, 0, 2],
                              [1, 1, 2, 0, 0],
                              [1, 0, 0, 3, 0],
                              [0, 0, 3, 0, 0],
                              [0, 0, 0, 1, 4]],
                  \"turn\": 18}"))


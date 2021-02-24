#lang racket

(require json)

(define (main)
  (begin
    (println "Main start")
    (main-loop)
    )
  )


(define (main-loop)
  (begin
    (println (read-json))
    (main-loop))
  )

(main)

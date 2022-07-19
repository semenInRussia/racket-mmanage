#lang info

(define collection 'multi)
(define pkg-authors '(semenInRussia))
(define version "0.0")

(define build-deps '("scribble-lib"
                     "racket-doc"
                     "rackunit-lib"))

(define scribblings '(("scribblings/mmanager.scrbl" ())))

(define pkg-desc
  "Manager of music, contains some backends: last.fm, YouTube music")

(define license '(Apache-2.0))

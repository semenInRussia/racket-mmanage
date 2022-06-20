#lang info

(define collection 'multi)
(define deps '("base"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings '(("scribblings/mmanager.scrbl" ())))
(define pkg-desc
  "Manager of music, contains some backends: spotify, YouTube music")
(define version "0.0")
(define pkg-authors '(semenInRussia))
(define license '(Apache-2.0 OR MIT))

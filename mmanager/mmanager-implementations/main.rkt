#lang racket/base

(require
 racket/unit
 mmanager-core
 "./rocknation/rocknation-artists-unit.rkt")

(module+ test
  (require rackunit))

(module+ main
  ;; Check the import of mmanager-core
  (make-artist-model "AC/DC"))

(module+ main
  ;; tests for rocknation
  (define-values/invoke-unit/infer rocknation-artists@)
  (search-artists (make-artist-model "AC/DC")))

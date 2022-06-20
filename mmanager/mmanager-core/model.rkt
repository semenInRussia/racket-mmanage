#lang racket/base

(provide
 (struct-out artist-model)
 (struct-out album-model)
 (struct-out track-model))

(define-struct artist-model (name) #:transparent)
(define-struct album-model (name artist) #:transparent)
(define-struct track-model (name album) #:transparent)


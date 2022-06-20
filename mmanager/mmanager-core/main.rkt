#lang racket/base

(provide
 (all-from-out
  "./model.rkt"
  "./artists-sig.rkt"
  "./albums-sig.rkt"
  "./tracks-sig.rkt"))

(require
 racket/match
 racket/unit
 "./model.rkt"
 "./artists-sig.rkt"
 "./albums-sig.rkt"
 "./tracks-sig.rkt")

(module+ test
  (require rackunit)
  (define-unit mock-artists@
    (import)
    (export artists^)

    (define (get-artist artist-model)
      (car (search-artists (artist-model-name artist-model))))

    (define (search-artists name)
      (for/list ([i (in-range 10)])
        (make-artist-model
         (match i
           [0 "Semen!"]
           [1 "The Beatles"]
           [2 "Second Artist"]
           [3 "Third Artist"]
           [4 "Fourth Arist"]
           [5 "Fifth Artist"]
           [_ "Any Band"]))))

    (define search-artists-by-query search-artists)

    (define (artist-img-url artist)
      "https://rocknation.su/upload/images/bands/60.jpg")

    (define (artist-url artist)
      "https://rocknation.su/bands/60")

    (define (artist-tracks-top artist)
      (for/list ([i (in-range 5)])
        (make-track-model (format "~a's Hit #~a" (artist-model-name artist) i)
                          artist)))

    (define (artist-albums artist)
      (for/list ([i (in-range 16)])
        (make-album-model (format
                            "~a's Cool Album #~a"
                            (artist-model-name artist) i)
                          artist))))

  (define-values/invoke-unit/infer mock-artists@)

  (check-equal? (artist-model "Semen!")
                (get-artist (make-artist-model "AC/DC")))

  (for [(artist (search-artists (make-artist-model "AC/DC")))]
    (check-true (artist-model? artist)))

  (check-true (string? (artist-url (make-artist-model "AC/DC"))))
  (check-true (string? (artist-img-url (make-artist-model "AC/DC"))))

  (for [(track (artist-tracks-top (make-artist-model "AC/DC")))]
    (check-true (track-model? track)))

  (for [(album (artist-albums (make-artist-model "AC/DC")))]
    (check-true (album-model? album))))


#lang racket/base

(require
 rackunit
 racket/unit
 mmanager-core
 "./lastfm-artists-unit.rkt"
 "./lastfm-helper.rkt")

;; Tests for artists
(module+ test
  (define-values/invoke-unit/infer lastfm-artists@)

  (check-pred lastfm-artist? (get-artist (make-artist-model "ac-dc")))

  (check-equal?
   (lastfm-artist-name (get-artist (make-artist-model "ac-dc")))
   "AC/DC")

  (check-equal?
   (artist-url (get-artist (make-artist-model "ac-dc")))
   "https://www.last.fm/music/AC%2FDC")

  (check-equal?
   (artist-img-url (get-artist (make-artist-model "ac-dc")))
   (string-append
    "https://lastfm.freetls.fastly.net/i/u/64s/"
    "2a96cbd8b46e442fc41c2b86b821562f.png"))

  (let ([albums (artist-albums (get-artist (make-artist-model "ac-dc")))])
    (check-true
     (andmap lastfm-album? albums)))

  (let ([tracks (artist-top-tracks (get-artist (make-artist-model "ac-dc")))])
    (check-true
     (andmap lastfm-track? tracks))))


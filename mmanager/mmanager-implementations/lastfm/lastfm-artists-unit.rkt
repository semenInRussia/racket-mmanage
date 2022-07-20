#lang racket/unit

(require
 threading
 mmanager-core
 "./lastfm-helper.rkt")

(import)
(export artists^)

(define (search-artists-by-query artist-name)
  (search-artists (make-artist-model artist-name)))

(define (get-artist artist-model)
  (car (search-artists artist-model)))

(define (search-artists artist-model)
  (map hash->lastfm-artist (search-json-artists artist-model)))

(define (search-json-artists artist-model)
  (~>
   artist-model
   artist-model-name
   json-of-artist-search
   (hash-ref 'results)
   (hash-ref 'artistmatches)
   (hash-ref 'artist)))

(define (json-of-artist-search artist-name (limit 30) (page 1))
  (lastfm-get-json "artist.search"
                   `((artist . ,artist-name)
                     (limit . ,limit)
                     (page . ,page))))

(define (artist-albums artist)
  (map hash->lastfm-album (json-artist-albums artist)))

(define (json-artist-albums artist)
  (~>
   artist
   lastfm-artist-name
   json-of-artist-albums
   (hash-ref 'topalbums)
   (hash-ref 'album)))

(define (json-of-artist-albums artist-name
                               (autocorrect? #f)
                               (page 1)
                               (limit 30))
  (let ([autocorrect? (if autocorrect? "1" "0")])
    (lastfm-get-json "artist.gettopalbums"
                     `((artist . ,artist-name)
                       (limit . ,limit)
                       (page . ,page)
                       (autocorrect . ,autocorrect?)))))

(define artist-url lastfm-artist-url)

(define artist-img-url lastfm-artist-img-url)

(define (artist-top-tracks artist)
  (map hash->lastfm-track (json-artist-top-tracks artist)))

(define (json-artist-top-tracks artist)
  (~>
   artist
   lastfm-artist-name
   json-of-artist-top-tracks
   (hash-ref 'toptracks)
   (hash-ref 'track)))

(define (json-of-artist-top-tracks artist-name
                                   (autocorrect? #f)
                                   (page 1)
                                   (limit 30))
  (let ([autocorrect? (if autocorrect? "1" "0")])
    (lastfm-get-json "artist.gettoptracks"
                     `((artist . ,artist-name)
                       (limit . ,limit)
                       (page . ,page)))))


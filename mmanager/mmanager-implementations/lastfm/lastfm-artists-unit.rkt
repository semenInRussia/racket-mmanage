#lang racket/unit

(require
 threading
 mmanager-core
 "./lastfm-helper.rkt")

(import)
(export artists^)

(define (search-artists-by-query artist-name)
  (search-artists (make-artist-model artist-name)))

(define (search-artists artist-model)
  (map lastfm-json->artist (search-json-artists artist-model)))

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

(define get-artist (compose car search-artists))

(define (artist-albums artist)
  (map lastfm-json->album (artist-json-albums artist)))

(define (artist-json-albums artist)
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

(define (artist-tracks-top artist)
  (map lastfm-json->track (artist-json-tracks-top artist)))

(define (artist-json-tracks-top artist)
  (~>
   artist
   lastfm-artist-name
   json-of-artist-tracks
   (hash-ref 'toptracks)
   (hash-ref 'track)))

(define (json-of-artist-tracks artist-name
                               (autocorrect? #f)
                               (page 1)
                               (limit 30))
  (let ([autocorrect? (if autocorrect? "1" "0")])
    (lastfm-get-json "artist.gettoptracks"
                     `((artist . ,artist-name)
                       (limit . ,limit)
                       (page . ,page)))))



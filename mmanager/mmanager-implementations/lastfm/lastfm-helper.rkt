#lang racket/base

(require
 net/http-easy
 threading)

(provide
 (struct-out lastfm-artist)
 (struct-out lastfm-album)
 (struct-out lastfm-track)
 hash->lastfm-artist
 hash->lastfm-album
 hash->lastfm-track
 lastfm-get-json)

(define lastfm-base-url "http://ws.audioscrobbler.com/2.0")

(define lastfm-api-key "059264d9b440108cecc7f0afd84d7f49")

(define-struct lastfm-artist (name url img-url))

(define (hash->lastfm-artist data)
  (lastfm-artist (hash-ref data 'name)
                 (hash-ref data 'url)
                 (search-medium-img-url-in-json data)))

(define-struct lastfm-album (name artist url img-url))

(define (hash->lastfm-album data)
  (define name (hash-ref data 'name))
  (define artist (hash->lastfm-artist (hash-ref data 'artist)))
  (define url (hash-ref data 'url))
  (define img-url (search-medium-img-url-in-json data))
  (make-lastfm-album name
                     artist
                     url
                     img-url))

(define-struct lastfm-track (name artist album))

(define (hash->lastfm-track data)
  (lastfm-track (hash-ref data 'name)
                (hash->lastfm-artist (hash-ref data 'artist))
                void))

(define (search-medium-img-url-in-json data)
  (and
   (hash-has-key? data 'image)
   (~>
    data
    (hash-ref 'image)
    (findf medium-json-img? _)
    (hash-ref '|#text|))))

(define (medium-json-img? data)
  (string=? (hash-ref data 'size "") "medium"))

(define (lastfm-get-json lastfm-method (user-params null))
  (define standard-params
    `((method . ,lastfm-method)
      (api_key . ,lastfm-api-key)
      (format . "json")))
  (define params
    (to-string-params-values (append user-params standard-params)))
  (read-response-json
   (get lastfm-base-url
        #:stream? #t
        #:params params)))

(define (to-string-params-values params)
  (for/list ([param params])
    (cons
     (car param)
     (format "~a" (cdr param)))))


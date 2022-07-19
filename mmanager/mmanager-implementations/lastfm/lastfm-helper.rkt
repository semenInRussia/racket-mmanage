#lang racket/base

(require
 net/http-easy
 threading)

(provide
 (struct-out lastfm-artist)
 (struct-out lastfm-album)
 (struct-out lastfm-track)
 lastfm-json->artist
 lastfm-json->album
 lastfm-json->track
 lastfm-get-json)

(define lastfm-base-url "http://ws.audioscrobbler.com/2.0")

(define lastfm-api-key "059264d9b440108cecc7f0afd84d7f49")

(define-struct lastfm-artist (name url img-url))

(define (lastfm-json->artist data)
  (lastfm-artist (hash-ref data 'name)
                 (hash-ref data 'url)
                 (search-medium-img-url-in-json data)))

(define-struct lastfm-album (name artist url img-url))

(define (lastfm-json->album data)
  (define name (hash-ref data 'name))
  (define artist (lastfm-json->artist (hash-ref data 'artist)))
  (define url (hash-ref data 'url))
  (define img-url (search-medium-img-url-in-json data))
  (make-lastfm-album name
                     artist
                     url
                     img-url))

(define-struct lastfm-track (name artist album))

(define (lastfm-json->track data)
  (lastfm-track (hash-ref data 'name)
                (lastfm-json->artist (hash-ref data 'artist))
                null))

(define (search-medium-img-url-in-json data)
  (if (hash-has-key? data 'image)
      (~>
       data
       (hash-ref 'image)
       (findf medium-json-img? _)
       (hash-ref '|#text|))
      #f))

(define (medium-json-img? data)
  (string=? (hash-ref data 'size "") "medium"))

(define (lastfm-get-json lastfm-method (params null))
  (let ([params (to-string-params-values params)])
    (read-response-json
     (get lastfm-base-url
          #:stream? #t
          #:params (append
                    params
                    `((method . ,lastfm-method)
                      (api_key . ,lastfm-api-key)
                      (format . "json")))))))

(define (to-string-params-values params)
  (for/list ([param params])
    (cons
     (car param)
     (format "~a" (cdr param)))))

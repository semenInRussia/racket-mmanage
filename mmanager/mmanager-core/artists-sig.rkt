#lang racket/signature

(require "./model.rkt")

(contracted
 [get-artist        (-> artist-model? any/c)]
 [search-artists    (-> artist-model? (listof any/c))]

 [artist-url        (-> any/c string?)]
 [artist-img-url    (-> any/c string?)]

 [artist-top-tracks (-> any/c (listof any/c))]
 [artist-albums     (-> any/c (listof any/c))])


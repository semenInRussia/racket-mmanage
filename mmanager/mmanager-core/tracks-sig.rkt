#lang racket/signature

(require "./model.rkt")

(contracted
 [get-track              (-> track-model? any/c)]
 [search-tracks          (-> track-model? (listof any/c))]
 [search-tracks-by-query (-> string? (listof any/c))]

 [track-url              (-> any/c string?)]
 [track-img-url          (-> any/c string?)]

 [track-artist           (-> any/c artist-model?)]
 [track-album            (-> any/c album-model?)])


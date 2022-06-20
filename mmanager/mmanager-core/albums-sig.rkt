#lang racket/signature

(require "./model.rkt")

(contracted
 [get-album              (-> album-model? any/c)]
 [search-albums          (-> album-model? (listof any/c))]
 [search-albums-by-query (-> string (listof any/c))]

 [album-url              (-> any/c (or/c string #f))]
 [album-img-url          (-> any/c (or/c string #f))]

 [album-artist           (-> any/c artist-model?)]
 [album-tracks           (-> any/c (listof track-model?))])

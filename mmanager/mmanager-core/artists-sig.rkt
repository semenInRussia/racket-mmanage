#lang racket/signature

(require "./model.rkt")

(contracted
 [get-artist              (-> artist-model? any/c)]
 [search-artists          (-> artist-model? (listof any/c))]
 [search-artists-by-query (-> string? (listof any/c))]

 [artist-url              (-> any/c string?)]
 [artist-img-url          (-> any/c string?)]

 [artist-tracks-top       (-> any/c (listof track-model?))]
 [artist-albums           (-> any/c (listof album-model?))]
 )

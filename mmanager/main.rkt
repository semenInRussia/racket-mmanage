#lang racket/base

(module+ main
  (displayln "Hi!  The file `main.rkt' haven't usefull source code")
  (newline)
  (displayln "This cool package has 2 collections:")
  (displayln "1. `racket-mmanager-core'")
  (displayln "   which has some useful signatures to define your own")
  (displayln "   music managers")
  (newline)
  (displayln "2. `racket-mmanager-implementations'")
  (displayln "   which has the some implemenentations of singnatures from")
  (displayln "   `racket-mmanager-core'"))

#lang racket
(require cover rackunit racket/runtime-path)
(define-runtime-path syntax.rkt "syntax.rkt")
(test-begin
 (parameterize ([current-cover-environment (make-cover-environment)])
  (test-files! syntax.rkt)
  (define x (get-test-coverage))
  (define c?
    (curry x (path->string syntax.rkt)))
  (for ([i (in-naturals 1)]
        [_ (in-string (file->string syntax.rkt))])
    (check-not-eq? (c? i) 'uncovered (~a i)))))

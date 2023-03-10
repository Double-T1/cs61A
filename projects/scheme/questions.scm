(define (caar x) (car (car x)))
(define (cadr x) (car (cdr x)))
(define (cdar x) (cdr (car x)))
(define (cddr x) (cdr (cdr x)))

; Some utility functions that you may find useful to implement.

(define (cons-all first rests)
  (map (lambda (x) (cons first x)) rests)
)

(define (zip pairs)
  (define (helper pairs one two)
    (if (null? pairs)
      (list one two)
      (helper (cdr pairs) (append one (list (caar pairs))) (append two (list (car (cdar pairs)))))
    )
  )
  (helper pairs nil nil)
)

;; Problem 16
;; Returns a list of two-element lists
(define (enumerate s)
  ; BEGIN PROBLEM 16
  (define (helper s index)
    (if (null? s)
      nil
      (cons (list index (car s)) (helper (cdr s) (+ 1 index)))
    )
  )
  (helper s 0)
)
  ; END PROBLEM 16

;; Problem 17
;; List all ways to make change for TOTAL with DENOMS
(define (list-change total denoms)
  ; BEGIN PROBLEM 17
  (cond 
    ((= total 0) '(()) )
    ((or (< total 0) (null? denoms)) '() )
    (else 
      (append
        (cons-all (car denoms) (list-change (- total (car denoms)) denoms))
        (list-change total (cdr denoms))
      )
    )
  )
)
  ; END PROBLEM 17

;; Problem 18
;; Returns a function that checks if an expression is the special form FORM
(define (check-special form)
  (lambda (expr) (equal? form (car expr)))
)

(define lambda? (check-special 'lambda))
(define define? (check-special 'define))
(define quoted? (check-special 'quote))
(define let?    (check-special 'let))

;; Converts all let special forms in EXPR into equivalent forms using lambda
(define (let-to-lambda expr)
  (cond 
    ((atom? expr) expr)
    ((quoted? expr) expr)
    ((or (lambda? expr) (define? expr))
      (let 
        (
          (form   (car expr))
          (params (cadr expr))
          (body   (cddr expr))
        )
        (cons form (cons params (let-to-lambda body)))
      )
    )
    ((let? expr)
      (let 
        (
          (values (cadr expr))
          (body   (cddr expr))
        )
        (define temp (zip values))
        (append 
          (cons (cons 'lambda (cons (car temp) (map let-to-lambda body))) nil)
          (map let-to-lambda (cadr temp))
        )
      )
    )
    ;other expressions 
    (else 
      (cons (car expr) (map let-to-lambda (cdr expr)))
    )
  )
)



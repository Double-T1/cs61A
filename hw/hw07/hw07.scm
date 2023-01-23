(define (cddr s)
  (cdr (cdr s)))

(define (cadr s)
  (car (cdr s))
)

(define (caddr s)
  (cadr (cdr s))
)


(define (sign num)
  (cond 
    ((< num 0) -1)
    ((> num 0) 1)
    (else 0)
  )
)


(define (square x) (* x x))

(define (pow x y)
  (if (= y 1) 
    x
    (if (even? y) 
      (pow (square x) (/ y 2))
      (* (pow (square x) (/ (- y 1) 2)) x)
    )
  )
)


(define (unique s)
  (if (null? s)
    nil
    (cons
      (car s) 
      (unique
        (filter
          (lambda (x) (not (eq? x (car s))))
          (cdr s)
        )
      )
    )
  )
)


(define (replicate x n)
  (define (helper x n lst)
    (if (= n 0)
      lst
      (helper x (- n 1) (cons x lst))
    )
  )
  (helper x n nil)
)

(define (accumulate combiner start n term)
  (if (= n 0)
    start
    (combiner (term n) (accumulate combiner start (- n 1) term))
  )
)


(define (accumulate-tail combiner start n term)
  (define (helper combiner accu n term)
    (if (= n 0)
      accu
      (helper combiner (combiner accu (term n)) (- n 1) term)
    )
  )
  (helper combiner start n term)
)


(define-macro (list-of map-expr for var in lst if filter-expr)
  (list 'map 
    (list 'lambda
      (list var)
      map-expr
    )
    (list 'filter
      (list 'lambda
        (list var)
        filter-expr
      )
      lst
    )
  )
)


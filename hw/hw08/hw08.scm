(define (helper val s count)
    (if (or (null? s) (not (= (car s) val)))
        (list val count)
        (helper val (cdr-stream s) (+ 1 count))
    )
)

(define (next val s)
    (if (or (null? s) (not (= (car s) val)))
        s
        (next val (cdr-stream s))
    )
)

(define (rle s)
    (if (null? s)
        nil 
        (cons-stream (helper (car s) s 0) (rle (next (car s) s)))
    )
)



#not tail-recursive
(define (helper2 s prev)
    (if (or (null? s) (> prev (car s)))
        nil
        (cons (car s) (helper2 (cdr-stream s) (car s)))
    )
)

(define (next2 s prev)
    (if (or (null? s) (> prev (car s)))
        s
        (next2 (cdr-stream s) (car s))
    )
)

(define (group-by-nondecreasing s)
    (if (null? s)
        nil
        (cons-stream (helper2 s 0) (group-by-nondecreasing (next2 s (car s))))
    )
)


(define finite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 3
                (cons-stream 1
                    (cons-stream 2
                        (cons-stream 2
                            (cons-stream 1 nil))))))))

(define infinite-test-stream
    (cons-stream 1
        (cons-stream 2
            (cons-stream 2
                infinite-test-stream))))


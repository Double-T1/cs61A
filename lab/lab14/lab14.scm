(define (first_n lst n new_lst) 
	(if (or (= n 0) (null? lst))
		new_lst
		(first_n (cdr lst) (- n 1) (append new_lst (list (car lst))))
	)
)

(define (next lst n)
	(if (or (= n 0) (null? lst))
		lst
		(next (cdr lst) (- n 1))
	)
)

(define (split-at lst n)	
	(cons (first_n lst n '()) (next lst n))
)


(define-macro (switch expr cases)
	(cons 'cond
		(map 
			(lambda (case) (cons (eq? (eval expr) (car case)) (cdr case)))
    		cases
		)	
	)
)



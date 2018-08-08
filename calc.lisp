


(pgen:rule expression
  (|| plus-expr
     minus-expr
     term))

(pgen:rule plus-expr
  (term "+" expression)
  (lambda (res)
    (+ (first res) (third res))))


(pgen:rule minus-expr
  (term "-" expression)
  (lambda (res)
    (- (first res) (third res))))


(pgen:rule term
  (|| times-term
     div-term
     factor))


(pgen:rule times-term
  (factor "*" term)
  (lambda (res)
    (* (first res) (third res))))


(pgen:rule div-term
  (factor "/" term)
  (lambda (res)
    (/ (first res) (third res))))


(pgen:rule factor
  (|| parens
     int-lit))

(pgen:rule parens
  (misc:wspace "(" expression ")" misc:wspace)
  (lambda (res)
    (third expression)))

(pgen:rule int-lit
  (misc:wspace
   (|| (misc:digit int-lit) misc:digit)
   misc:wspace)
  (lambda (res)
    (int-parse (second res))))


(defun int-parse (lit &optional (res 0))
  (if (listp lit)
    (int-parse
      (cdr lit)
      (+ (* res 10) (car lit)))
    (car lit)))


(defpackage :calc
  (:use :cl)
  (:export
    #:expression))

(in-package :calc)

(pgen:rule expression
  (any plus-expr
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
  (any times-term
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
  (any parens
       int-lit
       unary-neg))

(pgen:rule unary-neg
  ("-" factor)
  (lambda (res)
    (- (second res))))

(pgen:rule parens
  (misc:wspace "(" expression ")" misc:wspace)
  (lambda (res)
    (third res)))


(pgen:rule int-lit
  (misc:wspace misc:int-literal misc:wspace)
  (lambda (res)
    (second res)))



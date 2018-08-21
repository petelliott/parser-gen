;;;; a collection of useful non-leaf combinators
(defpackage :util
  (:use :cl)
  (:export
    #:strparser
    #:linearize
    #:rep*
    #:rep+
    #:exactly
    #:upto
    #:repn))

(in-package :util)


(comb:defcomb strparser (parser)
  (comb:capply
    (lambda (lst) (coerce lst 'string))
    parser))


(comb:defcomb linearize (parser)
  (comb:capply
    (lambda (lst)
      (if (listp lst)
        (cons (first lst) (second lst))
        (list lst)))
    parser))


(comb:defcomb rep+ (parser)
  (linearize
    (comb:any
      (comb:seq
        parser
        (rep+ parser))
      parser)))


(comb:defcomb rep* (parser)
  (comb:any
    (rep+ parser)
    (comb:cnull)))


(comb:defcomb exactly (n parser)
  "match exaxtly n of parser"
  (cond
    ((= n 0) (comb:cnull))
    ((= n 1) (comb:capply #'list parser))
    (t
      (linearize
        (comb:seq
          parser
          (exactly (1- n) parser))))))


(comb:defcomb upto (n parser)
  "match 0 to n of parser"
  (if (= n 0)
    (comb:cnull)
      (comb:any
        (linearize
          (comb:seq
            parser
            (upto (1- n) parser)))
        (comb:cnull))))


(comb:defcomb repn (lo hi parser)
  "match lo to hi of parser inclusive nil=inf"
  (comb:capply
    (lambda (lst)
      (append (first lst) (second lst)))
    (comb:seq
      (exactly lo parser)
      (if (null hi)
        (rep* parser)
        (upto (- hi lo) parser)))))

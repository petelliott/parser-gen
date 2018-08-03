(defpackage :util
  (:use :cl)
  (:export
    #:strparser
    #:linearize
    #:rep*
    #:rep+))

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
        (rep parser))
      parser)))


(comb:defcomb rep* (parser)
  (comb:any
    (rep+ parser)
    (comb:cnull)))

;;;; a parser combinator is a function that produces a parser
;;;; this file provides the minimum set of combinators to build
;;;; any parser out of.
;;;;
;;;; the parsers produced by this library take three functions:
;;;;  (next)
;;;;     return the next token and advance the input stream
;;;;  (save)
;;;;     return the current state of the input stream
;;;;  (revert save)
;;;;     reset the stream to a value returned by save
(defpackage :comb
  (:use :cl)
  (:export
    #:any
    #:anyl
    #:seq
    #:seql
    #:lit
    #:capply
    #:defcomb
    #:c-all
    #:cnull))


(in-package :comb)


(defun any (&rest combs)
  "returns a parser that returns the result of the
   first combinator to successfully parse"
  (anyl combs))


(defun anyl (combs)
  "same as #'any, but takes a list of combinators"
  (lambda (next save revert)
    (any-int combs next save revert)))


(defun any-int (combs next save revert)
  "an internal parser that takes a list of combinators
   as well as input functions and returns the result of
   the first combinator to successfully parse"
  (if combs
    (multiple-value-bind (res stat)
        (funcall (car combs) next save revert)
      (if stat
        (values res t)
        (any-int (cdr combs) next save revert)))
    (values nil nil)))


(defun seq (&rest combs)
  "returns a parser that returns a list of the result of
   each parse in order. all must be sucsessful for the
   sequence to be successfull"
  (seql combs))


(defun seql (combs)
  "same as #'seq, but takes a list of combinators"
  (lambda (next save revert)
    (let ((backup (funcall save)))
      (multiple-value-bind (res stat)
          (seq-int combs next save revert)
        (if stat
          (values res stat)
          (progn
            (funcall revert backup)
            (values res stat)))))))


(defun seq-int (combs next save revert)
  "returns a list of the result of each parse in order.
   all must be sucsessful for the sequence to be successfull"
  (if combs
    (multiple-value-bind (res stat)
        (funcall (car combs) next save revert)
      (if stat
        (multiple-value-bind (resn statn)
            (seq-int (cdr combs) next save revert)
            (values (cons res resn) statn))
        (values nil nil)))
    (values nil t)))


(defun lit (ch)
  "returns a parser that accepts a matching literal"
  (lambda (next save revert)
    (let ((backup (funcall save)))
      (if (equal ch (funcall next))
        (values ch t)
        (progn
          (funcall revert backup)
          (values nil nil))))))


(defun c-all ()
  "returns a parser that accepts any token"
  (lambda (next save revert)
    (let ((n (funcall next)))
      (if n
        (values n t)
        (values n nil)))))


(defun cnull ()
  "returns a parser that accepts nothing successfully"
  (lambda (next save revert)
    (values nil t)))


(defun capply (fun parser)
  "returns a parser that returns the result
   fun when applied to the result of parser"
  (lambda (next save revert)
    (multiple-value-bind (res stat)
        (funcall parser next save revert)
      (if stat
        (values (funcall fun res) t)
        (values res nil)))))


;; TODO: docstring support
(defmacro defcomb (name args body)
  "allows for the definition of a recursive named
   parser"
  (let ((next (gensym)) (save (gensym)) (revert (gensym)))
    `(defun ,name ,args
       (lambda (,next ,save ,revert)
         (funcall ,body ,next ,save ,revert)))))

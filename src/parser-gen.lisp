;;;; defines the rule macro, useful for
;;;; easy writing of parsers/interpreters
(defpackage :pgen
  (:use :cl)
  (:export
    #:rule
    #:shortform
    #:test))

(in-package :pgen)


(defmacro rule (name syntax &optional transform)
  "macro to define a named combinator with shortform
   syntax, and optionally a transformation"
  `(comb:defcomb ,name ()
     ,(if transform
        `(comb:capply
           ,transform
           ,(shortform syntax))
        (shortform syntax))))

;; shortform is a simple way of writing combinators of
;; sequences, choices, argumentless combinators
;;
;; shortform ::= (any shortform*)
;;             | (shortform*)
;;             | symbol
;;             | string
;;
;; example: (any (misc:alpha "b") misc:digit)
;;      --> (comb:any
;;            (comb:seq
;;              (misc:alpha)
;;              (mist:strseq "b")
;;            (misc:digit)))

(defun shortform (sf)
  "generates the combinator expression from the shorform"
  (cond
    ((stringp sf) `(misc:strseq ,sf))
    ((and (listp sf) (string-equal 'any (car sf)))
        `(comb:any ,@(mapcar #'shortform (cdr sf))))
    ((listp sf) `(comb:seq ,@(mapcar #'shortform sf)))
    ((symbolp sf) (list sf))))



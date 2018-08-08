(defpackage :pgen
  (:use :cl)
  (:export
    #:rule
    #:shortform
    #:test))

(in-package :pgen)


(defmacro rule (name syntax &optional transform)
  `(comb:defcomb ,name ()
     ,(if transform
        `(comb:capply
           ,transform
           ,(shortform syntax))
        (shortform syntax))))


(defun shortform (sf)
  "generates the combinator expression from the shorform"
  (cond
    ((stringp sf) `(misc:strseq ,sf))
    ((and (listp sf) (string-equal 'any (car sf)))
        `(comb:any ,@(mapcar #'shortform (cdr sf))))
    ((listp sf) `(comb:seq ,@(mapcar #'shortform sf)))
    ((symbolp sf) (list sf))))



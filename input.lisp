(defpackage :input
  (:use :cl)
  (:export
    #:str-in))

(in-package :input)



(defun str-in (str)
  "creates the peek and next functions for a string"
  (let ((i 0))
    (values
      ;; next
      (lambda ()
        (if (< i (length str))
          (prog1
            (aref str i)
            (setf i (+ i 1)))))
      ;; save
      (lambda () i)
      ;; revert
      (lambda (save) (setf i save)))))

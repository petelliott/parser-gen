(defpackage :input
  (:use :cl)
  (:export
    #:str-in
    #:list-in))

(in-package :input)


(defun str-in (str)
  "creates the next, save and revert closure for a string"
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


(defun list-in (lst)
  "creates the next, save and revert closure for a list"
  (values
    ;; next
    (lambda ()
      (prog1
        (car lst)
        (setf lst (cdr lst))))
    ;; save
    (lambda () lst)
    ;; revert
    (lambda (save) (setf lst save))))

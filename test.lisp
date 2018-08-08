(load "combinator")
(load "input")
(load "util")
(load "misc")
(load "parser-gen")
(load "calc.lisp")


(defgeneric test-parse (comb obj))


(defmethod test-parse (comb (str string))
  (multiple-value-call comb (input:str-in str)))


(defmethod test-parse (comb (obj list))
  (multiple-value-call comb (input:list-in obj)))

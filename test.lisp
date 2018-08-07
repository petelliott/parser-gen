(load "combinator")
(load "input")
(load "util")
(load "misc")


(defun test-parse (comb str)
  (multiple-value-call comb (input:str-in str)))

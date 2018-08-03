(load "combinator")
(load "input")
(load "util")
(load "misc")
(load "bnf-parser")


(defun test-parse (comb str)
  (multiple-value-call comb (input:str-in str)))

(defpackage :bnf-parser
  (:use :cl)
  (:export))

(in-package :bnf-parser)


(comb:defcomb syntax ()
  (comb:any
    (comb:seq
      (rule)
      (syntax))
    (rule)))

(comb:defcomb rule ()
  (comb:seq
    (opt-whitespace)
    (comb:lit #\<)
    (rule-name)
    (comb:lit #\>)
    (opt-whitespace)
    (misc:str-lit "::=")
    (opt-whitespace)
    (expression)
    (line-end)))


(comb:defcomb opt-whitespace ()
  (comb:cignore
    (comb:any
      (comb:seq
        (comb:lit #\ )
        (opt-whitespace))
      comb:cnull)))


(comb:defcomb expression ()
  (comb:any
    (comb:seq
      (term-list)
      (opt-whitespace)
      (comb:lit #\|)
      (opt-whitespace)
      (expression))
    (term-list)))


(comb:defcomb line-end ()
  (comb:cignore
    (comb:any
      (comb:seq
        (opt-whitespace)
        (comb:lit #\linefeed))
      (comb:seq
        (line-end)
        (line-end)))))


(comb:defcomb term-list ()
  (comb:any
    (comb:seq
      (term)
      (opt-whitespace)
      (term-list))
    (term)))


(comb:defcomb term ()
  (comb:any
    (literal)
    (comb:seq
      (comb:lit #\<)
      (rule-name)
      (comb:lit #\>))))


(comb:defcomb literal ()
  (comb:any
    (comb:seq
      (comb:lit #\")
      (text1)
      (comb:lit #\"))
    (comb:seq
      (comb:lit #\')
      (text2)
      (comb:lit #\'))))


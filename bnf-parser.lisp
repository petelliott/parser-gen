(defpackage :bnf-parser
  (:use :cl)
  (:export
    #:syntax))

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

(comb:defcomb text1 ()
  (comb:any
    (comb:seq
      (character1)
      (text1))
    (comb:cnull)))

(comb:defcomb text2 ()
  (comb:any
    (comb:seq
      (character2)
      (text2))
    (comb:cnull)))

(comb:defcomb bcharacter ()
  (comb:any
    (misc:alpha)
    (misc:digit)
    (misc:sym)
    (comb:lit #\ )))

(comb:defcomb character1 ()
  (comb:any
    (bcharacter)
    (comb:lit #\')))

(comb:defcomb character2 ()
  (comb:any
    (bcharacter)
    (comb:lit #\")))

(comb:defcomb rule-name ()
  (comb:any
    (comb:seq
      (rule-name)
      (rule-char))
    (misc:alpha)))

(comb:defcomb rule-char ()
  (comb:any
    (misc:alpha)
    (misc:digit)
    (comb:lit #\-)))

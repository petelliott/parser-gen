;;; a collection of prebuilt utilities
(defpackage :misc
  (:use :cl)
  (:export
    #:str-lit
    #:strseq
    #:identifier
    #:wspace
    #:sym
    #:alphanum
    #:digit
    #:alpha))

(in-package :misc)


(comb:defcomb str-lit (&optional (delim #\"))
  (comb:seq
    (comb:lit delim)
    (util:strparser
      (util:rep*
      (comb:lit- delim)))
    (comb:lit delim)))


(comb:defcomb strseq (str)
  (util:strparser
    (comb:seql
      (mapcar
        (lambda (ch) (comb:lit ch))
        (coerce str 'list)))))


(comb:defcomb identifier ()
  (util:strparser
    (util:rep
      (alphanum))))


(comb:defcomb wspace ()
  (comb:cignore
    (util:rep*
      (comb:any
        (comb:lit #\ )
        (comb:lit #\return)
        (comb:lit #\linefeed)
        (comb:lit #\tab)))))


(comb:defcomb sym ()
  (comb:any
   (comb:lit #\!)
   (comb:lit #\")
   (comb:lit #\#)
   (comb:lit #\$)
   (comb:lit #\%)
   (comb:lit #\&)
   (comb:lit #\')
   (comb:lit #\()
   (comb:lit #\))
   (comb:lit #\*)
   (comb:lit #\+)
   (comb:lit #\,)
   (comb:lit #\-)
   (comb:lit #\.)
   (comb:lit #\/)
   (comb:lit #\:)
   (comb:lit #\;)
   (comb:lit #\<)
   (comb:lit #\=)
   (comb:lit #\>)
   (comb:lit #\?)
   (comb:lit #\@)
   (comb:lit #\[)
   (comb:lit #\\)
   (comb:lit #\])
   (comb:lit #\^)
   (comb:lit #\_)
   (comb:lit #\`)
   (comb:lit #\{)
   (comb:lit #\|)
   (comb:lit #\})
   (comb:lit #\~)


(comb:defcomb alphanum ()
  (comb:any (alpha) (digit)))


(comb:defcomb digit ()
  (comb:any
    (comb:lit #\0)
    (comb:lit #\1)
    (comb:lit #\2)
    (comb:lit #\3)
    (comb:lit #\4)
    (comb:lit #\5)
    (comb:lit #\6)
    (comb:lit #\7)
    (comb:lit #\8)
    (comb:lit #\9)))


(comb:defcomb alpha ()
  (comb:any
    (comb:lit #\a)
    (comb:lit #\b)
    (comb:lit #\c)
    (comb:lit #\d)
    (comb:lit #\e)
    (comb:lit #\f)
    (comb:lit #\g)
    (comb:lit #\h)
    (comb:lit #\i)
    (comb:lit #\j)
    (comb:lit #\k)
    (comb:lit #\l)
    (comb:lit #\m)
    (comb:lit #\n)
    (comb:lit #\o)
    (comb:lit #\p)
    (comb:lit #\q)
    (comb:lit #\r)
    (comb:lit #\s)
    (comb:lit #\t)
    (comb:lit #\u)
    (comb:lit #\v)
    (comb:lit #\w)
    (comb:lit #\x)
    (comb:lit #\y)
    (comb:lit #\z)
    (comb:lit #\A)
    (comb:lit #\B)
    (comb:lit #\C)
    (comb:lit #\D)
    (comb:lit #\E)
    (comb:lit #\F)
    (comb:lit #\G)
    (comb:lit #\H)
    (comb:lit #\I)
    (comb:lit #\J)
    (comb:lit #\K)
    (comb:lit #\L)
    (comb:lit #\M)
    (comb:lit #\N)
    (comb:lit #\O)
    (comb:lit #\P)
    (comb:lit #\Q)
    (comb:lit #\R)
    (comb:lit #\S)
    (comb:lit #\T)
    (comb:lit #\U)
    (comb:lit #\V)
    (comb:lit #\W)
    (comb:lit #\X)
    (comb:lit #\Y)
    (comb:lit #\Z)))

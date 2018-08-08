
(defpackage :pgen-asd
  (:use :cl :asdf))

(in-package :pgen-asd)

(defsystem parser-gen
  :version "0.0"
  :author  "Peter Elliott"
  :license "MIT"
  :components ((:module "src"
                :components
                ((:file "combinator")
                 (:file "input")
                 (:file "util")
                 (:file "misc")
                 (:file "parser-gen"))))
  :description "a parser generator")

;; -*- lisp -*-

;; This file is part of cl-parametric-types.
;; Copyright (c) 2016 Massimiliano Ghilardi
;;
;; This library is free software: you can redistribute it and/or
;; modify it under the terms of the Lisp Lesser General Public License
;; (http://opensource.franz.com/preamble.html), known as the LLGPL.
;;
;; This library is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty
;; of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
;; See the Lisp Lesser General Public License for more details.


(asdf:defsystem #:cl-parametric-types.libs
  :version "0.0.0"
  :author "Massimiliano Ghilardi"
  :license "LLGPL"
  :description "C++-style templates for Common Lisp. STL implementations"
  :depends-on (:cl-parametric-types)
  :pathname "libs/"
  :components
  ((:file "pair"))
  :in-order-to ((test-op (test-op :cl-parametric-types.test))))


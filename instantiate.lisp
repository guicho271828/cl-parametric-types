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


(in-package #:cl-parametric-types)


(defun multi-subst (values args tree)
  (declare (type list values args tree))
  (setf tree (nsubst (pop values) (pop args) (copy-tree tree)))
  (loop :for arg :in args
     :for value = (if values (pop values) t)
     :do (nsubst value arg tree))
  tree)

(defun kind-name (kind)
  (string-downcase (symbol-name kind)))

(defmethod get-definition ((kind symbol) (name symbol))
  (get name kind))

(defmethod (setf get-definition) (definition (kind symbol) (name symbol))
  (declare (type (or list (function (symbol list) (values symbol &optional)))
		 definition))
  (setf (get name kind) definition))

(defmethod instantiate-definition (kind name actual-types definition)
  (declare (type list actual-types definition))
  (let* ((formal-types     (second definition))
	 (definition-form  (third  definition))
	 (concrete (concretize kind name actual-types)))
    (unless definition
      (error "~A ~S has no ~S definition,
cannot instantiate ~S"
	     (kind-name kind) name kind (cons name actual-types)))
    `(progn
       (in-package ,(package-name (symbol-package name)))
       ,(multi-subst (cons concrete actual-types)
		     (cons name formal-types)
		     definition-form))))

(defmethod instantiate (kind name actual-types)
  (declare (type list actual-types))
  (let ((definition (get-definition kind name)))
    (etypecase definition
      (list  (eval (instantiate-definition kind name actual-types definition)))
      ((or symbol function) (funcall definition name actual-types)))))

(defmethod instantiate* (kind name actual-types)
  (declare (type list actual-types))
  (let ((abstract (cons name actual-types))
	(concrete (concretize kind name actual-types)))
    (handler-case
	(progn
	  (ecase kind
	    (template-function (fdefinition concrete))
	    (template-type     (find-class concrete))))
      (condition ()
	(log.debug "instantiating ~A ~S as ~S~%"
                   (kind-name kind) abstract concrete)
	(setf concrete (instantiate kind name actual-types))))
    concrete))



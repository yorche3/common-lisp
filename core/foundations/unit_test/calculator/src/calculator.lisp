(uiop:define-package calculator
  (:use #:cl)
  (:export #:addition
                #:subtraction
                #:multiplication
                #:division
                #:modulus))
(in-package #:calculator)

;; blah blah blah.
(defun addition (a b)
  (+ a b))

(defun subtraction (a b)
  (- a b))

(defun multiplication (a b)
  (let ((result 0))
    (loop for i from 1 to b do
         (setf result (addition result a)))
    result))

(defun division (a b)
  (let ((quotient 0)
        (rem a))
    (loop while (>= rem b) do
         (setf rem (subtraction rem b))
         (setf quotient (addition quotient 1)))
    quotient))

(defun modulus (a b)
  (let ((quotient (division a b)))
    (subtraction a (multiplication quotient b))))
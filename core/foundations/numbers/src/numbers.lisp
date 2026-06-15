(uiop:define-package numbers
  (:use #:cl)
  (:export #:sum-first-n-rec
          #:factorial-rec
          #:fibonacci-rec
          #:largest-common-divisor-rec
          #:least-common-multiple-rec
          #:sum-first-n-acc
          #:factorial-acc
          #:fibonacci-acc
          #:largest-common-divisor-acc
          #:least-common-multiple-acc
          #:sum-first-n-iter
          #:factorial-iter
          #:fibonacci-iter
          #:largest-common-divisor-iter
          #:least-common-multiple-iter))
(in-package #:numbers)

(defun sum-first-n-rec (n)
  (if (= n 0)
      0
      (+ n (sum-first-n-rec (- n 1)))))

(defun factorial-rec (n)
  (if (= n 0)
      1
      (* n (factorial-rec (- n 1)))))

(defun fibonacci-rec (n)
  (if (or (= n 0) (= n 1))
      n
      (+ (fibonacci-rec (- n 1))
         (fibonacci-rec (- n 2)))))

(defun largest-common-divisor-rec (a b)
  (if (= (rem a b) 0)
      b
      (largest-common-divisor-rec b (rem a b))))

(defun least-common-multiple-rec (a b)
  (let ((lcd (largest-common-divisor-rec a b)))
    (/ (* a b) lcd)))

(defun sum-first-n-help (n acc)
  (if (= n 0)
      acc
      (sum-first-n-help (- n 1) (+ acc n))))

(defun sum-first-n-acc (n)
  (sum-first-n-help n 0))

(defun factorial-help (n acc)
  (if (= n 0)
      acc
      (factorial-help (- n 1) (* acc n))))

(defun factorial-acc (n)
  (factorial-help n 1))

(defun fibonacci-help (n acc2 acc1)
  (if (<= n 0)
      acc2
      (fibonacci-help (- n 1) acc1 (+ acc2 acc1))))

(defun fibonacci-acc (n)
  (fibonacci-help n 0 1))

(defun largest-common-divisor-acc (a b)
  (if (= b 0)
      a
      (largest-common-divisor-acc b (rem a b))))

(defun least-common-multiple-acc (a b)
  (let ((lcd (largest-common-divisor-acc a b)))
    (/ (* a b) lcd)))

(defun sum-first-n-iter (n)
  (let ((acc 0))
    (loop for i from 1 to n do
         (setf acc (+ acc i)))
    acc))

(defun factorial-iter (n)
  (let ((acc 1))
    (loop for i from 1 to n do
         (setf acc (* acc i)))
    acc))

(defun fibonacci-iter (n)
  (let ((acc2 0)
        (acc1 1)
        (temp 0))
    (loop for i from 1 to n do
         (setf temp (+ acc2 acc1))
         (setf acc2 acc1)
         (setf acc1 temp))
    acc2))

(defun largest-common-divisor-iter (a b)
  (let ((r (rem a b)))
    (if (= r 0)
        b
        (largest-common-divisor-iter b r))))

(defun least-common-multiple-iter (a b)
  (let ((lcd (largest-common-divisor-iter a b)))
    (/ (* a b) lcd)))
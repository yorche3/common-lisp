(defpackage #:naive-sort
  (:use #:cl #:alexandria)
  (:export #:selection-sort
           #:bubble-sort
           #:insertion-sort))

(in-package #:naive-sort)

(defun selection-sort (arr)
  "Implementación de selection sort"
  (when (null arr)
    (return-from selection-sort nil))
  (let ((result (copy-seq arr))
        (len (length arr)))
    (loop for i from 0 below (1- len) do
      (let ((min-idx i))
        (loop for j from (1+ i) below len do
          (when (< (aref result j) (aref result min-idx))
            (setf min-idx j)))
        (rotatef (aref result i) (aref result min-idx))))
    result))

(defun bubble-sort (arr)
  "Implementación de bubble sort"
  (when (null arr)
    (return-from bubble-sort nil))
  (let ((result (copy-seq arr))
        (len (length arr)))
    (loop for i from 0 below (1- len) do
      (let ((swapped nil))
        (loop for j from 0 below (- len i 1) do
          (when (> (aref result j) (aref result (1+ j)))
            (rotatef (aref result j) (aref result (1+ j)))
            (setf swapped t)))
        (unless swapped
          (return))))
    result))

(defun insertion-sort (arr)
  "Implementación de insertion sort"
  (when (null arr)
    (return-from insertion-sort nil))
  (let ((result (copy-seq arr))
        (len (length arr)))
    (loop for i from 1 below len do
      (let ((key (aref result i))
            (j (1- i)))
        (loop while (and (>= j 0) (> (aref result j) key)) do
          (setf (aref result (1+ j)) (aref result j))
          (decf j))
        (setf (aref result (1+ j)) key)))
    result))
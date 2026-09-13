(defpackage #:naive-sort-test
  (:use #:cl #:naive-sort #:fiveam)
  (:export #:run-tests))

(in-package #:naive-sort-test)

(def-suite :naive-sort-suite
  :description "Suite de pruebas para naive-sort")
(in-suite :naive-sort-suite)

;; Definición de constantes para los casos de prueba
(defconstant +standard-input+ #(5 2 9 1 5 6))
(defconstant +standard-output+ #(1 2 5 5 6 9))

(defconstant +sorted-input+ #(1 2 3 4 5))
(defconstant +sorted-output+ #(1 2 3 4 5))

(defconstant +reverse-input+ #(5 4 3 2 1))
(defconstant +reverse-output+ #(1 2 3 4 5))

(defconstant +identical-input+ #(7 7 7 7))
(defconstant +identical-output+ #(7 7 7 7))

(defconstant +negative-input+ #(3 -1 4 -5 0))
(defconstant +negative-output+ #(-5 -1 0 3 4))

(defconstant +single-input+ #(42))
(defconstant +single-output+ #(42))

(defconstant +empty-input+ #())
(defconstant +empty-output+ #())

;; Helper para probar un algoritmo de ordenamiento
(defun test-sort-algorithm (sort-fn algorithm-name)
  "Helper que prueba un algoritmo de ordenamiento con los 7 casos estándar"
  ;; Caso 1: Array estándar desordenado
  (let ((result (copy-seq +standard-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +standard-output+)
        "~a should sort an unsorted array" algorithm-name))
  
  ;; Caso 2: Array ya ordenado
  (let ((result (copy-seq +sorted-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +sorted-output+)
        "~a should sort an already sorted array" algorithm-name))
  
  ;; Caso 3: Array en orden inverso
  (let ((result (copy-seq +reverse-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +reverse-output+)
        "~a should sort a reverse order array" algorithm-name))
  
  ;; Caso 4: Elementos idénticos
  (let ((result (copy-seq +identical-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +identical-output+)
        "~a should sort identical elements" algorithm-name))
  
  ;; Caso 5: Con números negativos
  (let ((result (copy-seq +negative-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +negative-output+)
        "~a should sort with negative numbers" algorithm-name))
  
  ;; Caso 6: Un solo elemento
  (let ((result (copy-seq +single-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +single-output+)
        "~a should sort single element" algorithm-name))
  
  ;; Caso 7: Array vacío
  (let ((result (copy-seq +empty-input+)))
    (setf result (funcall sort-fn result))
    (is (equal result +empty-output+)
        "~a should sort empty array" algorithm-name)))

;; Pruebas para selection sort
(test test-selection-sort
  (test-sort-algorithm #'selection-sort "selection_sort"))

;; Pruebas para bubble sort
(test test-bubble-sort
  (test-sort-algorithm #'bubble-sort "bubble_sort"))

;; Pruebas para insertion sort
(test test-insertion-sort
  (test-sort-algorithm #'insertion-sort "insertion_sort"))
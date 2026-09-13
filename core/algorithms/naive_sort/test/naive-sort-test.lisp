(defpackage naive-sort/tests
  (:use :cl
        :fiveam)
  (:export #:run-tests))
(in-package :naive-sort/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :naive-sort)' in your Lisp.

(def-suite naive-sort-suite
  :description "Suite of tests for selection-sort, bubble-sort and insertion-sort")
(in-suite naive-sort-suite)

;; ---------------------------------------------------------------------------
;; Fixtures: one named constant per input/output case.
;; ---------------------------------------------------------------------------

;; Case 1 - standard unsorted array
(defparameter +standard-input+ #(5 2 9 1 5 6))
(defparameter +standard-output+ #(1 2 5 5 6 9))

;; Case 2 - already sorted array
(defparameter +sorted-input+ #(1 2 3 4 5))
(defparameter +sorted-output+ #(1 2 3 4 5))

;; Case 3 - reverse order array
(defparameter +reverse-input+ #(5 4 3 2 1))
(defparameter +reverse-output+ #(1 2 3 4 5))

;; Case 4 - identical elements
(defparameter +identical-input+ #(7 7 7 7))
(defparameter +identical-output+ #(7 7 7 7))

;; Case 5 - negative numbers
(defparameter +negative-input+ #(3 -1 4 -5 0))
(defparameter +negative-output+ #(-5 -1 0 3 4))

;; Case 6 - single element
(defparameter +single-input+ #(42))
(defparameter +single-output+ #(42))

;; Case 7 - empty array
(defparameter +empty-input+ #())
(defparameter +empty-output+ #())

;; ---------------------------------------------------------------------------
;; Shared helper: runs the 7 assertions for a given sorting function.
;; The input is copied before calling SORT-FN so the fixtures stay pristine
;; even if an implementation mutates its argument in place.
;; ---------------------------------------------------------------------------

(defparameter +cases+
  (list (list +standard-input+  +standard-output+  "an unsorted array")
        (list +sorted-input+    +sorted-output+    "an already sorted array")
        (list +reverse-input+   +reverse-output+   "a reverse order array")
        (list +identical-input+ +identical-output+ "identical elements")
        (list +negative-input+  +negative-output+  "with negative numbers")
        (list +single-input+    +single-output+    "a single element")
        (list +empty-input+     +empty-output+     "an empty array")))

(defun check-sorting (sort-fn algorithm-name)
  "Assert that SORT-FN sorts each fixture into its expected output."
  (dolist (case +cases+)
    (destructuring-bind (input expected label) case
      (is (equalp (funcall sort-fn (copy-seq input)) expected)
          "~a should sort ~a" algorithm-name label))))

;; ---------------------------------------------------------------------------
;; One test per algorithm.
;; ---------------------------------------------------------------------------

(test test-selection-sort
  (check-sorting #'naive-sort:selection-sort "selection-sort"))

(test test-bubble-sort
  (check-sorting #'naive-sort:bubble-sort "bubble-sort"))

(test test-insertion-sort
  (check-sorting #'naive-sort:insertion-sort "insertion-sort"))

(defun run-tests ()
  (run! 'naive-sort-suite))
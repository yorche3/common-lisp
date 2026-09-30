(defpackage data-structures-basics/tests
  (:use :cl
        :data-structures-basics
        :fiveam)
  (:export #:run-tests))
(in-package :data-structures-basics/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :data-structures-basics)' in your Lisp.
;; NOTE: placeholder skeleton so the runner starts; the real cases belong to step 4c.

(def-suite data-structures-basics-suite
  :description "Suite of tests for node, linked-list, stack and queue")
(in-suite data-structures-basics-suite)

(test placeholder
  (is (= 1 1)))

(defun run-tests ()
  (run! 'data-structures-basics-suite))

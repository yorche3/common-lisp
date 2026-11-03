(defpackage data-structures-advanced/tests
  (:use :cl
        :data-structures-advanced
        :fiveam)
  (:export #:run-tests))
(in-package :data-structures-advanced/tests)

(def-suite data-structures-advanced-suite
  :description "Suite of tests for data-structures-advanced")
(in-suite data-structures-advanced-suite)

(defun run-tests ()
  (run! 'data-structures-advanced-suite))

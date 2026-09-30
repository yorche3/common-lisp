(defpackage data_structures_basics/tests/main
  (:use :cl
        :data_structures_basics
        :rove))
(in-package :data_structures_basics/tests/main)

;; NOTE: To run this test file, execute `(asdf:test-system :data_structures_basics)' in your Lisp.

(deftest test-target-1
  (testing "should (= 1 1) to be true"
    (ok (= 1 1))))

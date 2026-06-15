(defpackage calculator/tests
  (:use :cl
        :calculator
        :fiveam)
  (:export #:run-tests))
(in-package :calculator/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :calculator)' in your Lisp.

(def-suite calculator-suite
  :description "Suite of calculator tests")
(in-suite calculator-suite)

(test addition-test
  (is (= 5 (addition 2 3))))

(test subtraction-test
  (is (= 2 (subtraction 5 3))))

(test multiplication-test
  (is (= 12 (multiplication 3 4))))

(test division-test
  (is (= 3 (division 10 3))))

(test modulus-test
  (is (= 1 (modulus 10 3))))

(defun run-tests ()
  (run! 'calculator-suite))
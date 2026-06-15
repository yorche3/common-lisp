(defpackage numbers/tests
  (:use :cl
        :numbers
        :fiveam)
  (:export #:run-recursive-tests
           #:run-accumulator-tests
           #:run-iterative-tests
           #:run-tests))
(in-package :numbers/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :numbers)' in your Lisp.

(def-suite numbers-recursive-suite
  :description "Suite of recursive tests")
(in-suite numbers-recursive-suite)

(test sum-first-n-rec-test
  (is (= (numbers::sum-first-n-rec 0) 0) "Sum of first 0 natural numbers should be 0")
  (is (= (numbers::sum-first-n-rec 3) 6) "Sum of first 3 natural numbers should be 6"))

(test factorial-rec-test
  (is (= (numbers::factorial-rec 0) 1) "Factorial of 0 should be 1")
  (is (= (numbers::factorial-rec 4) 24) "Factorial of 4 should be 24"))

(test fibonacci-rec-test
  (is (= (numbers::fibonacci-rec 0) 0) "Fibonacci of 0 should be 0")
  (is (= (numbers::fibonacci-rec 1) 1) "Fibonacci of 1 should be 1")
  (is (= (numbers::fibonacci-rec 6) 8) "Fibonacci of 6 should be 8"))

(test largest-common-divisor-rec-test
  (is (= (numbers::largest-common-divisor-rec 12 8) 4) "Largest common divisor of 12 and 8 should be 4")
  (is (= (numbers::largest-common-divisor-rec 7 5) 1) "Largest common divisor of 7 and 5 should be 1"))

(test least-common-multiple-rec-test
  (is (= (numbers::least-common-multiple-rec 8 6) 24) "Least common multiple of 8 and 6 should be 24")
  (is (= (numbers::least-common-multiple-rec 6 4) 12) "Least common multiple of 6 and 4 should be 12"))

(defun run-recursive-tests ()
  (run! 'numbers-recursive-suite))
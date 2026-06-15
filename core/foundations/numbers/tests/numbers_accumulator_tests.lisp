(in-package :numbers/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :numbers)' in your Lisp.

(def-suite numbers-accumulator-suite
  :description "Suite of accumulator tests")
(in-suite numbers-accumulator-suite)

(test sum-first-n-acc-test
  (is (= (numbers::sum-first-n-acc 0) 0) "Sum of first 0 natural numbers should be 0")
  (is (= (numbers::sum-first-n-acc 3) 6) "Sum of first 3 natural numbers should be 6"))

(test factorial-acc-test
  (is (= (numbers::factorial-acc 0) 1) "Factorial of 0 should be 1")
  (is (= (numbers::factorial-acc 4) 24) "Factorial of 4 should be 24"))

(test fibonacci-acc-test
  (is (= (numbers::fibonacci-acc 0) 0) "Fibonacci of 0 should be 0")
  (is (= (numbers::fibonacci-acc 1) 1) "Fibonacci of 1 should be 1")
  (is (= (numbers::fibonacci-acc 6) 8) "Fibonacci of 6 should be 8"))

(test largest-common-divisor-acc-test
  (is (= (numbers::largest-common-divisor-acc 12 8) 4) "Largest common divisor of 12 and 8 should be 4")
  (is (= (numbers::largest-common-divisor-acc 7 5) 1) "Largest common divisor of 7 and 5 should be 1"))

(test least-common-multiple-acc-test
  (is (= (numbers::least-common-multiple-acc 8 6) 24) "Least common multiple of 8 and 6 should be 24")
  (is (= (numbers::least-common-multiple-acc 6 4) 12) "Least common multiple of 6 and 4 should be 12"))

(defun run-accumulator-tests ()
  (run! 'numbers-accumulator-suite))
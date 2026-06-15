(in-package :numbers/tests)

;; NOTE: To run this test file, execute `(asdf:test-system :numbers)' in your Lisp.

(def-suite numbers-iterative-suite
  :description "Suite of iterative tests")
(in-suite numbers-iterative-suite)

(test sum-first-n-iter-test
  (is (= (numbers::sum-first-n-iter 0) 0) "Sum of first 0 natural numbers should be 0")
  (is (= (numbers::sum-first-n-iter 3) 6) "Sum of first 3 natural numbers should be 6"))

(test factorial-iter-test
  (is (= (numbers::factorial-iter 0) 1) "Factorial of 0 should be 1")
  (is (= (numbers::factorial-iter 4) 24) "Factorial of 4 should be 24"))

(test fibonacci-iter-test
  (is (= (numbers::fibonacci-iter 0) 0) "Fibonacci of 0 should be 0")
  (is (= (numbers::fibonacci-iter 1) 1) "Fibonacci of 1 should be 1")
  (is (= (numbers::fibonacci-iter 6) 8) "Fibonacci of 6 should be 8"))

(test largest-common-divisor-iter-test
  (is (= (numbers::largest-common-divisor-iter 12 8) 4) "Largest common divisor of 12 and 8 should be 4")
  (is (= (numbers::largest-common-divisor-iter 7 5) 1) "Largest common divisor of 7 and 5 should be 1"))

(test least-common-multiple-iter-test
  (is (= (numbers::least-common-multiple-iter 8 6) 24) "Least common multiple of 8 and 6 should be 24")
  (is (= (numbers::least-common-multiple-iter 6 4) 12) "Least common multiple of 6 and 4 should be 12"))

(defun run-iterative-tests ()
  (run! 'numbers-iterative-suite))

(defun run-tests ()
  (run-recursive-tests)
  (run-accumulator-tests)
  (run-iterative-tests))
;; run-tests.lisp
(asdf:load-asd (merge-pathnames "numbers.asd" *load-pathname*))
(asdf:load-system :numbers/tests)
(numbers/tests:run-tests)
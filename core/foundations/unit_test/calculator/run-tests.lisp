;; run-tests.lisp
(asdf:load-asd (merge-pathnames "calculator.asd" *load-pathname*))
(asdf:load-system :calculator/tests)
(calculator/tests:run-tests)
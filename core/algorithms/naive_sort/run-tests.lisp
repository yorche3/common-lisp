;; run-tests.lisp
(asdf:load-asd (merge-pathnames "naive-sort.asd" *load-pathname*))
(asdf:load-system :naive-sort/tests)
(naive-sort/tests:run-tests)
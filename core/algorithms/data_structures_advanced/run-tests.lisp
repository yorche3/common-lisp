;; run-tests.lisp
(asdf:load-asd (merge-pathnames "data-structures-advanced.asd" *load-pathname*))
(asdf:load-system :data-structures-advanced/tests)
(data-structures-advanced/tests:run-tests)
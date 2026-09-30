;; run-tests.lisp
(asdf:load-asd (merge-pathnames "data-structures-basics.asd" *load-pathname*))
(asdf:load-system :data-structures-basics/tests)
(data-structures-basics/tests:run-tests)

(defsystem "naive-sort"
  :version "0.0.1"
  :author ""
  :license ""
  :description "Naive sorting algorithms (selection, bubble, insertion) in Common Lisp"
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "naive-sort"))))
  :in-order-to ((test-op (test-op "naive-sort/tests"))))

(defsystem "naive-sort/tests"
  :author ""
  :license ""
  :description "Test system for naive-sort"
  :depends-on ("naive-sort"
               "fiveam")
  :components ((:module "test"
                :components
                ((:file "naive-sort-test"))))
  :perform (test-op (op c) (uiop:symbol-call :naive-sort/tests :run-tests)))
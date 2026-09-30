(defsystem "data-structures-basics"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "data-structures-basics"))))
  :description ""
  :in-order-to ((test-op (test-op "data-structures-basics/tests"))))

(defsystem "data-structures-basics/tests"
  :author ""
  :license ""
  :depends-on ("data-structures-basics"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "data-structures-basics-test"))))
  :description "Test system for data-structures-basics"
  :perform (test-op (op c) (uiop:symbol-call :data-structures-basics/tests :run-tests)))

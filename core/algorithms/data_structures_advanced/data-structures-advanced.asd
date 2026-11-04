(defsystem "data-structures-advanced"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "data-structures-advanced"))))
  :description ""
  :in-order-to ((test-op (test-op "data-structures-advanced/tests"))))

(defsystem "data-structures-advanced/tests"
  :author ""
  :license ""
  :depends-on ("data-structures-advanced"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "data-structures-advanced-test"))))
  :description "Test system for data-structures-advanced"
  :perform (test-op (op c) (uiop:symbol-call :data-structures-advanced/tests :run-tests)))

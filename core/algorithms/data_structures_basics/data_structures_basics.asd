(defsystem "data_structures_basics"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "data_structures_basics/tests"))))

(defsystem "data_structures_basics/tests"
  :author ""
  :license ""
  :depends-on ("data_structures_basics"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for data_structures_basics"
  :perform (test-op (op c) (symbol-call :rove :run c)))

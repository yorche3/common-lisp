(defsystem "data_structures_advanced"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description ""
  :in-order-to ((test-op (test-op "data_structures_advanced/tests"))))

(defsystem "data_structures_advanced/tests"
  :author ""
  :license ""
  :depends-on ("data_structures_advanced"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "main"))))
  :description "Test system for data_structures_advanced"
  :perform (test-op (op c) (symbol-call :rove :run c)))

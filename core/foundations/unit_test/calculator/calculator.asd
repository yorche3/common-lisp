(defsystem "calculator"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "calculator"))))
  :description ""
  :in-order-to ((test-op (test-op "calculator/tests"))))

(defsystem "calculator/tests"
  :author ""
  :license ""
  :depends-on ("calculator"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "calculator_tests"))))
  :description "Test system for calculator"
  :perform (test-op (op c) (uiop:symbol-call :calculator/tests :run-tests)))

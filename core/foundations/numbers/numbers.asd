(defsystem "numbers"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "numbers"))))
  :description ""
  :in-order-to ((test-op (test-op "numbers/tests"))))

(defsystem "numbers/tests"
  :author ""
  :license ""
  :depends-on ("numbers"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "numbers_recursive_tests")
                 (:file "numbers_accumulator_tests")
                 (:file "numbers_iterative_tests"))))
  :description "Test system for numbers"
  :perform (test-op (op c) (uiop:symbol-call :numbers/tests :run-tests)))

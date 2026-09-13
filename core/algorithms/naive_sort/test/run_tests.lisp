;; run_tests.lisp - Ejecutar todas las pruebas para naive_sort

(defpackage #:naive-sort-run-tests
  (:use #:cl #:fiveam)
  (:export #:run-tests))

(in-package #:naive-sort-run-tests)

(defun run-tests ()
  "Ejecuta todas las pruebas para naive_sort"
  (let ((results (run! :naive-sort-suite)))
    (unless (fiveam::results-all-count results)
      (format t "No tests were run!~%")
      (return-from run-tests 1))
    (if (zerop (fiveam::results-failures results))
        (if (zerop (fiveam::results-errors results))
            (progn
              (format t "All tests passed!~%")
              0)
            (progn
              (format t "Tests completed with errors.~%")
              1))
        (progn
          (format t "Tests completed with failures.~%")
          1))))

;; Ejecutar las pruebas si este archivo se carga directamente
(when (member :naive-sort-run-tests *features*)
  (let ((exit-code (run-tests)))
    (unless (zerop exit-code)
      (sb-ext:exit :code exit-code))))
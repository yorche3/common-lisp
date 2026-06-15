#!/bin/sh
#|-*- mode: lisp -*-|#
#|
exec ros -Q -- $0 "$@"
|#
(progn ;;init forms
  )

(defun main (&rest argv)
  (declare (ignorable argv))
  (format t "Hello, World! from Common Lisp~%"))
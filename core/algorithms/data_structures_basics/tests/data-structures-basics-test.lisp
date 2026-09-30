(defpackage data-structures-basics/tests
  (:use :cl
        :data-structures-basics
        :fiveam)
  (:export #:run-tests))
(in-package :data-structures-basics/tests)

(def-suite data-structures-basics-suite
  :description "Suite of tests for node, linked-list, stack and queue")
(in-suite data-structures-basics-suite)

(defstruct test-case
  name
  operation
  expected-output)

(defparameter node-initialization-input 10)
(defparameter node-link-input 20)
(defparameter node-initialization-output '(10 nil))
(defparameter node-link-output '(20 nil))

(defparameter linked-list-tail-inputs '(10 20 10))
(defparameter linked-list-head-input 5)
(defparameter linked-list-absent-input 99)
(defparameter linked-list-empty-output '(t 0 nil))
(defparameter linked-list-insertion-output '(4 5))
(defparameter linked-list-first-deletion-output '(t 3 5))
(defparameter linked-list-absent-output '(nil 3 5))
(defparameter linked-list-final-deletion-output '(t t t t 0 nil))

(defparameter stack-inputs '(10 20 30))
(defparameter stack-reuse-input 40)
(defparameter stack-empty-output '(t 0 nil nil))
(defparameter stack-lifo-output '(30 3))
(defparameter stack-reuse-output '(30 40 20 10 t 0))
(defparameter stack-final-empty-output '(nil t))

(defparameter queue-inputs '(10 20 30))
(defparameter queue-reuse-input 40)
(defparameter queue-empty-output '(t 0 nil nil))
(defparameter queue-fifo-output '(10 3))
(defparameter queue-reuse-output '(10 20 30 40 t 0))
(defparameter queue-final-empty-output '(nil t))

(defun run-cases (subject cases)
  (dolist (case cases)
    (let ((actual-output (funcall (test-case-operation case))))
      (is (equal actual-output (test-case-expected-output case))
          "~A should return ~S for ~A, but returned ~S"
          subject
          (test-case-expected-output case)
          (test-case-name case)
          actual-output))))

(defun node-cases ()
  ;; `Node.init(value)` is `make-node :value`: `defstruct` provides the
  ;; constructor and the accessors, so the link is set through `node-next`.
  (let ((first-node (make-node :value node-initialization-input))
        (second-node (make-node :value node-link-input)))
    (list
     (make-test-case
      :name "initialize and observe value and absent link"
      :operation (lambda ()
                   (list (node-value first-node)
                         (node-next first-node)))
      :expected-output node-initialization-output)
     (make-test-case
      :name "initialize another node, link, and traverse"
      :operation (lambda ()
                   (setf (node-next first-node) second-node)
                   (list (node-value (node-next first-node))
                         (node-next second-node)))
      :expected-output node-link-output))))

(defun linked-list-cases ()
  (let ((list-under-test (make-linked-list)))
    (list
     (make-test-case
      :name "empty state"
      :operation (lambda ()
                   (linked-list-init list-under-test)
                   (list (linked-list-is-empty list-under-test)
                         (linked-list-size list-under-test)
                         (linked-list-get-head list-under-test)))
      :expected-output linked-list-empty-output)
     (make-test-case
      :name "insert at both ends"
      :operation (lambda ()
                   (dolist (value linked-list-tail-inputs)
                     (linked-list-insert-tail list-under-test value))
                   (linked-list-insert-head list-under-test linked-list-head-input)
                   (list (linked-list-size list-under-test)
                         (linked-list-get-head list-under-test)))
      :expected-output linked-list-insertion-output)
     (make-test-case
      :name "delete first occurrence"
      :operation (lambda ()
                   (list (linked-list-delete list-under-test 10)
                         (linked-list-size list-under-test)
                         (linked-list-get-head list-under-test)))
      :expected-output linked-list-first-deletion-output)
     (make-test-case
      :name "delete absent value"
      :operation (lambda ()
                   (list (linked-list-delete list-under-test linked-list-absent-input)
                         (linked-list-size list-under-test)
                         (linked-list-get-head list-under-test)))
      :expected-output linked-list-absent-output)
     (make-test-case
      :name "empty the list"
      :operation (lambda ()
                   (list (linked-list-delete list-under-test 5)
                         (linked-list-delete list-under-test 20)
                         (linked-list-delete list-under-test 10)
                         (linked-list-is-empty list-under-test)
                         (linked-list-size list-under-test)
                         (linked-list-get-head list-under-test)))
      :expected-output linked-list-final-deletion-output))))

(defun stack-cases ()
  (let ((stack-under-test (make-stack)))
    (list
     (make-test-case
      :name "empty state and failed removal"
      :operation (lambda ()
                   (stack-init stack-under-test)
                   (list (stack-is-empty stack-under-test)
                         (stack-size stack-under-test)
                         (stack-peek stack-under-test)
                         (stack-pop stack-under-test)))
      :expected-output stack-empty-output)
     (make-test-case
      :name "LIFO and non-mutating peek"
      :operation (lambda ()
                   (dolist (value stack-inputs)
                     (stack-push stack-under-test value))
                   (list (stack-peek stack-under-test)
                         (stack-size stack-under-test)))
      :expected-output stack-lifo-output)
     (make-test-case
      :name "removal and reuse"
      :operation (lambda ()
                   (list (stack-pop stack-under-test)
                         (progn
                           (stack-push stack-under-test stack-reuse-input)
                           (stack-pop stack-under-test))
                         (stack-pop stack-under-test)
                         (stack-pop stack-under-test)
                         (stack-is-empty stack-under-test)
                         (stack-size stack-under-test)))
      :expected-output stack-reuse-output)
     (make-test-case
      :name "empty after removal"
      :operation (lambda ()
                   (list (stack-pop stack-under-test)
                         (stack-is-empty stack-under-test)))
      :expected-output stack-final-empty-output))))

(defun queue-cases ()
  (let ((queue-under-test (make-queue)))
    (list
     (make-test-case
      :name "empty state and failed removal"
      :operation (lambda ()
                   (queue-init queue-under-test)
                   (list (queue-is-empty queue-under-test)
                         (queue-size queue-under-test)
                         (queue-peek queue-under-test)
                         (queue-dequeue queue-under-test)))
      :expected-output queue-empty-output)
     (make-test-case
      :name "FIFO and non-mutating peek"
      :operation (lambda ()
                   (dolist (value queue-inputs)
                     (queue-enqueue queue-under-test value))
                   (list (queue-peek queue-under-test)
                         (queue-size queue-under-test)))
      :expected-output queue-fifo-output)
     (make-test-case
      :name "removal and reuse"
      :operation (lambda ()
                   (list (queue-dequeue queue-under-test)
                         (progn
                           (queue-enqueue queue-under-test queue-reuse-input)
                           (queue-dequeue queue-under-test))
                         (queue-dequeue queue-under-test)
                         (queue-dequeue queue-under-test)
                         (queue-is-empty queue-under-test)
                         (queue-size queue-under-test)))
      :expected-output queue-reuse-output)
     (make-test-case
      :name "empty after removal"
      :operation (lambda ()
                   (list (queue-dequeue queue-under-test)
                         (queue-is-empty queue-under-test)))
      :expected-output queue-final-empty-output))))

(test node-test
  (run-cases "Node" (node-cases)))

(test linked-list-test
  (run-cases "LinkedList" (linked-list-cases)))

(test stack-test
  (run-cases "Stack" (stack-cases)))

(test queue-test
  (run-cases "Queue" (queue-cases)))

(defun run-tests ()
  (run! 'data-structures-basics-suite))

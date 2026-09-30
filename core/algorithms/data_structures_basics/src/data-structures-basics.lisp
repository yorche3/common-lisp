(uiop:define-package data-structures-basics
  (:use #:cl)
  (:export #:node
           #:make-node
           #:node-init
           #:node-get-value
           #:node-get-next
           #:node-set-next
           #:linked-list
           #:make-linked-list
           #:linked-list-init
           #:linked-list-get-head
           #:linked-list-insert-head
           #:linked-list-insert-tail
           #:linked-list-delete
           #:linked-list-is-empty
           #:linked-list-size
           #:stack
           #:make-stack
           #:stack-init
           #:stack-push
           #:stack-pop
           #:stack-peek
           #:stack-is-empty
           #:stack-size
           #:queue
           #:make-queue
           #:queue-init
           #:queue-enqueue
           #:queue-dequeue
           #:queue-peek
           #:queue-is-empty
           #:queue-size))
(in-package #:data-structures-basics)

(defstruct node
  value
  next)

(defstruct linked-list
  head
  tail
  count)

(defstruct stack
  top
  count)

(defstruct queue
  front
  rear
  count)

(defun node-init (node value)
  (declare (ignore node value))
  nil)

(defun node-get-value (node)
  (declare (ignore node))
  nil)

(defun node-get-next (node)
  (declare (ignore node))
  nil)

(defun node-set-next (node next)
  (declare (ignore node next))
  nil)

(defun linked-list-init (linked-list)
  (declare (ignore linked-list))
  nil)

(defun linked-list-get-head (linked-list)
  (declare (ignore linked-list))
  nil)

(defun linked-list-insert-head (linked-list value)
  (declare (ignore linked-list value))
  nil)

(defun linked-list-insert-tail (linked-list value)
  (declare (ignore linked-list value))
  nil)

(defun linked-list-delete (linked-list value)
  (declare (ignore linked-list value))
  nil)

(defun linked-list-is-empty (linked-list)
  (declare (ignore linked-list))
  nil)

(defun linked-list-size (linked-list)
  (declare (ignore linked-list))
  nil)

(defun stack-init (stack)
  (declare (ignore stack))
  nil)

(defun stack-push (stack value)
  (declare (ignore stack value))
  nil)

(defun stack-pop (stack)
  (declare (ignore stack))
  nil)

(defun stack-peek (stack)
  (declare (ignore stack))
  nil)

(defun stack-is-empty (stack)
  (declare (ignore stack))
  nil)

(defun stack-size (stack)
  (declare (ignore stack))
  nil)

(defun queue-init (queue)
  (declare (ignore queue))
  nil)

(defun queue-enqueue (queue value)
  (declare (ignore queue value))
  nil)

(defun queue-dequeue (queue)
  (declare (ignore queue))
  nil)

(defun queue-peek (queue)
  (declare (ignore queue))
  nil)

(defun queue-is-empty (queue)
  (declare (ignore queue))
  nil)

(defun queue-size (queue)
  (declare (ignore queue))
  nil)

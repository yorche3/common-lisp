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

(def failure-value nil)

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

(defun linked-list-init (linked-list)
  (make-linked-list :head nil :tail nil :count 0))

(defun linked-list-is-empty (linked-list)
  (zerop (linked-list-count linked-list)))

(defun linked-list-size (linked-list)
  (linked-list-count linked-list))

(defun linked-list-get-head (linked-list)
  (if (not (linked-list-is-empty linked-list))
      (linked-list-head linked-list)
      failure-value))

(defun linked-list-insert-head (linked-list value)
  (let ((new-node (make-node :value value :next (linked-list-head linked-list))))
    (if (linked-list-is-empty linked-list)
        (setf (linked-list-tail linked-list) new-node))
    (setf (linked-list-head linked-list) new-node)
    (incf (linked-list-count linked-list))
    new-node))

(defun linked-list-insert-tail (linked-list value)
  (let ((new-node (make-node :value value :next nil)))
    (if (linked-list-is-empty linked-list)
        (setf (linked-list-head linked-list) new-node)
        (setf (node-next (linked-list-tail linked-list)) new-node))
    (setf (linked-list-tail linked-list) new-node)
    (incf (linked-list-count linked-list))
    new-node))

(defun linked-list-delete (linked-list value)
  (let ((prev nil)
        (current (linked-list-head linked-list)))
    (loop while current do
         (if (eql (node-value current) value)
             (progn
               (if prev
                   (setf (node-next prev) (node-next current))
                   (setf (linked-list-head linked-list) (node-next current)))
               (when (eql (linked-list-tail linked-list) current)
                 (setf (linked-list-tail linked-list) prev))
               (decf (linked-list-count linked-list))
               (return current))
             (setf prev current
                   current (node-next current))))
    failure-value))

(defun stack-init (stack)
  (make-stack :top nil :count 0))

(defun stack-is-empty (stack)
    (zerop (stack-count stack)))

(defun stack-size (stack)
  (stack-count stack))

(defun stack-push (stack value)
  (setf (stack-top stack) (make-node :value value :next (stack-top stack)))
  (incf (stack-count stack))
  (stack-top stack))

(defun stack-peek (stack)
  (if (stack-is-empty stack)
      failure-value
      (stack-top stack)))

(defun stack-pop (stack)
  (if (stack-is-empty stack)
      failure-value
      (let ((top-node (stack-top stack)))
        (setf (stack-top stack) (node-next top-node))
        (decf (stack-count stack))
        top-node)))

(defun queue-init (queue)
  (make-queue :front nil :rear nil :count 0))

(defun queue-is-empty (queue)
  (zerop (queue-count queue)))

(defun queue-size (queue)
  (queue-count queue))

(defun queue-enqueue (queue value)
  (let ((new-node (make-node :value value :next nil)))
    (if (queue-is-empty queue)
        (setf (queue-front queue) new-node)
        (setf (node-next (queue-rear queue)) new-node))
    (setf (queue-rear queue) new-node)
    (incf (queue-count queue))
    new-node))

(defun queue-peek (queue)
  (if (queue-is-empty queue)
      failure-value
      (queue-front queue)))

(defun queue-dequeue (queue)
  (if (queue-is-empty queue)
      failure-value
      (let ((front-node (queue-front queue)))
        (setf (queue-front queue) (node-next front-node))
        (when (null (queue-front queue))
          (setf (queue-rear queue) nil))
        (decf (queue-count queue))
        front-node)))

;;;; package.lisp

(defpackage #:data_structures_basics
  (:use #:cl)
  (:export #:node
           #:linked-list
           #:stack
           #:queue
           #:node-init
           #:node-get-value
           #:node-get-next
           #:node-set-next
           #:linked-list-init
           #:linked-list-get-head
           #:linked-list-insert-head
           #:linked-list-insert-tail
           #:linked-list-delete
           #:linked-list-is-empty
           #:linked-list-size
           #:stack-init
           #:stack-push
           #:stack-pop
           #:stack-peek
           #:stack-is-empty
           #:stack-size
           #:queue-init
           #:queue-enqueue
           #:queue-dequeue
           #:queue-peek
           #:queue-is-empty
           #:queue-size))

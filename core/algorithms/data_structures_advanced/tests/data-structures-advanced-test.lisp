(defpackage data-structures-advanced/tests
  (:use :cl
        :data-structures-advanced
        :fiveam)
  (:export #:run-tests))
(in-package :data-structures-advanced/tests)

(def-suite data-structures-advanced-suite
  :description "Suite of tests for data-structures-advanced")
(in-suite data-structures-advanced-suite)

;; Result codes of the contract: 0 success/yes, -1 failure/no.
;; Every operation uses the same pair, questions included; T/nil is not used
;; because nil is also the absence atom for a missing link.
(defparameter success 0)
(defparameter failure -1)

(defstruct test-case
  name
  operation
  expected-output)

;; TreeNode inputs and outputs
(defparameter tree-node-parent-input 10)
(defparameter tree-node-left-input 20)
(defparameter tree-node-right-input 30)
(defparameter tree-node-initialization-output '(10))
(defparameter tree-node-absent-links-output '(nil nil))
(defparameter tree-node-link-output '(20 30))
(defparameter tree-node-traversal-output '(20 30 nil nil nil nil))
(defparameter tree-node-unlink-output '(10 30 10 nil nil))

;; BinaryTree inputs and outputs
(defparameter binary-tree-root-input '(50))
(defparameter binary-tree-lower-higher-input '(50 30 70))
(defparameter binary-tree-multilevel-input '(50 30 70 20 40))
(defparameter binary-tree-duplicate-input '(50 30 70 30))
(defparameter binary-tree-ordered-input '(20 30 40 50 70))
(defparameter binary-tree-absent-input 99)
(defparameter binary-tree-empty-output '(0 0 -1))
(defparameter binary-tree-root-output '(0 1 -1 0))
(defparameter binary-tree-lower-higher-output '((0 0 0) 3 (0 0 0)))
(defparameter binary-tree-multilevel-output '((0 0 0 0 0) (0 0 0 0 0) 5))
(defparameter binary-tree-missing-output '(-1 1 0))
(defparameter binary-tree-duplicate-output '((0 0 0 0) 3 (0 0 0)))
(defparameter binary-tree-ordered-output '((0 0 0 0 0) 5 (0 0 0 0 0) -1))

;; Graph inputs and outputs
(defparameter graph-missing-vertex-input 99)
(defparameter graph-empty-output '(0 0 0 -1 (nil -1)))
(defparameter graph-isolated-output '(0 -1 1 0 (nil 0)))
(defparameter graph-directed-output '(0 0 -1 2 1))
(defparameter graph-duplicate-vertex-output '(0 0 2 1 ((30) 0)))
(defparameter graph-duplicate-edge-output '((0 0) 2 1 ((30) 0)))
(defparameter graph-missing-endpoint-output
  '((-1 -1 -1 -1) 2 1 ((30) 0) (nil 0) (-1 -1 -1 -1) (nil -1) (nil -1)))
(defparameter graph-sorted-output
  '((0 0 0 0) (0 0 0 0) ((30 50 70) 0) ((50) 0) (nil 0) (nil 0) 4 4))
(defparameter graph-missing-edge-output '(-1 2 0 -1))
(defparameter graph-missing-neighbors-output '((nil -1) (nil 0) 1 0))
(defparameter graph-self-loop-output '(0 0 0 ((10) 0) 1 1))
(defparameter graph-isolation-output '(0 ((30) 0) (30) ((30 50) 0) 3 2))

(defun run-cases (subject cases)
  (dolist (case cases)
    (let ((actual-output (funcall (test-case-operation case))))
      (is (equal actual-output (test-case-expected-output case))
          "~A should return ~S for ~A, but returned ~S"
          subject
          (test-case-expected-output case)
          (test-case-name case)
          actual-output))))

(defun neighbors-of (graph label)
  (multiple-value-list (graph-get-neighbors graph label)))

(defun fresh-tree ()
  (binary-tree-init))

(defun fresh-graph (&rest labels)
  (let ((graph (graph-init)))
    (dolist (label labels)
      (graph-add-vertex graph label))
    graph))

(defun insert-all (tree values)
  (mapcar (lambda (value) (binary-tree-insert tree value)) values))

(defun contains-all (tree values)
  (mapcar (lambda (value) (binary-tree-contains tree value)) values))

(defun add-edges (graph edges)
  (mapcar (lambda (edge) (graph-add-edge graph (first edge) (second edge)))
          edges))

(defun tree-node-cases ()
  ;; Every row builds its own nodes: no state is shared between cases.
  (list
   (make-test-case
    :name "create a tree node"
    :operation (lambda ()
                 (let ((node (tree-node-init tree-node-parent-input)))
                   (list (tree-node-get-value node))))
    :expected-output tree-node-initialization-output)
   (make-test-case
    :name "absent initial links"
    :operation (lambda ()
                 (let ((node (tree-node-init tree-node-parent-input)))
                   (list (tree-node-get-left node)
                         (tree-node-get-right node))))
    :expected-output tree-node-absent-links-output)
   (make-test-case
    :name "link two children"
    :operation (lambda ()
                 (let ((parent (tree-node-init tree-node-parent-input)))
                   (tree-node-set-left parent (tree-node-init tree-node-left-input))
                   (tree-node-set-right parent (tree-node-init tree-node-right-input))
                   (list (tree-node-get-value (tree-node-get-left parent))
                         (tree-node-get-value (tree-node-get-right parent)))))
    :expected-output tree-node-link-output)
   (make-test-case
    :name "traverse each link"
    :operation (lambda ()
                 (let ((parent (tree-node-init tree-node-parent-input)))
                   (tree-node-set-left parent (tree-node-init tree-node-left-input))
                   (tree-node-set-right parent (tree-node-init tree-node-right-input))
                   (let ((left (tree-node-get-left parent))
                         (right (tree-node-get-right parent)))
                     (list (tree-node-get-value left)
                           (tree-node-get-value right)
                           (tree-node-get-left left)
                           (tree-node-get-right left)
                           (tree-node-get-left right)
                           (tree-node-get-right right)))))
    :expected-output tree-node-traversal-output)
   (make-test-case
    :name "unlink children"
    :operation (lambda ()
                 (let ((parent (tree-node-init tree-node-parent-input))
                       (left (tree-node-init tree-node-left-input))
                       (right (tree-node-init tree-node-right-input)))
                   (tree-node-set-left parent left)
                   (tree-node-set-right parent right)
                   (tree-node-set-left parent nil)
                   (let ((after-left (list (tree-node-get-value parent)
                                           (let ((kept (tree-node-get-right parent)))
                                             (and kept (tree-node-get-value kept))))))
                     (tree-node-set-right parent nil)
                     (append after-left
                             (list (tree-node-get-value parent)
                                   (tree-node-get-left parent)
                                   (tree-node-get-right parent))))))
    :expected-output tree-node-unlink-output)))

(defun binary-tree-cases ()
  (list
   (make-test-case
    :name "create empty"
    :operation (lambda ()
                 (let ((tree (fresh-tree)))
                   (list (binary-tree-is-empty tree)
                         (binary-tree-size tree)
                         (binary-tree-contains tree 50))))
    :expected-output binary-tree-empty-output)
   (make-test-case
    :name "insert the root"
    :operation (lambda ()
                 (let* ((tree (fresh-tree))
                        (insertion (binary-tree-insert tree (first binary-tree-root-input))))
                   (list insertion
                         (binary-tree-size tree)
                         (binary-tree-is-empty tree)
                         (binary-tree-contains tree 50))))
    :expected-output binary-tree-root-output)
   (make-test-case
    :name "insert lower and higher"
    :operation (lambda ()
                 (let* ((tree (fresh-tree))
                        (insertions (insert-all tree binary-tree-lower-higher-input)))
                   (list insertions
                         (binary-tree-size tree)
                         (contains-all tree binary-tree-lower-higher-input))))
    :expected-output binary-tree-lower-higher-output)
   (make-test-case
    :name "multilevel branches"
    :operation (lambda ()
                 (let* ((tree (fresh-tree))
                        (insertions (insert-all tree binary-tree-multilevel-input)))
                   (list insertions
                         (contains-all tree binary-tree-multilevel-input)
                         (binary-tree-size tree))))
    :expected-output binary-tree-multilevel-output)
   (make-test-case
    :name "missing value in nonempty tree"
    :operation (lambda ()
                 (let ((tree (fresh-tree)))
                   (binary-tree-insert tree 50)
                   (list (binary-tree-contains tree binary-tree-absent-input)
                         (binary-tree-size tree)
                         (binary-tree-contains tree 50))))
    :expected-output binary-tree-missing-output)
   (make-test-case
    :name "idempotent duplicate"
    :operation (lambda ()
                 (let* ((tree (fresh-tree))
                        (insertions (insert-all tree binary-tree-duplicate-input)))
                   (list insertions
                         (binary-tree-size tree)
                         (contains-all tree '(50 30 70)))))
    :expected-output binary-tree-duplicate-output)
   (make-test-case
    :name "ordered insertions"
    :operation (lambda ()
                 (let* ((tree (fresh-tree))
                        (insertions (insert-all tree binary-tree-ordered-input)))
                   (list insertions
                         (binary-tree-size tree)
                         (contains-all tree binary-tree-ordered-input)
                         (binary-tree-contains tree binary-tree-absent-input))))
    :expected-output binary-tree-ordered-output)))

(defun graph-cases ()
  (list
   (make-test-case
    :name "create empty"
    :operation (lambda ()
                 (let ((graph (fresh-graph)))
                   (list (graph-is-empty graph)
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (graph-has-edge graph 10 30)
                         (neighbors-of graph 10))))
    :expected-output graph-empty-output)
   (make-test-case
    :name "isolated vertex"
    :operation (lambda ()
                 (let* ((graph (fresh-graph))
                        (insertion (graph-add-vertex graph 10)))
                   (list insertion
                         (graph-is-empty graph)
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (neighbors-of graph 10))))
    :expected-output graph-isolated-output)
   (make-test-case
    :name "nonconsecutive labels and directed edge"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 70)))
                   (list (graph-add-edge graph 10 70)
                         (graph-has-edge graph 10 70)
                         (graph-has-edge graph 70 10)
                         (graph-vertex-count graph)
                         (graph-edge-count graph))))
    :expected-output graph-directed-output)
   (make-test-case
    :name "duplicate vertex preserves adjacency"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 30)))
                   (list (graph-add-edge graph 10 30)
                         (graph-add-vertex graph 10)
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (neighbors-of graph 10))))
    :expected-output graph-duplicate-vertex-output)
   (make-test-case
    :name "duplicate edge"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 30)))
                   (list (add-edges graph '((10 30) (10 30)))
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (neighbors-of graph 10))))
    :expected-output graph-duplicate-edge-output)
   (make-test-case
    :name "missing endpoint without mutation"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 30)))
                   (graph-add-edge graph 10 30)
                   (list (add-edges graph '((10 99) (99 10) (98 99) (99 99)))
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (neighbors-of graph 10)
                         (neighbors-of graph 30)
                         (list (graph-has-edge graph 10 99)
                               (graph-has-edge graph 99 10)
                               (graph-has-edge graph 98 99)
                               (graph-has-edge graph 99 99))
                         (neighbors-of graph 98)
                         (neighbors-of graph 99))))
    :expected-output graph-missing-endpoint-output)
   (make-test-case
    :name "sorted neighbours and counts"
    :operation (lambda ()
                 (let* ((graph (graph-init))
                        (vertices (mapcar (lambda (label) (graph-add-vertex graph label))
                                          '(10 30 50 70)))
                        (edges (add-edges graph '((10 70) (10 30) (10 50) (30 50)))))
                   (list vertices
                         edges
                         (neighbors-of graph 10)
                         (neighbors-of graph 30)
                         (neighbors-of graph 50)
                         (neighbors-of graph 70)
                         (graph-vertex-count graph)
                         (graph-edge-count graph))))
    :expected-output graph-sorted-output)
   (make-test-case
    :name "missing-edge query"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 30)))
                   (list (graph-has-edge graph 10 30)
                         (graph-vertex-count graph)
                         (graph-edge-count graph)
                         (graph-is-empty graph))))
    :expected-output graph-missing-edge-output)
   (make-test-case
    :name "neighbours of missing vertex"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10)))
                   (list (neighbors-of graph graph-missing-vertex-input)
                         (neighbors-of graph 10)
                         (graph-vertex-count graph)
                         (graph-edge-count graph))))
    :expected-output graph-missing-neighbors-output)
   (make-test-case
    :name "self-loop and duplicate"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10)))
                   (list (graph-add-edge graph 10 10)
                         (graph-add-edge graph 10 10)
                         (graph-has-edge graph 10 10)
                         (neighbors-of graph 10)
                         (graph-vertex-count graph)
                         (graph-edge-count graph))))
    :expected-output graph-self-loop-output)
   (make-test-case
    :name "neighbour-result isolation"
    :operation (lambda ()
                 (let ((graph (fresh-graph 10 30 50)))
                   (graph-add-edge graph 10 30)
                   (let ((saved (graph-get-neighbors graph 10))
                         (copy (graph-get-neighbors graph 10)))
                     ;; Lists are mutable in Common Lisp: change one returned copy.
                     (when (consp copy)
                       (setf (first copy) 99))
                     (let ((unchanged (neighbors-of graph 10))
                           (insertion (graph-add-edge graph 10 50)))
                       (list insertion
                             unchanged
                             saved
                             (neighbors-of graph 10)
                             (graph-vertex-count graph)
                             (graph-edge-count graph))))))
    :expected-output graph-isolation-output)))

(test tree-node-test
  (run-cases "TreeNode" (tree-node-cases)))

(test binary-tree-test
  (run-cases "BinaryTree" (binary-tree-cases)))

(test graph-test
  (run-cases "Graph" (graph-cases)))

(defun run-tests ()
  (let ((passed (run! 'data-structures-advanced-suite)))
    (unless passed
      (uiop:quit 1))
    passed))

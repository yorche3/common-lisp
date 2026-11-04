;;;; data_structures_advanced: modulo 07 en Common Lisp.
;;;; Resultado: 0 exito o "si", -1 fallo o "no"; ausencia de enlace: nil.
;;;; get-neighbors entrega (values lista resultado). Las desviaciones
;;;; (C2 del codigo, C4 de la mutacion) van en el README del modulo.

(uiop:define-package data-structures-advanced
  (:use #:cl)
  (:export #:tree-node-init
           #:tree-node-get-value
           #:tree-node-get-left
           #:tree-node-get-right
           #:tree-node-set-left
           #:tree-node-set-right
           #:binary-tree-init
           #:binary-tree-insert
           #:binary-tree-contains
           #:binary-tree-is-empty
           #:binary-tree-size
           #:graph-init
           #:graph-add-vertex
           #:graph-add-edge
           #:graph-has-edge
           #:graph-get-neighbors
           #:graph-is-empty
           #:graph-vertex-count
           #:graph-edge-count))
(in-package #:data-structures-advanced)

;; 0 = exito o "si"; -1 = fallo o "no".
(defconstant +success-value+ 0)
(defconstant +failure-value+ -1)

;; Sin herencia de estructuras en CL: cada nodo declara el valor.
(defstruct tree-node
  value
  left
  right)

(defstruct binary-tree
  root
  count)

(defstruct neighbor-node
  label
  next)

(defstruct graph-node
  label
  neighbors
  next-vertex)

;; vertex-total y edges: los accesores no deben pisar las operaciones publicas.
(defstruct graph
  vertices
  vertex-total
  edges)

(defun tree-node-init (value)
  "Integer -> tree-node. Crea el nodo con este valor y ambos enlaces ausentes."
  (make-tree-node :value value))

(defun tree-node-get-value (node)
  "tree-node -> Integer. Lee el valor embebido sin validar el nodo."
  (tree-node-value node))

(defun tree-node-get-left (node)
  "tree-node -> tree-node o nil. Lee el enlace izquierdo; nil es ausente."
  (tree-node-left node))

(defun tree-node-get-right (node)
  "tree-node -> tree-node o nil. Lee el enlace derecho; nil es ausente."
  (tree-node-right node))

(defun tree-node-set-left (node left)
  "tree-node, tree-node o nil -> tree-node. Muta el enlace izquierdo
conservando valor y enlace derecho; nil lo desenlaza."
  (setf (tree-node-left node) left)
  node)

(defun tree-node-set-right (node right)
  "tree-node, tree-node o nil -> tree-node. Muta el enlace derecho
conservando valor y enlace izquierdo; nil lo desenlaza."
  (setf (tree-node-right node) right)
  node)

(defun binary-tree-init ()
  "() -> binary-tree. Devuelve un arbol vacio y utilizable: raiz ausente y
tamano 0, sin parametro de capacidad."
  (make-binary-tree :count 0))

(defun binary-tree-insert (tree value)
  "binary-tree, Integer -> 0. Inserta el valor en el ABB y devuelve 0;
el duplicado tambien devuelve 0 y no crece el tamano. Nunca devuelve -1:
el agotamiento de memoria senala una storage-condition. La invariante ABB
(menores a la izquierda, mayores a la derecha) se mantiene."
  (let ((root (binary-tree-root tree)))
    (cond
      ((null root)
       (setf (binary-tree-root tree) (make-tree-node :value value))
       (incf (binary-tree-count tree))
       +success-value+)
      (t
       (loop with current = root
             for current-value = (tree-node-value current)
             do (cond
                  ((< value current-value)
                   (let ((child (tree-node-left current)))
                     (if child
                         (setf current child)
                         (progn
                           (setf (tree-node-left current)
                                 (make-tree-node :value value))
                           (incf (binary-tree-count tree))
                           (return +success-value+)))))
                  ((> value current-value)
                   (let ((child (tree-node-right current)))
                     (if child
                         (setf current child)
                         (progn
                           (setf (tree-node-right current)
                                 (make-tree-node :value value))
                           (incf (binary-tree-count tree))
                           (return +success-value+)))))
                  (t
                   (return +success-value+))))))))

(defun binary-tree-contains (tree value)
  "binary-tree, Integer -> 0 o -1. 0 si el valor esta, -1 si no; no muta."
  (let ((current (binary-tree-root tree)))
    (loop while current
          for current-value = (tree-node-value current)
          do (cond
               ((< value current-value)
                (setf current (tree-node-left current)))
               ((> value current-value)
                (setf current (tree-node-right current)))
               (t (return +success-value+)))
          finally (return +failure-value+))))

(defun binary-tree-is-empty (tree)
  "binary-tree -> 0 o -1. 0 si el arbol no tiene nodos, -1 si tiene alguno."
  (if (= (binary-tree-count tree) 0)
      +success-value+
      +failure-value+))

(defun binary-tree-size (tree)
  "binary-tree -> Integer. Numero de nodos, nunca negativo."
  (binary-tree-count tree))

(defun graph-init ()
  "() -> graph. Devuelve un grafo vacio y utilizable: 0 vertices y 0 aristas."
  (make-graph :vertex-total 0 :edges 0))

(defun %graph-find-vertex (graph label)
  "graph, Integer -> graph-node o nil. Recorre el registro enlazado de
vertices y devuelve el que tiene esta etiqueta, o nil si no existe."
  (loop for current = (graph-vertices graph)
          then (graph-node-next-vertex current)
        while current
        when (= label (graph-node-label current))
          return current))

(defun graph-add-vertex (graph label)
  "graph, Integer -> 0. Registra la etiqueta y devuelve 0, tambien si es
duplicada, conservando la adyacencia y los contadores."
  (unless (%graph-find-vertex graph label)
    (let ((node (make-graph-node :label label)))
      (setf (graph-node-next-vertex node) (graph-vertices graph))
      (setf (graph-vertices graph) node)
      (incf (graph-vertex-total graph))))
  +success-value+)

(defun graph-add-edge (graph u v)
  "graph, Integer, Integer -> 0 o -1. 0 si la arista dirigida queda registrada,
incluidos bucle y repetida; -1 si falta algun extremo, sin mutar ni crear
vertices implicitos."
  (let ((source (%graph-find-vertex graph u))
        (target (%graph-find-vertex graph v)))
    (if (or (null source) (null target))
        +failure-value+
        (let ((previous nil)
              (current (graph-node-neighbors source)))
          ;; Avanzar hasta el punto de insercion (adyacencia ordenada)
          (loop while (and current (< (neighbor-node-label current) v))
                do (setf previous current)
                   (setf current (neighbor-node-next current)))
          (cond
            ((and current (= (neighbor-node-label current) v))
             +success-value+)
            (t
             (let ((new-node (make-neighbor-node :label v :next current)))
               (if previous
                   (setf (neighbor-node-next previous) new-node)
                   (setf (graph-node-neighbors source) new-node))
               (incf (graph-edges graph))
               +success-value+)))))))

(defun graph-has-edge (graph u v)
  "graph, Integer, Integer -> 0 o -1. 0 si la arista dirigida existe; -1 si no
existe o falta algun extremo. No muta."
  (let ((source (%graph-find-vertex graph u))
        (target (%graph-find-vertex graph v)))
    (if (or (null source) (null target))
        +failure-value+
        (loop for current = (graph-node-neighbors source)
                then (neighbor-node-next current)
              while current
              when (= v (neighbor-node-label current))
                return +success-value+
              finally (return +failure-value+)))))

(defun graph-get-neighbors (graph u)
  "graph, Integer -> (values lista resultado). Lista ascendente y sin repetidos,
como copia nueva, con resultado 0; (values nil -1) si la etiqueta no esta
registrada y (values nil 0) si el vertice esta aislado."
  (let ((source (%graph-find-vertex graph u)))
    (if (null source)
        (values nil +failure-value+)
        (values (loop for current = (graph-node-neighbors source)
                        then (neighbor-node-next current)
                      while current
                      collect (neighbor-node-label current))
                +success-value+))))

(defun graph-is-empty (graph)
  "graph -> 0 o -1. 0 si no hay vertices registrados, -1 si hay alguno."
  (if (zerop (graph-vertex-total graph))
      +success-value+
      +failure-value+))

(defun graph-vertex-count (graph)
  "graph -> Integer. Numero de vertices, nunca negativo."
  (graph-vertex-total graph))

(defun graph-edge-count (graph)
  "graph -> Integer. Numero de aristas dirigidas, nunca negativo."
  (graph-edges graph))

;;;; Contrato de data_structures_advanced: tipos, firmas y esqueletos.
;;;; Los cuerpos quedan para el paso de implementacion; aqui solo se fija que
;;;; devuelve cada operacion y como se representa la ausencia.
;;;;
;;;; Forma (autoridad por aspecto, docs/AGENT_Template.md):
;;;;   - La base del mismo lenguaje manda en forma: data_structures_basics usa
;;;;     defstruct mutable y setf, y ya declara esa desviacion C4 en su README
;;;;     ("Mutacion con setf en campos de struct", justificada por el O(1)).
;;;;   - El pseudocodigo V2 (docs/ruleset/PSEUDOCODE_CONVENTION.md) clasifica
;;;;     la familia lisp como inmutable. Se sigue la base y se declara la
;;;;     distancia, como exige docs/ruleset/DEVIATION_POLICY.md: la adaptacion
;;;;     coherente con el paradigma del lenguaje esta permitida y lo prohibido
;;;;     es la mutacion sin declarar.
;;;;   - La spec 07 admite ambas formas: "Enlace actualizado, o nuevo nodo si
;;;;     el lenguaje es inmutable". Mutar no cambia el contrato.
;;;;
;;;; Resultados, por operacion (politica homologada del modulo 07):
;;;;   - Codigo de resultado: 0 exito, -1 fallo (+failure-value+). Es el
;;;;     centinela documentado que admite la regla 3 del ruleset: Common Lisp
;;;;     no tiene tipo de ausencia y la regla 2 solo prohibe -1 donde ya hay
;;;;     Option/Maybe. La familia "Dinamicos con null" del ruleset propone
;;;;     nil; se homologa el codigo con ada, assembly, cobol y clojure del
;;;;     mismo modulo, y la distancia se declara aqui como desviacion C2
;;;;     (representacion): un centinela -1 representable y exigido por el
;;;;     contrato no es defecto por existir un mecanismo nativo de ausencia.
;;;;   - Ausencia de enlace (get-left, get-right): nil, atomo nativo de
;;;;     ausencia. No es un fallo ni una respuesta: es el enlace que no existe.
;;;;   - Preguntas (contains, has-edge, is-empty): 0 si, -1 no. Todas comparten
;;;;     el par 0/-1 del modulo; no se usa T/nil porque nil es a la vez falso y
;;;;     ausencia en Common Lisp, y una pregunta no debe devolver el mismo
;;;;     objeto que un enlace ausente.
;;;;   - insert, add-vertex: 0 exito, tambien con duplicado; no hay capacidad
;;;;     ni estado lleno. -1 seria solo agotamiento de memoria, y Common Lisp
;;;;     lo senala con storage-condition, no con un valor de retorno.
;;;;   - add-edge: 0 si la arista dirigida queda registrada, incluidos bucle y
;;;;     repetida; -1 si falta algun extremo, y el fallo no muta nada.
;;;;   - size, vertex-count, edge-count: el numero, nunca negativo.
;;;;
;;;; Construccion: las tres operaciones *-init son la puerta publica y
;;;; devuelven una instancia nueva (tree-node-init un nodo; binary-tree-init y
;;;; graph-init la estructura vacia, sin argumentos), como pide la spec. Los
;;;; make-* que genera defstruct siguen existiendo como primitiva interna y no
;;;; se exportan: nadie fuera del paquete necesita construirlos a mano.
;;;;
;;;; get-neighbors devuelve DOS valores: (values vecinos resultado).
;;;;   Vertice ausente: (values nil -1). Vertice aislado: (values nil 0).
;;;;   El segundo valor es el estado de la consulta con el mismo codigo del
;;;;   resto del modulo.
;;;;   Con un solo valor la lista vacia y el fallo serian el mismo objeto
;;;;   (nil), porque en Common Lisp la lista vacia es nil.
;;;;   Los vecinos se entregan como lista nueva y ascendente: el resultado no
;;;;   cambia con aristas posteriores y el llamador no alcanza la adyacencia
;;;;   interna.
;;;;
;;;; graph-node y neighbor-node son internos a graph; no se exportan.

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

;; Codigo de resultado del modulo, el mismo en todas las operaciones:
;; 0 = exito o "si", -1 = fallo o "no". Las preguntas no devuelven T/nil
;; porque nil es tambien el atomo de ausencia: un enlace ausente y una
;; respuesta negativa no deben ser el mismo objeto.
(defconstant +success-value+ 0)
(defconstant +failure-value+ -1)

;; El valor vive en cada nodo concreto: las estructuras de Common Lisp no
;; heredan de otras estructuras, asi que tree-node y graph-node repiten el
;; campo en lugar de derivar de una base comun.
(defstruct tree-node
  value
  left
  right)

(defstruct binary-tree
  root
  count)

;; graph-node y neighbor-node son internos a graph; no se exportan.

(defstruct neighbor-node
  label
  next)

(defstruct graph-node
  label
  neighbors
  next-vertex)

;; Los campos de graph no se llaman vertex-count ni edge-count: los accesores
;; que genera defstruct ocuparian los nombres de las operaciones publicas y el
;; compilador rechaza la redefinicion.
(defstruct graph
  vertices
  vertex-total
  edges)

(defun tree-node-init (value)
  "Integer -> tree-node. Crea el nodo con este valor y ambos enlaces ausentes.
Es la puerta publica al constructor. Esqueleto: ausencia."
  (declare (ignore value))
  nil)

(defun tree-node-get-value (node)
  "tree-node -> Integer. Lee el valor embebido sin validar el nodo.
Esqueleto: ausencia."
  (declare (ignore node))
  +failure-value+)

(defun tree-node-get-left (node)
  "tree-node -> tree-node o nil. Lee el enlace izquierdo; nil es ausente.
Esqueleto: ausencia."
  (declare (ignore node))
  +failure-value+)

(defun tree-node-get-right (node)
  "tree-node -> tree-node o nil. Lee el enlace derecho; nil es ausente.
Esqueleto: ausencia."
  (declare (ignore node))
  +failure-value+)

(defun tree-node-set-left (node left)
  "tree-node, tree-node o nil -> tree-node. Muta el enlace izquierdo
conservando valor y enlace derecho; nil lo desenlaza. Esqueleto: nada."
  (declare (ignore node left))
  +failure-value+)

(defun tree-node-set-right (node right)
  "tree-node, tree-node o nil -> tree-node. Muta el enlace derecho
conservando valor y enlace izquierdo; nil lo desenlaza. Esqueleto: nada."
  (declare (ignore node right))
  +failure-value+)

(defun binary-tree-init ()
  "() -> binary-tree. Crea un arbol vacio y utilizable: raiz ausente y tamano
0, sin parametro de capacidad. Es la puerta publica al constructor; make-*
queda como primitiva interna. Esqueleto: ausencia."
  nil)

(defun binary-tree-insert (tree value)
  "binary-tree, Integer -> 0 o -1. Inserta el valor y devuelve 0; el duplicado
 tambien es exito y no crece el tamano. -1 solo cabria por agotamiento de
 memoria, que Common Lisp senala con storage-condition. Esqueleto: fallo."
  (declare (ignore tree value))
  +failure-value+)

(defun binary-tree-contains (tree value)
  "binary-tree, Integer -> 0 o -1. 0 si el valor esta, -1 si no; no muta.
Esqueleto: fallo."
  (declare (ignore tree value))
  +failure-value+)

(defun binary-tree-is-empty (tree)
  "binary-tree -> 0 o -1. 0 si el arbol no tiene nodos, -1 si tiene alguno.
Esqueleto: fallo."
  (declare (ignore tree))
  +failure-value+)

(defun binary-tree-size (tree)
  "binary-tree -> Integer. Numero de nodos, nunca negativo. Esqueleto: 0."
  (declare (ignore tree))
  0)

(defun graph-init ()
  "() -> graph. Crea un grafo vacio y utilizable: 0 vertices y 0 aristas.
Es la puerta publica al constructor; make-* queda como primitiva interna.
Esqueleto: ausencia."
  nil)

(defun graph-add-vertex (graph label)
  "graph, Integer -> 0 o -1. Registra la etiqueta y devuelve 0, tambien si es
 duplicada, conservando la adyacencia y los contadores. Esqueleto: fallo."
  (declare (ignore graph label))
  +failure-value+)

(defun graph-add-edge (graph u v)
  "graph, Integer, Integer -> 0 o -1. 0 si la arista dirigida queda registrada,
 incluidos bucle y repetida; -1 si falta algun extremo, sin mutar ni crear
 vertices implicitos. Esqueleto: fallo."
  (declare (ignore graph u v))
  +failure-value+)

(defun graph-has-edge (graph u v)
  "graph, Integer, Integer -> 0 o -1. 0 si la arista dirigida existe; -1 si no
existe o falta algun extremo. No muta. Esqueleto: fallo."
  (declare (ignore graph u v))
  +failure-value+)

(defun graph-get-neighbors (graph u)
  "graph, Integer -> (values lista resultado). Lista ascendente y sin repetidos,
 como copia nueva, con resultado 0; (values nil -1) si la etiqueta no esta
 registrada y (values nil 0) si el vertice esta aislado. Esqueleto: fallo."
  (declare (ignore graph u))
  (values nil +failure-value+))

(defun graph-is-empty (graph)
  "graph -> 0 o -1. 0 si no hay vertices registrados, -1 si hay alguno.
Esqueleto: fallo."
  (declare (ignore graph))
  +failure-value+)

(defun graph-vertex-count (graph)
  "graph -> Integer. Numero de vertices, nunca negativo. Esqueleto: 0."
  (declare (ignore graph))
  0)

(defun graph-edge-count (graph)
  "graph -> Integer. Numero de aristas dirigidas, nunca negativo.
Esqueleto: 0."
  (declare (ignore graph))
  0)

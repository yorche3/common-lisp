# Data Structures Advanced — Common Lisp

Implementación de la especificación [07_Data_Structures_Advanced](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

Implementa estructuras de datos avanzadas con múltiples enlaces por nodo —**TreeNode** (árbol binario de búsqueda, `BinaryTree`) y **GraphNode** (grafo dirigido con registro canónico enlazado y adyacencia ordenada, `Graph`)— construidas manualmente mediante `defstruct`, mutación de punteros con `setf`, códigos numéricos de resultado (`0` éxito, `-1` fallo) y representación nativa de ausencia de enlaces mediante `nil`.

---

## 📂 Archivos y estructura / Files & Structure

Describe la estructura del proyecto y el propósito de cada archivo.

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `data-structures-advanced.asd` | Sistemas ASDF — define `data-structures-advanced` y `data-structures-advanced/tests` / ASDF systems — defines `data-structures-advanced` and `data-structures-advanced/tests` |
| `src/data-structures-advanced.lisp` | Código fuente principal (`tree-node`, `binary-tree`, `neighbor-node`, `graph-node`, `graph`) / Main source code (`tree-node`, `binary-tree`, `neighbor-node`, `graph-node`, `graph`) |
| `tests/data-structures-advanced-test.lisp` | Pruebas unitarias con FiveAM (23 aserciones agrupadas en 3 tests) / Unit tests with FiveAM (23 assertions grouped into 3 tests) |
| `run-tests.lisp` | Script cargador y ejecutor de pruebas / Test loader and runner script |
| `.gitignore` | Archivos compilados excluidos (`*.fasl`, etc.) / Ignored compiled files (`*.fasl`, etc.) |

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se implementó manualmente utilizando estructuras nativas (`defstruct`) de Common Lisp para representar celdas y tipos de datos abstractos. El árbol binario (`BinaryTree`) mantiene una raíz mutable hacia nodos `tree-node` y gestiona las invariantes del ABB de forma iterativa (`loop`). El grafo dirigido (`Graph`) utiliza un registro enlazado canónico de vértices (`graph-node` enlazados por `next-vertex`) con búsqueda manual $O(V)$, y secuencias de adyacencia con inserción ordenada manual $O(d(u))$ mediante celdas `neighbor-node`. La gestión de construcción y dependencias se realiza con **ASDF**, y la suite de pruebas se orquesta con **FiveAM** sobre **Roswell (ros)**.

**EN:** The project was created manually using Common Lisp native structures (`defstruct`) to represent cells and abstract data types. The binary search tree (`BinaryTree`) maintains a mutable root pointing to `tree-node` cells and enforces BST invariants iteratively (`loop`). The directed graph (`Graph`) uses a canonical linked registry of vertices (`graph-node` linked by `next-vertex`) with manual $O(V)$ lookup, and adjacency sequences with manual sorted insertion $O(d(u))$ using `neighbor-node` cells. Dependency management and compilation are handled by **ASDF**, and the test suite is driven by **FiveAM** on **Roswell (ros)**.

---

## 📄 Configuración clave / Key Configuration

### `data-structures-advanced.asd` — Manifiesto ASDF / ASDF Manifest

**ES:** Declara el sistema principal `data-structures-advanced` (sin dependencias externas) y el sistema de pruebas `data-structures-advanced/tests` (con dependencia de `fiveam`).

**EN:** Declares the main system `data-structures-advanced` (no external dependencies) and the test system `data-structures-advanced/tests` (depending on `fiveam`).

```common-lisp
(defsystem "data-structures-advanced"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "data-structures-advanced"))))
  :description ""
  :in-order-to ((test-op (test-op "data-structures-advanced/tests"))))

(defsystem "data-structures-advanced/tests"
  :author ""
  :license ""
  :depends-on ("data-structures-advanced"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "data-structures-advanced-test"))))
  :description "Test system for data-structures-advanced"
  :perform (test-op (op c) (uiop:symbol-call :data-structures-advanced/tests :run-tests)))
```

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Compilación estática / Static compilation
ros run --eval '(asdf:load-asd (truename "data-structures-advanced.asd"))' \
        --eval '(asdf:compile-system :data-structures-advanced :force t)' \
        --eval '(asdf:compile-system :data-structures-advanced/tests :force t)' \
        --eval '(uiop:quit)'

# Ejecución de pruebas / Run tests
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

**Salida real / Actual output:**

```text
Running test suite DATA-STRUCTURES-ADVANCED-SUITE
 Running test TREE-NODE-TEST .....
 Running test BINARY-TREE-TEST .......
 Running test GRAPH-TEST ...........
 Did 23 checks.
    Pass: 23 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `tree-node-init` | `value → tree-node` | $O(1)$ | Crea un nodo de árbol con valor embebido y ambos enlaces en `nil` / Creates tree node with embedded value and both links `nil` |
| `tree-node-get-value` | `tree-node → integer` | $O(1)$ | Consulta el valor embebido / Accesses embedded value |
| `tree-node-get-left` | `tree-node → tree-node?` | $O(1)$ | Enlace izquierdo o `nil` si ausente / Left link or `nil` if absent |
| `tree-node-get-right` | `tree-node → tree-node?` | $O(1)$ | Enlace derecho o `nil` si ausente / Right link or `nil` if absent |
| `tree-node-set-left` | `tree-node, tree-node? → tree-node` | $O(1)$ | Muta enlace izquierdo con `setf` y devuelve el nodo / Mutates left link with `setf` and returns node |
| `tree-node-set-right` | `tree-node, tree-node? → tree-node` | $O(1)$ | Muta enlace derecho con `setf` y devuelve el nodo / Mutates right link with `setf` and returns node |
| `binary-tree-init` | `() → binary-tree` | $O(1)$ | Árbol vacío utilizable: raíz `nil` y tamaño `0` / Usable empty tree: root `nil` and size `0` |
| `binary-tree-insert` | `binary-tree, integer → 0` | $O(h)$ | Inserta según invariante ABB; duplicado devuelve `0` sin incrementar tamaño / Inserts following BST invariant; duplicate returns `0` without growing size |
| `binary-tree-contains` | `binary-tree, integer → 0 \| -1` | $O(h)$ | Búsqueda ABB; devuelve `0` si está presente y `-1` si no / BST lookup; returns `0` if present and `-1` if absent |
| `binary-tree-is-empty` | `binary-tree → 0 \| -1` | $O(1)$ | `0` si el árbol no tiene nodos, `-1` en caso contrario / `0` if tree has no nodes, `-1` otherwise |
| `binary-tree-size` | `binary-tree → integer` | $O(1)$ | Consulta el contador de nodos / Reads node count |
| `graph-init` | `() → graph` | $O(1)$ | Grafo vacío utilizable: 0 vértices y 0 aristas / Usable empty graph: 0 vertices and 0 edges |
| `graph-add-vertex` | `graph, integer → 0` | $O(V)$ | Registra vértice en el registro canónico; duplicado conserva adyacencia / Registers vertex in canonical registry; duplicate preserves adjacency |
| `graph-add-edge` | `graph, integer, integer → 0 \| -1` | $O(V + d(u))$ | Inserta arista ordenada en adyacencia; `-1` si falta algún extremo / Inserts sorted edge in adjacency; `-1` if either endpoint missing |
| `graph-has-edge` | `graph, integer, integer → 0 \| -1` | $O(V + d(u))$ | `0` si existe arista dirigida, `-1` si falta extremo o arista no existe / `0` if directed edge exists, `-1` if endpoint missing or edge absent |
| `graph-get-neighbors` | `graph, integer → (values list integer)` | $O(V + d(u))$ | Devuelve copia de vecinos y código de resultado (`0` éxito, `-1` si falta vértice) / Returns copy of neighbors and result code (`0` success, `-1` if vertex missing) |
| `graph-is-empty` | `graph → 0 \| -1` | $O(1)$ | `0` si no hay vértices registrados, `-1` en caso contrario / `0` if no vertices registered, `-1` otherwise |
| `graph-vertex-count` | `graph → integer` | $O(1)$ | Consulta contador de vértices / Reads vertex count |
| `graph-edge-count` | `graph → integer` | $O(1)$ | Consulta contador de aristas dirigidas / Reads directed edge count |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Valor embebido en `tree-node` y `graph-node` / Embedded value in `tree-node` and `graph-node` | Herencia de estructuras vía `(:include node)` / Structure inheritance via `(:include node)` | Common Lisp no requiere una jerarquía estricta de clases para estructuras manuales sencillas; la especificación autoriza explícitamente el valor embebido y evita indirecciones innecesarias. / Common Lisp does not require an inheritance hierarchy for simple manual structures; the specification explicitly authorizes embedded values and avoids unnecessary indirection. |
| Códigos de resultado enteros (`0` éxito, `-1` fallo) / Integer result codes (`0` success, `-1` failure) | Uso de booleanos nativos (`t` y `nil`) / Native boolean usage (`t` and `nil`) | En Common Lisp `nil` se utiliza canónicamente para representar la ausencia de enlace (`absent`). Usar `0` y `-1` evita colisiones y ambigüedades con `nil`, distinguiendo limpiamente un vértice aislado con lista vacía `(values nil 0)` de un vértice inexistente `(values nil -1)`. / In Common Lisp `nil` canonically represents absent links (`absent`). Using `0` and `-1` avoids collisions and ambiguity with `nil`, cleanly distinguishing an isolated vertex with an empty list `(values nil 0)` from a missing vertex `(values nil -1)`. |
| Retorno múltiple en `graph-get-neighbors` vía `values` / Multiple return values in `graph-get-neighbors` via `values` | Devolver centinela o lanzar condición / Returning a sentinel or signaling condition | Permite devolver tanto la secuencia independiente de vecinos como el código de estado (`0` o `-1`) sin recurrir a excepciones no controladas ni sobrecargar el átomo `nil`. / Allows returning both the independent neighbor sequence and the status code (`0` or `-1`) without unhandled exceptions or overloading the `nil` atom. |
| Registro canónico enlazado manual / Manual linked canonical registry | Tabla hash (`make-hash-table`) o diccionario estándar / Hash table (`make-hash-table`) or standard dictionary | La especificación prohíbe delegar el registro de vértices o la adyacencia en colecciones asociativas u optimizadas de biblioteca; el recorrido manual garantiza $O(V)$ y $O(d(u))$ reales. / The specification forbids delegating vertex registry or adjacency to library associative collections; manual traversal guarantees genuine $O(V)$ and $O(d(u))$ bounds. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Ubicación de pruebas `test/` / Test directory `test/` | Carpeta `tests/` / Directory `tests/` | Convención estándar en proyectos ASDF y suites FiveAM en Common Lisp. / Standard convention for ASDF projects and FiveAM test suites in Common Lisp. |
| Nomenclatura orientada a objetos `BinaryTree.insert(v)` / OOP method naming `BinaryTree.insert(v)` | Funciones prefijadas `binary-tree-insert`, `graph-add-edge`, etc. / Prefixed functions `binary-tree-insert`, `graph-add-edge`, etc. | Convención idiomática de Common Lisp para paquetes y tipos definidos con `defstruct`. / Idiomatic Common Lisp convention for packages and types defined with `defstruct`. |
| Indicador de ausencia `absent` en enlaces / Absent indicator `absent` on links | `nil` | `nil` es el centinela canónico de puntero nulo y ausencia en Common Lisp. / `nil` is the canonical null pointer and absence sentinel in Common Lisp. |
| Consulta de vecinos `get_neighbors(u)` / Neighbor query `get_neighbors(u)` | `(values lista resultado)` con `values` / `(values list result)` with `values` | Permite distinguir inequívocamente la lista vacía de un vértice aislado `(values nil 0)` del fallo por vértice ausente `(values nil -1)`. / Distinguishes unambiguously an empty neighbor list for an isolated vertex `(values nil 0)` from missing vertex failure `(values nil -1)`. |
| Aislamiento de secuencia devuelta en `get_neighbors` / Neighbor sequence isolation in `get_neighbors` | `collect (neighbor-node-label current)` genera una lista nueva / `collect (neighbor-node-label current)` allocates a fresh list | Las listas en Common Lisp son mutables; generar una lista fresca previene que mutaciones externas alteren la adyacencia interna del grafo. / Lists in Common Lisp are mutable; building a fresh list prevents external mutations from corrupting internal graph adjacency. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `tree-node-get-left` | Enlace izquierdo ausente / Absent left link | `nil` | `(tree-node-get-left node) ; => nil` |
| `tree-node-get-right` | Enlace derecho ausente / Absent right link | `nil` | `(tree-node-get-right node) ; => nil` |
| `tree-node-set-left` | Desenlazar hijo izquierdo / Unlink left child | `nil` como parámetro / `nil` as argument | `(tree-node-set-left node nil)` |
| `tree-node-set-right` | Desenlazar hijo derecho / Unlink right child | `nil` como parámetro / `nil` as argument | `(tree-node-set-right node nil)` |
| `binary-tree-contains` | Valor ausente / Absent value | `-1` | `(binary-tree-contains tree 99) ; => -1` |
| `binary-tree-is-empty` | Árbol con elementos / Tree not empty | `-1` | `(binary-tree-is-empty tree) ; => -1` |
| `graph-add-edge` | Extremo `u` o `v` inexistente / Missing endpoint `u` or `v` | `-1` | `(graph-add-edge graph 10 99) ; => -1` |
| `graph-has-edge` | Arista ausente o extremo inexistente / Absent edge or missing endpoint | `-1` | `(graph-has-edge graph 10 30) ; => -1` |
| `graph-get-neighbors` | Vértice `u` inexistente / Missing vertex `u` | `(values nil -1)` | `(graph-get-neighbors graph 99) ; => nil, -1` |
| `graph-is-empty` | Grafo con vértices / Graph not empty | `-1` | `(graph-is-empty graph) ; => -1` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `TreeNode`: Crear un nodo de árbol / Create a tree node | Sí / Yes | `tests/data-structures-advanced-test.lisp:99` | `tree-node-test` / Caso 1 |
| `TreeNode`: Enlaces iniciales ausentes / Absent initial links | Sí / Yes | `tests/data-structures-advanced-test.lisp:105` | `tree-node-test` / Caso 2 |
| `TreeNode`: Enlazar dos hijos / Link two children | Sí / Yes | `tests/data-structures-advanced-test.lisp:112` | `tree-node-test` / Caso 3 |
| `TreeNode`: Recorrer cada enlace / Traverse each link | Sí / Yes | `tests/data-structures-advanced-test.lisp:121` | `tree-node-test` / Caso 4 |
| `TreeNode`: Desenlazar hijos / Unlink children | Sí / Yes | `tests/data-structures-advanced-test.lisp:136` | `tree-node-test` / Caso 5 |
| `TreeNode`: Adaptación inmutable / Immutable adaptation | No aplica / Not applicable | — | Estructuras mutables vía `defstruct` con mutación controlada por `setf` / Mutable structures via `defstruct` with `setf` |
| `BinaryTree`: Crear vacío / Create empty | Sí / Yes | `tests/data-structures-advanced-test.lisp:157` | `binary-tree-test` / Caso 1 |
| `BinaryTree`: Insertar la raíz / Insert the root | Sí / Yes | `tests/data-structures-advanced-test.lisp:165` | `binary-tree-test` / Caso 2 |
| `BinaryTree`: Insertar menor y mayor / Insert lower and higher | Sí / Yes | `tests/data-structures-advanced-test.lisp:175` | `binary-tree-test` / Caso 3 |
| `BinaryTree`: Ramas de varios niveles / Multilevel branches | Sí / Yes | `tests/data-structures-advanced-test.lisp:184` | `binary-tree-test` / Caso 4 |
| `BinaryTree`: Valor ausente en árbol no vacío / Missing value in nonempty tree | Sí / Yes | `tests/data-structures-advanced-test.lisp:193` | `binary-tree-test` / Caso 5 |
| `BinaryTree`: Duplicado idempotente / Idempotent duplicate | Sí / Yes | `tests/data-structures-advanced-test.lisp:202` | `binary-tree-test` / Caso 6 |
| `BinaryTree`: Inserciones ordenadas / Ordered insertions | Sí / Yes | `tests/data-structures-advanced-test.lisp:211` | `binary-tree-test` / Caso 7 |
| `Graph`: Crear vacío / Create empty | Sí / Yes | `tests/data-structures-advanced-test.lisp:224` | `graph-test` / Caso 1 |
| `Graph`: Vértice aislado / Isolated vertex | Sí / Yes | `tests/data-structures-advanced-test.lisp:234` | `graph-test` / Caso 2 |
| `Graph`: Etiquetas no consecutivas y arista dirigida / Nonconsecutive labels and directed edge | Sí / Yes | `tests/data-structures-advanced-test.lisp:245` | `graph-test` / Caso 3 |
| `Graph`: Vértice duplicado conserva adyacencia / Duplicate vertex preserves adjacency | Sí / Yes | `tests/data-structures-advanced-test.lisp:255` | `graph-test` / Caso 4 |
| `Graph`: Arista duplicada / Duplicate edge | Sí / Yes | `tests/data-structures-advanced-test.lisp:265` | `graph-test` / Caso 5 |
| `Graph`: Extremo inexistente sin mutación / Missing endpoint without mutation | Sí / Yes | `tests/data-structures-advanced-test.lisp:274` | `graph-test` / Caso 6 |
| `Graph`: Vecinos ordenados y contadores / Sorted neighbours and counts | Sí / Yes | `tests/data-structures-advanced-test.lisp:291` | `graph-test` / Caso 7 |
| `Graph`: Consulta de arista ausente / Missing-edge query | Sí / Yes | `tests/data-structures-advanced-test.lisp:307` | `graph-test` / Caso 8 |
| `Graph`: Vecinos de vértice inexistente / Neighbours of missing vertex | Sí / Yes | `tests/data-structures-advanced-test.lisp:316` | `graph-test` / Caso 9 |
| `Graph`: Bucle y duplicado / Self-loop and duplicate | Sí / Yes | `tests/data-structures-advanced-test.lisp:325` | `graph-test` / Caso 10 |
| `Graph`: Aislamiento del resultado de vecinos / Neighbour-result isolation | Sí / Yes | `tests/data-structures-advanced-test.lisp:336` | `graph-test` / Caso 11 |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Comprobación dinámica de tipos en `value` y `label` / Dynamic type checking on `value` and `label` | Las estructuras aceptan cualquier objeto en sus campos / Structures accept any object type in fields | Comportamiento estándar y dinámico de Common Lisp; no afecta a los requisitos de enteros de la especificación / Standard dynamic behavior in Common Lisp; does not affect specification integer requirements |

---

## 📝 Notas de implementación / Implementation Notes

**ES:**
- Las estructuras se implementan con `defstruct`, generando tipos dedicados para `tree-node`, `binary-tree`, `neighbor-node`, `graph-node` y `graph`.
- El valor de los nodos se implementa mediante valor embebido dentro de cada estructura (`value` en `tree-node` y `label` en `graph-node`), sin herencia artificial de tipos.
- Las invariantes de inserción y búsqueda en el ABB se ejecutan iterativamente mediante `loop`, garantizando complejidad $O(h)$ sin riesgo de desbordar la pila de llamadas.
- El registro de vértices del grafo es una lista enlazada canónica manual manipulada a través del campo `next-vertex`, con inserción frontal $O(1)$ y búsqueda lineal $O(V)$.
- La adyacencia de cada vértice se gestiona mediante celdas `neighbor-node`, manteniendo el orden ascendente estricto e ignorando aristas duplicadas en $O(d(u))$.
- `graph-get-neighbors` utiliza valores múltiples (`values`) para retornar `(values list 0)` en caso de éxito y `(values nil -1)` en caso de vértice inexistente, diferenciando inequívocamente el vértice aislado `(values nil 0)` del error.

**EN:**
- Structures are implemented with `defstruct`, generating dedicated types for `tree-node`, `binary-tree`, `neighbor-node`, `graph-node`, and `graph`.
- Node values are implemented via embedded values in each structure (`value` in `tree-node` and `label` in `graph-node`), without artificial type inheritance.
- BST insertion and search invariants execute iteratively using `loop`, ensuring $O(h)$ complexity without risking call stack overflow.
- The graph vertex registry is a manual canonical linked list traversed via `next-vertex`, with $O(1)$ prepend insertion and $O(V)$ linear lookup.
- Vertex adjacency is handled via `neighbor-node` cells, maintaining strict ascending order and ignoring duplicate edges in $O(d(u))$.
- `graph-get-neighbors` uses multiple return values (`values`) to return `(values list 0)` on success and `(values nil -1)` on missing vertex, unambiguously differentiating an isolated vertex `(values nil 0)` from failure.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

## 🔍 Checklist de validación / Validation checklist

- [x] La suite nativa se ejecutó y su salida real está copiada en este README.
- [x] Cada caso de la especificación tiene su fila en _Cobertura de pruebas_ (o `Omitido` con razón).
- [x] Cada desviación del pseudocódigo o de la ubicación esperada está en _Adaptaciones idiomáticas_.
- [x] Cada operación con fallo posible está en _Indicadores de fallo_.
- [x] No hay rutas absolutas del autor, credenciales ni salidas inventadas.
- [x] Los enlaces relativos resuelven dentro del repositorio y el documento es bilingüe.
- [x] Ninguna sección repite lo que ya dice la especificación.

---

## 📚 Referencias / References

| Tipo / Kind | Referencia / Reference |
|---|---|
| Especificación / Specification | [`07_Data_Structures_Advanced.md`](https://yorche3.github.io/programming_languages/core/algorithms/07_Data_Structures_Advanced/) |
| Primera base del lenguaje / First language reference | `data_structures_basics` — [`common-lisp/core/algorithms/data_structures_basics/`](../data_structures_basics/) |
| Segunda base del lenguaje / Second language reference | `numbers` — [`common-lisp/core/foundations/numbers/`](../../foundations/numbers/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Common Lisp Hyperspec (ANSI CL)](http://www.lispworks.com/documentation/HyperSpec/) |

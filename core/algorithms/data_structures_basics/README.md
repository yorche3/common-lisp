# Data Structures Basics — Common Lisp

Implementación de la especificación [06_Data_Structures_Basics](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

Implementa las estructuras de datos fundamentales — **Node**, **LinkedList**, **Stack** y **Queue** — construidas manualmente sobre una celda enlazada compartida (`node`), con inicialización explícita, mutación controlada de punteros y representación nativa de ausencia mediante `nil`.

---

## 📂 Archivos y estructura / Files & Structure

Describe la estructura del proyecto y el propósito de cada archivo.

| Archivo / Directory | Propósito / Purpose |
|---|---|
| `data-structures-basics.asd` | Sistemas ASDF — define `data-structures-basics` y `data-structures-basics/tests` / ASDF systems — defines `data-structures-basics` and `data-structures-basics/tests` |
| `src/data-structures-basics.lisp` | Código fuente principal (`node`, `linked-list`, `stack`, `queue`) / Main source code (`node`, `linked-list`, `stack`, `queue`) |
| `tests/data-structures-basics-test.lisp` | Pruebas unitarias con FiveAM (15 aserciones) / Unit tests with FiveAM (15 assertions) |
| `run-tests.lisp` | Script cargador y ejecutor de pruebas / Test loader and runner script |
| `.gitignore` | Archivos compilados excluidos (`*.fasl`, etc.) / Ignored compiled files (`*.fasl`, etc.) |

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se implementó manualmente utilizando estructuras nativas (`defstruct`) de Common Lisp para representar celdas y tipos de datos abstractos, sin envolver listas o secuencias de la biblioteca estándar. La gestión de dependencias y compilación se realiza con **ASDF**, y la suite de pruebas se orquesta con **FiveAM**.

**EN:** The project was created manually using Common Lisp native structures (`defstruct`) to represent cells and abstract data types, without wrapping standard library lists or sequences. Dependency management and compilation are handled by **ASDF**, and the test suite is driven by **FiveAM**.

---

## 📄 Configuración clave / Key Configuration

### `data-structures-basics.asd` — Manifiesto ASDF / ASDF Manifest

**ES:** Declara el sistema principal `data-structures-basics` (sin dependencias externas) y el sistema de pruebas `data-structures-basics/tests` (con dependencia de `fiveam`).

**EN:** Declares the main system `data-structures-basics` (no external dependencies) and the test system `data-structures-basics/tests` (depending on `fiveam`).

```common-lisp
(defsystem "data-structures-basics"
  :version "0.0.1"
  :author ""
  :license ""
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "data-structures-basics"))))
  :description ""
  :in-order-to ((test-op (test-op "data-structures-basics/tests"))))

(defsystem "data-structures-basics/tests"
  :author ""
  :license ""
  :depends-on ("data-structures-basics"
               "fiveam")
  :components ((:module "tests"
                :components
                ((:file "data-structures-basics-test"))))
  :description "Test system for data-structures-basics"
  :perform (test-op (op c) (uiop:symbol-call :data-structures-basics/tests :run-tests)))
```

---

## 🚀 Compilación y ejecución / Build & Run

```bash
# Compilación estática / Static compilation
ros run --eval '(asdf:load-asd (truename "data-structures-basics.asd"))' \
        --eval '(asdf:compile-system :data-structures-basics :force t)' \
        --eval '(asdf:compile-system :data-structures-basics/tests :force t)' \
        --eval '(uiop:quit)'

# Ejecución de pruebas / Run tests
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

**Salida real / Actual output:**

```text
Running test suite DATA-STRUCTURES-BASICS-SUITE
 Running test NODE-TEST ..
 Running test LINKED-LIST-TEST .....
 Running test STACK-TEST ....
 Running test QUEUE-TEST ....
 Did 15 checks.
    Pass: 15 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Operación / Operation | Entrada → salida / Input → output | Complejidad / Complexity | Notas / Notes |
|---|---|---|---|
| `make-node` / `node-init` | `value, [next] → node` | $O(1)$ | Constructor `defstruct` / `defstruct` constructor |
| `node-value` | `node → value` | $O(1)$ | Acceso al valor / Value access |
| `node-next` | `node → node?` | $O(1)$ | Acceso al enlace o `nil` / Link access or `nil` |
| `linked-list-init` | `linked-list → linked-list` | $O(1)$ | Inicializa cabeza/cola a `nil` y tamaño a `0` / Sets head/tail to `nil` and size to `0` |
| `linked-list-is-empty` | `linked-list → boolean` | $O(1)$ | `zerop` sobre el contador interno / `zerop` on internal counter |
| `linked-list-size` | `linked-list → integer` | $O(1)$ | Devuelve el total de elementos / Returns total elements |
| `linked-list-get-head` | `linked-list → value?` | $O(1)$ | Valor de cabeza o `nil` si vacía / Head value or `nil` when empty |
| `linked-list-insert-head` | `linked-list, value → node` | $O(1)$ | Inserta al inicio y actualiza cabeza/cola / Inserts at head, updates head/tail |
| `linked-list-insert-tail` | `linked-list, value → node` | $O(1)$ | Inserta al final y actualiza cola / Inserts at tail, updates tail |
| `linked-list-delete` | `linked-list, value → boolean?` | $O(n)$ | Elimina primera aparición; devuelve `t` o `nil` / Deletes first occurrence; returns `t` or `nil` |
| `stack-init` | `stack → stack` | $O(1)$ | Inicializa tope a `nil` y tamaño a `0` / Sets top to `nil` and size to `0` |
| `stack-is-empty` | `stack → boolean` | $O(1)$ | `zerop` sobre contador / `zerop` on counter |
| `stack-size` | `stack → integer` | $O(1)$ | Número de elementos / Number of elements |
| `stack-push` | `stack, value → node` | $O(1)$ | Coloca en el tope / Pushes onto top |
| `stack-peek` | `stack → value?` | $O(1)$ | Consulta tope sin extraer o `nil` / Observes top without popping or `nil` |
| `stack-pop` | `stack → value?` | $O(1)$ | Extrae tope o devuelve `nil` si vacía / Pops top or returns `nil` when empty |
| `queue-init` | `queue → queue` | $O(1)$ | Inicializa frente/final a `nil` y tamaño a `0` / Sets front/rear to `nil` and size to `0` |
| `queue-is-empty` | `queue → boolean` | $O(1)$ | `zerop` sobre contador / `zerop` on counter |
| `queue-size` | `queue → integer` | $O(1)$ | Número de elementos / Number of elements |
| `queue-enqueue` | `queue, value → node` | $O(1)$ | Inserta en final y actualiza frente/final / Inserts at rear, updates front/rear |
| `queue-peek` | `queue → value?` | $O(1)$ | Consulta frente sin extraer o `nil` / Observes front without popping or `nil` |
| `queue-dequeue` | `queue → value?` | $O(1)$ | Extrae frente o devuelve `nil` si vacía / Dequeues front or returns `nil` when empty |

---

## 🧩 Decisiones de diseño / Design decisions

| Decisión / Decision | Alternativa considerada / Alternative | Razón / Reason |
|---|---|---|
| Estructuras mutables vía `defstruct` / Mutable structures via `defstruct` | Listas nativas de Common Lisp (`cons`, `car`, `cdr`) / Native CL lists (`cons`, `car`, `cdr`) | La especificación exige modelar explícitamente el tipo `Node` y las estructuras enlazadas independientes sin depender de las listas integradas del lenguaje. / The specification requires explicitly modeling `Node` and independent linked ADTs without relying on built-in language lists. |
| Reutilización del mismo tipo `node` / Reusing the single `node` type | Definir `stack-node` y `queue-node` separados / Defining separate `stack-node` and `queue-node` | El contrato fija que `LinkedList`, `Stack` y `Queue` deben compartir la misma estructura de celda enlazada `node`. / The contract mandates that `LinkedList`, `Stack` and `Queue` share the exact same `node` cell structure. |
| Mutación con `setf` en campos de struct / In-place mutation with `setf` on struct fields | Reconstrucción funcional pura / Pure functional reconstruction | Permite garantizar complejidad $O(1)$ estricta en inserciones en cola y operaciones de pila/cola sin recrear la cadena de enlaces. / Guarantees strict $O(1)$ complexity for tail insertions and stack/queue operations without rebuilding the link chain. |

---

## 🔀 Adaptaciones idiomáticas / Idiomatic adaptations

| Especificación / Specification | Adaptación / Adaptation | Justificación / Justification |
|---|---|---|
| Ubicación de pruebas `test/` / Test directory `test/` | Carpeta `tests/` / Directory `tests/` | Convención estándar en proyectos ASDF y suites FiveAM en Common Lisp. / Standard convention for ASDF projects and FiveAM test suites in Common Lisp. |
| Métodos orientados a objetos `Node.init(value)`, `list.insert_head(value)` / OOP methods `Node.init(value)`, `list.insert_head(value)` | Funciones prefijadas `linked-list-insert-head`, `stack-push`, etc. / Prefixed functions `linked-list-insert-head`, `stack-push`, etc. | Convención idiomática de Common Lisp para paquetes y tipos definidos con `defstruct`. / Idiomatic Common Lisp convention for packages and types defined with `defstruct`. |
| `absent` y valores de fallo centinela / `absent` and sentinel failure values | `nil` (indicador natural) / `nil` (natural indicator) | En Common Lisp, `nil` representa canónicamente la ausencia de enlace, la falsedad lógica y la estructura vacía. / In Common Lisp, `nil` canonically represents link absence, logical falsity, and empty structures. |

---

## 🚨 Indicadores de fallo / Failure indicators

| Operación / Operation | Situación de fallo / Failure situation | Indicador / Indicator | Ejemplo / Example |
|---|---|---|---|
| `linked-list-get-head` | Lista vacía / Empty list | `nil` | `(linked-list-get-head list) ; => nil` |
| `linked-list-delete` | Valor no encontrado / Value not found | `nil` | `(linked-list-delete list 99) ; => nil` |
| `stack-peek` | Pila vacía / Empty stack | `nil` | `(stack-peek stack) ; => nil` |
| `stack-pop` | Pila vacía / Empty stack | `nil` | `(stack-pop stack) ; => nil` |
| `queue-peek` | Cola vacía / Empty queue | `nil` | `(queue-peek queue) ; => nil` |
| `queue-dequeue` | Cola vacía / Empty queue | `nil` | `(queue-dequeue queue) ; => nil` |
| `node-next` | Enlace ausente / Absent link | `nil` | `(node-next node) ; => nil` |

---

## ✅ Cobertura de pruebas / Test coverage

| Caso de la especificación / Specification case | Cubierto / Covered | Prueba / Test | Notas / Notes |
|---|---|:--:|---|
| `Node`: Inicializar y observar valor/enlace / Initialize and observe value/link | Sí / Yes | `tests/data-structures-basics-test.lisp:55` (`node-cases`) | Caso 1 / Case 1 |
| `Node`: Inicializar otro nodo, enlazar y recorrer / Initialize another node, link and traverse | Sí / Yes | `tests/data-structures-basics-test.lisp:67` (`node-cases`) | Caso 2 / Case 2 |
| `LinkedList`: Estado vacío / Empty state | Sí / Yes | `tests/data-structures-basics-test.lisp:78` (`linked-list-cases`) | Paso 1 / Step 1 |
| `LinkedList`: Insertar por ambos extremos / Insert at both ends | Sí / Yes | `tests/data-structures-basics-test.lisp:86` (`linked-list-cases`) | Paso 2 / Step 2 |
| `LinkedList`: Eliminar primera aparición / Delete first occurrence | Sí / Yes | `tests/data-structures-basics-test.lisp:95` (`linked-list-cases`) | Paso 3 / Step 3 |
| `LinkedList`: Valor ausente / Absent value | Sí / Yes | `tests/data-structures-basics-test.lisp:102` (`linked-list-cases`) | Paso 4 / Step 4 |
| `LinkedList`: Vaciar / Empty the list | Sí / Yes | `tests/data-structures-basics-test.lisp:109` (`linked-list-cases`) | Paso 5 / Step 5 |
| `Stack`: Estado vacío y extracción fallida / Empty state and failed removal | Sí / Yes | `tests/data-structures-basics-test.lisp:123` (`stack-cases`) | Paso 1 / Step 1 |
| `Stack`: LIFO y `peek` no mutante / LIFO and non-mutating `peek` | Sí / Yes | `tests/data-structures-basics-test.lisp:132` (`stack-cases`) | Paso 2 / Step 2 |
| `Stack`: Extracción y reutilización / Removal and reuse | Sí / Yes | `tests/data-structures-basics-test.lisp:140` (`stack-cases`) | Paso 3 / Step 3 |
| `Stack`: Vacío tras extracción / Empty after removal | Sí / Yes | `tests/data-structures-basics-test.lisp:152` (`stack-cases`) | Paso 4 / Step 4 |
| `Queue`: Estado vacío y extracción fallida / Empty state and failed removal | Sí / Yes | `tests/data-structures-basics-test.lisp:162` (`queue-cases`) | Paso 1 / Step 1 |
| `Queue`: FIFO y `peek` no mutante / FIFO and non-mutating `peek` | Sí / Yes | `tests/data-structures-basics-test.lisp:171` (`queue-cases`) | Paso 2 / Step 2 |
| `Queue`: Extracción y reutilización / Removal and reuse | Sí / Yes | `tests/data-structures-basics-test.lisp:179` (`queue-cases`) | Paso 3 / Step 3 |
| `Queue`: Vacío tras extracción / Empty after removal | Sí / Yes | `tests/data-structures-basics-test.lisp:191` (`queue-cases`) | Paso 4 / Step 4 |

---

## ⚠️ Limitaciones conocidas / Known limitations

| Limitación / Limitation | Impacto / Impact | Alternativa o plan / Workaround or plan |
|---|---|---|
| Ausencia de genéricos y comprobación estática estricta de tipos / Lack of generics and strict static type checking | Los nodos y estructuras aceptan cualquier tipo de objeto en `value` (`T`) / Nodes and structures accept any object type in `value` (`T`) | Comportamiento estándar y dinámico de Common Lisp; no afecta a los requisitos de la especificación / Standard dynamic behavior in Common Lisp; does not affect specification requirements |

---

## 📝 Notas de implementación / Implementation Notes

**ES:**
- Las estructuras se implementan con `defstruct`, generando tipos dedicados para `node`, `linked-list`, `stack` y `queue`.
- `Stack` y `Queue` reutilizan el tipo de nodo común `node` y gestionan sus propios punteros (`top` para la pila, `front` y `rear` para la cola) sin depender de `linked-list`.
- Todas las operaciones de fallo devuelven `nil` sin lanzar señales ni condiciones no controladas.
- La suite de pruebas usa el operador `is (equal ...)` de FiveAM sobre listas de resultados esperados en pasos sucesivos sobre la misma instancia lógica.

**EN:**
- Structures are implemented with `defstruct`, generating dedicated types for `node`, `linked-list`, `stack`, and `queue`.
- `Stack` and `Queue` reuse the common `node` cell type and manage their own pointers (`top` for stack, `front` and `rear` for queue) without depending on `linked-list`.
- All failure operations return `nil` without signaling unhandled conditions.
- The test suite uses FiveAM's `is (equal ...)` operator across lists of expected results in successive steps over the same logical instance.

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
| Especificación / Specification | [`06_Data_Structures_Basics.md`](https://yorche3.github.io/programming_languages/core/algorithms/06_Data_Structures_Basics/) |
| Módulo homologado del lenguaje / Homologated module | [`common-lisp/core/algorithms/naive_sort/`](../naive_sort/) |
| Guía de inicialización / Initialisation guide | [`core/00_Project_Initialization_Guide.md`](../../../docs/core/00_Project_Initialization_Guide.md) |
| Adaptaciones idiomáticas / Idiomatic adaptations | [`AGENT_Template.md`](../../../docs/AGENT_Template.md) |
| Validación de la documentación / Documentation validation | [`WORKFLOW.md`](../../../docs/WORKFLOW.md) |
| Documentación oficial del lenguaje / Language official docs | [Common Lisp Hyperspec (ANSI CL)](http://www.lispworks.com/documentation/HyperSpec/) |

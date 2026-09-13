# Naive Sort — Common Lisp

Implementación de la especificación [05_Naive_Sort](https://yorche3.github.io/programming_languages/core/algorithms/05_Naive_Sort/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

Implementa los tres algoritmos elementales de ordenamiento ($O(n^2)$) — **Selection Sort**, **Bubble Sort** e **Insertion Sort** — trabajando sobre vectores, sin usar la función nativa `sort` y devolviendo una copia ordenada de la entrada.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito / Purpose |
|----------------------|---------------------|
| [`naive-sort.asd`](naive-sort.asd) | Sistemas ASDF — define `naive-sort` (código) y `naive-sort/tests` (pruebas). / ASDF systems — defines `naive-sort` (code) and `naive-sort/tests` (tests). |
| [`src/naive-sort.lisp`](src/naive-sort.lisp) | Implementación de las 3 funciones de ordenamiento. / Implementation of the 3 sorting functions. |
| [`test/naive-sort-test.lisp`](test/naive-sort-test.lisp) | 24 aserciones (8 casos × 3 algoritmos). / 24 assertions (8 cases × 3 algorithms). |
| [`run-tests.lisp`](run-tests.lisp) | Script que carga el sistema y ejecuta la suite. / Script that loads the system and runs the suite. |
| [`.gitignore`](.gitignore) | Archivos compilados (`*.fasl`, `*.x86f`, etc.). / Compiled files (`*.fasl`, `*.x86f`, etc.). |

**Estructura de directorios esperada / Expected directory structure:**

```text
naive_sort/
├── naive-sort.asd              # Sistemas ASDF / ASDF systems
├── run-tests.lisp              # Script de ejecución / Runner script
├── src/
│   └── naive-sort.lisp         # 3 algoritmos / 3 algorithms
├── test/
│   └── naive-sort-test.lisp    # 24 aserciones / 24 assertions
├── .gitignore
└── README.md                   # Este archivo / This file
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** El proyecto se creó manualmente usando **ASDF** como sistema de construcción y **FiveAM** como framework de pruebas. La implementación no usa la función `sort` de la biblioteca estándar (prohibida por la especificación) y no añade dependencias externas: el sistema `naive-sort` no depende de nada y `naive-sort/tests` depende solo de `fiveam`.

**EN:** The project was created manually using **ASDF** as the build system and **FiveAM** as the testing framework. The implementation does not use the standard library's `sort` function (forbidden by the specification) and adds no external dependencies: the `naive-sort` system depends on nothing and `naive-sort/tests` depends only on `fiveam`.

---

## 📄 Configuración clave / Key Configuration

### `naive-sort.asd` — Sistemas ASDF / ASDF systems

**ES:** Define dos sistemas. `naive-sort` compila `src/naive-sort.lisp`; `naive-sort/tests` compila `test/naive-sort-test.lisp` y declara `test-op` para que `(asdf:test-system :naive-sort)` ejecute la suite.

**EN:** Defines two systems. `naive-sort` compiles `src/naive-sort.lisp`; `naive-sort/tests` compiles `test/naive-sort-test.lisp` and declares `test-op` so that `(asdf:test-system :naive-sort)` runs the suite.

```common-lisp
(defsystem "naive-sort"
  :depends-on ()
  :components ((:module "src"
                :components ((:file "naive-sort"))))
  :in-order-to ((test-op (test-op "naive-sort/tests"))))

(defsystem "naive-sort/tests"
  :depends-on ("naive-sort" "fiveam")
  :components ((:module "test"
                :components ((:file "naive-sort-test"))))
  :perform (test-op (op c) (uiop:symbol-call :naive-sort/tests :run-tests)))
```

### `src/naive-sort.lisp` — Implementación / Implementation

**ES:** El paquete `naive-sort` exporta las tres funciones públicas. Cada una recibe un vector y devuelve un vector nuevo ordenado ascendentemente, o `nil` si la entrada es `nil`.

**EN:** The `naive-sort` package exports the three public functions. Each one takes a vector and returns a new vector sorted ascending, or `nil` when the input is `nil`.

```common-lisp
(defpackage #:naive-sort
  (:use #:cl)
  (:export #:selection-sort
           #:bubble-sort
           #:insertion-sort))
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Roswell instalado / Requirement: Roswell installed

```bash
# Verificar instalación / Check installation
ros --version
```

### Ejecutar pruebas / Run tests

```bash
cd core/algorithms/naive_sort
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

También puede ejecutarse vía ASDF / It can also be run via ASDF:

```bash
(cd core/algorithms/naive_sort && ros run \
  --eval '(asdf:load-asd (merge-pathnames "naive-sort.asd" #p"./"))' \
  --eval '(asdf:test-system :naive-sort)' \
  --eval '(uiop:quit)')
```

**Salida real / Actual output:**

```text
Running test suite NAIVE-SORT-SUITE
 Running test TEST-SELECTION-SORT ........
 Running test TEST-BUBBLE-SORT ........
 Running test TEST-INSERTION-SORT ........
 Did 24 checks.
    Pass: 24 (100%)
    Skip: 0 ( 0%)
    Fail: 0 ( 0%)
```

---

## 🧠 Algoritmos y operaciones / Algorithms & Operations

| Función / Function | Enfoque / Approach | Descripción / Description | Complejidad / Complexity |
|--------------------|:------------------:|---------------------------|--------------------------|
| `selection-sort` | `iter` | Busca el mínimo del tramo no ordenado y lo intercambia al inicio. / Finds the minimum of the unsorted part and swaps it to the front. | $O(n^2)$ siempre / always |
| `bubble-sort` | `iter` | Compara e intercambia adyacentes con salida temprana si no hubo intercambios. / Compares and swaps adjacent items with early exit when no swap occurs. | $O(n^2)$ peor/promedio, $O(n)$ mejor / worst/average, $O(n)$ best |
| `insertion-sort` | `iter` | Inserta cada elemento en su posición dentro del sub-vector ya ordenado. / Inserts each element into its position within the already sorted sub-vector. | $O(n^2)$ peor/promedio, $O(n)$ mejor / worst/average, $O(n)$ best |

### Casos de prueba / Test cases

Cada algoritmo valida los 7 casos de la especificación más el caso nulo controlado (la especificación lo exige cuando el lenguaje puede representar `nil`); 24 aserciones en total / Each algorithm validates the 7 specification cases plus the controlled nil case (the specification requires it when the language can represent `nil`); 24 assertions in total:

| # | Caso / Case | Entrada / Input | Salida esperada / Expected output |
|---|-------------|-----------------|-----------------------------------|
| 1 | Array desordenado / Unsorted array | `#(5 2 9 1 5 6)` | `#(1 2 5 5 6 9)` |
| 2 | Ya ordenado / Already sorted | `#(1 2 3 4 5)` | `#(1 2 3 4 5)` |
| 3 | Orden inverso / Reverse order | `#(5 4 3 2 1)` | `#(1 2 3 4 5)` |
| 4 | Idénticos / Identical elements | `#(7 7 7 7)` | `#(7 7 7 7)` |
| 5 | Negativos / Negative numbers | `#(3 -1 4 -5 0)` | `#(-5 -1 0 3 4)` |
| 6 | Un elemento / Single element | `#(42)` | `#(42)` |
| 7 | Vacío / Empty | `#()` | `#()` |
| 8 | Nulo / Nil (fallo / failure) | `nil` | `nil` |

---

## 📝 Notas de implementación / Implementation Notes

### Sobre la implementación / On the implementation

- **ES:** Common Lisp es un lenguaje con fuerte tradición funcional; la mutación se evita cuando es razonable. Por eso las tres funciones **devuelven una copia ordenada** en lugar de ordenar in-place (la especificación permite ambas variantes).
- **EN:** Common Lisp has a strong functional tradition; mutation is avoided when reasonable. That is why the three functions **return a sorted copy** instead of sorting in place (the specification allows both variants).
- **ES:** El indicador de fallo es `nil`: al recibir `nil` las funciones devuelven `nil` sin señalar condiciones ni lanzar excepciones, como exige el contrato.
- **EN:** The failure indicator is `nil`: when receiving `nil` the functions return `nil` without signaling conditions or throwing exceptions, as the contract requires.
- **ES:** El intercambio se hace con `rotatef` y la iteración con `loop`. No se usa `sort` ni `stable-sort` de la biblioteca estándar.
- **EN:** Swapping uses `rotatef` and iteration uses `loop`. Neither `sort` nor `stable-sort` from the standard library is used.
- **ES:** El sistema base no tiene dependencias externas; `fiveam` se usa únicamente en el sistema de pruebas.
- **EN:** The base system has no external dependencies; `fiveam` is used only by the test system.

### Sobre las pruebas / On the tests

- **ES:** Las comparaciones usan `equalp`, no `equal`. En Common Lisp, `equal` **no** compara vectores generales elemento a elemento (solo conses, strings y bit-vectors), por lo que `equal` daría `nil` aunque los vectores fueran idénticos.
- **EN:** Assertions use `equalp`, not `equal`. In Common Lisp, `equal` does **not** descend into general vectors (only conses, strings and bit-vectors), so `equal` would return `nil` even for identical vectors.
- **ES:** Los fixtures son `defparameter` (no `defconstant`), porque `defconstant` exige valores `eql` entre recargas y los vectores literales no lo son. Cada caso copia su entrada con `copy-seq` antes de llamar a la función bajo prueba.
- **EN:** Fixtures are `defparameter` (not `defconstant`), because `defconstant` requires `eql` values across reloads and literal vectors are not. Each case copies its input with `copy-seq` before calling the function under test.
- **ES:** Un único helper (`check-sorting`) recibe la función a probar y su nombre, y ejecuta las 8 aserciones con mensajes descriptivos; hay una prueba (`test-selection-sort`, `test-bubble-sort`, `test-insertion-sort`) por algoritmo.
- **EN:** A single helper (`check-sorting`) receives the function under test and its name, and runs the 8 assertions with descriptive messages; there is one test (`test-selection-sort`, `test-bubble-sort`, `test-insertion-sort`) per algorithm.
- **ES:** El caso nulo es controlado: se pasa `nil` y se comprueba que la función devuelve `nil` como indicador de fallo, sin señalar condiciones. No es una prueba para provocar una excepción.
- **EN:** The nil case is controlled: `nil` is passed and the function is asserted to return `nil` as the failure indicator, without signaling conditions. It is not an exception-triggering test.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

This project is also implemented in other languages. Explore the [main repository](https://github.com/yorche3/programming_languages) to see the other versions.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

# Numbers — Common Lisp

Implementación de la especificación [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

Implementa 5 algoritmos fundamentales (suma de los primeros N naturales, factorial, Fibonacci, MCD, MCM) utilizando tres enfoques: **recursivo directo**, **recursivo con acumulador** e **iterativo**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`numbers.asd`](numbers.asd) | Sistema ASDF — define el sistema principal y el sistema de tests. |
| [`src/numbers.lisp`](src/numbers.lisp) | Implementación de las 15 funciones (3 enfoques × 5 algoritmos). |
| [`tests/numbers_recursive_tests.lisp`](tests/numbers_recursive_tests.lisp) | 11 tests para el enfoque recursivo directo. |
| [`tests/numbers_accumulator_tests.lisp`](tests/numbers_accumulator_tests.lisp) | 11 tests para el enfoque con acumulador. |
| [`tests/numbers_iterative_tests.lisp`](tests/numbers_iterative_tests.lisp) | 11 tests para el enfoque iterativo (incluye `run-tests` orquestador). |
| [`run-tests.lisp`](run-tests.lisp) | Script que carga el sistema y ejecuta todas las suites. |
| [`.gitignore`](.gitignore) | Archivos compilados (`*.fasl`, `*.x86f`, etc.). |

**Estructura de directorios esperada:**

```text
numbers/
├── numbers.asd                      # Sistema ASDF
├── run-tests.lisp                   # Script de ejecución de pruebas
├── src/
│   └── numbers.lisp                 # 15 funciones (3 enfoques × 5 algoritmos)
├── tests/
│   ├── numbers_recursive_tests.lisp     # 11 tests recursivos
│   ├── numbers_accumulator_tests.lisp   # 11 tests con acumulador
│   └── numbers_iterative_tests.lisp     # 11 tests iterativos + orquestador
├── .gitignore
└── README.md                       # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **ASDF** como sistema de construcción y **FiveAM** como framework de pruebas.

Cada algoritmo se implementa de tres formas distintas:

1. **Recursivo Directo (`...-rec`)**: Basado directamente en la definición matemática, con llamadas recursivas.
2. **Recursivo con Acumulador (`...-acc`)**: Expone una función limpia que delega en un helper interno con tail recursion vía `recur` (ver notas sobre TCO).
3. **Iterativo (`...-iter`)**: Utiliza `loop` para evitar el crecimiento de la pila.

**EN:** This project uses **ASDF** as the build system and **FiveAM** as the testing framework.

Each algorithm is implemented in three different ways:

1. **Direct Recursive (`...-rec`)**: Based directly on the mathematical definition, with recursive calls.
2. **Accumulator Recursive (`...-acc`)**: Exposes a clean function that delegates to an internal helper with tail recursion via `recur` (see notes on TCO).
3. **Iterative (`...-iter`)**: Uses `loop` to avoid stack growth.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `numbers.asd` — Sistema ASDF

**ES:** Define dos sistemas: `numbers` (compila `src/numbers.lisp`) y `numbers/tests` (compila los 3 archivos de tests, depende de `fiveam` y `numbers`).

**EN:** Defines two systems: `numbers` (compiles `src/numbers.lisp`) and `numbers/tests` (compiles the 3 test files, depends on `fiveam` and `numbers`).

```common-lisp
(defsystem "numbers"
  :depends-on ()
  :components ((:module "src"
                :components ((:file "numbers"))))
  :in-order-to ((test-op (test-op "numbers/tests"))))

(defsystem "numbers/tests"
  :depends-on ("numbers" "fiveam")
  :components ((:module "tests"
                :components
                ((:file "numbers_recursive_tests")
                 (:file "numbers_accumulator_tests")
                 (:file "numbers_iterative_tests"))))
  :perform (test-op (op c)
    (uiop:symbol-call :numbers/tests :run-tests)))
```

### `src/numbers.lisp` — Implementación

**ES:** Las 15 funciones públicas. Cada algoritmo tiene 3 implementaciones con idéntica semántica pero distinto enfoque.

**EN:** The 15 public functions. Each algorithm has 3 implementations with identical semantics but different approaches.

```common-lisp
;; Enfoque recursivo directo
(defun fibonacci-rec (n)
  (if (or (= n 0) (= n 1)) n
      (+ (fibonacci-rec (- n 1)) (fibonacci-rec (- n 2)))))

;; Helper con acumulador (tail recursion)
(defun fibonacci-help (n acc2 acc1)
  (if (<= n 0) acc2
      (fibonacci-help (- n 1) acc1 (+ acc2 acc1))))

(defun fibonacci-acc (n) (fibonacci-help n 0 1))

;; Enfoque iterativo
(defun fibonacci-iter (n)
  (let ((acc2 0) (acc1 1) (temp 0))
    (loop for i from 1 to n do
      (setf temp (+ acc2 acc1))
      (setf acc2 acc1)
      (setf acc1 temp))
    acc2))
```

### `tests/numbers_recursive_tests.lisp` — Pruebas recursivas

**ES:** 11 aserciones distribuidas en 5 tests, cada uno usando `is` de FiveAM. Las funciones se acceden con `numbers:` (símbolo exportado).

**EN:** 11 assertions distributed across 5 tests, each using FiveAM's `is`. Functions are accessed with `numbers:` (exported symbol).

```common-lisp
(test fibonacci-rec-test
  (is (= (numbers:fibonacci-rec 0) 0) "Fibonacci of 0 should be 0")
  (is (= (numbers:fibonacci-rec 1) 1) "Fibonacci of 1 should be 1")
  (is (= (numbers:fibonacci-rec 6) 8) "Fibonacci of 6 should be 8"))
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Roswell instalado

```bash
# Verificar instalación
ros --version
```

### Ejecutar pruebas

```bash
cd core/foundations/numbers
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

**Salida esperada / Expected output:**

```text
Running test suite NUMBERS-RECURSIVE-SUITE
Running test SUM-FIRST-N-REC-TEST ..
Running test FACTORIAL-REC-TEST ..
Running test FIBONACCI-REC-TEST ...
Running test LARGEST-COMMON-DIVISOR-REC-TEST ..
Running test LEAST-COMMON-MULTIPLE-REC-TEST ..
Did 11 checks.
Pass: 11 (100%)
Skip: 0 ( 0%)
Fail: 0 ( 0%)

Running test suite NUMBERS-ACCUMULATOR-SUITE
...
Did 11 checks.
Pass: 11 (100%)
Skip: 0 ( 0%)
Fail: 0 ( 0%)

Running test suite NUMBERS-ITERATIVE-SUITE
...
Did 11 checks.
Pass: 11 (100%)
Skip: 0 ( 0%)
Fail: 0 ( 0%)
```

---

## 🧠 Algoritmos / operaciones

### 3 enfoques × 5 algoritmos = 15 funciones / 33 tests

| Algoritmo | Casos de prueba | `rec` | `acc` | `iter` |
|-----------|----------------|:-----:|:-----:|:------:|
| `sum-first-n` | `(0) = 0`, `(3) = 6` | ✅ | ✅ | ✅ |
| `factorial` | `(0) = 1`, `(4) = 24` | ✅ | ✅ | ✅ |
| `fibonacci` | `(0) = 0`, `(1) = 1`, `(6) = 8` | ✅ | ✅ | ✅ |
| `largest-common-divisor` | `(12, 8) = 4`, `(7, 5) = 1` | ✅ | ✅ | ✅ |
| `least-common-multiple` | `(8, 6) = 24`, `(6, 4) = 12` | ✅ | ✅ | ✅ |

---

## 📝 Notas de implementación / Implementation Notes

### 🔁 Sobre recursión con acumulador y Tail Call Optimization (TCO) / On recursion with accumulator and Tail Call Optimization (TCO)

**ES:**

*Tail recursion* ocurre cuando la llamada recursiva es la última acción que ejecuta una función; después de la llamada no hay más instrucciones, la función devuelve el resultado de la llamada recursiva. La recursión con acumulador consigue esto pasando el estado previo como parámetro a cada llamada, sin dejar trabajo pendiente en la pila.

**Common Lisp no garantiza TCO** en toda implementación. SBCL (la implementación usada aquí) **sí optimiza tail calls** por defecto, convirtiendo las llamadas recursivas finales en saltos que no consumen pila. Esto significa que los helpers con acumulador (`...-help`) se ejecutan sin crecimiento de pila en SBCL. Sin embargo, esto no está garantizado en el estándar ANSI Common Lisp y depende de la implementación.

Las funciones con acumulador tienen pruebas unitarias específicas porque en Common Lisp la tail recursion es idiomática y verificable.

**EN:**

*Tail recursion* occurs when the recursive call is the last action that runs a function; after the call there are no more instructions, the function returns the result of the recursive call. Recursion with accumulator achieves this by passing the previous state as a parameter to each call, without leaving any pending work on the stack.

**Common Lisp does not guarantee TCO** across all implementations. SBCL (the implementation used here) **does optimize tail calls** by default, converting final recursive calls into jumps that don't consume stack. This means accumulator helpers (`...-help`) run without stack growth in SBCL. However, this is not guaranteed by the ANSI Common Lisp standard and depends on the implementation.

The accumulator functions have their own specific unit tests because in Common Lisp, tail recursion is idiomatic and verifiable.

### Sobre la implementación / On the implementation

- **ES:** `multiplication` y `division` en el módulo `calculator` se implementaron con solo `+` y `-`. En `numbers` se usan `*` y `/` directamente.
- **EN:** `multiplication` and `division` in the `calculator` module were implemented with only `+` and `-`. In `numbers`, `*` and `/` are used directly.
- **ES:** El paquete `numbers` exporta las 15 funciones. Los tests las acceden con `numbers:`.
- **EN:** The `numbers` package exports all 15 functions. Tests access them with `numbers:`.
- **ES:** `(uiop:quit)` termina el proceso Lisp con el código de retorno apropiado.
- **EN:** `(uiop:quit)` terminates the Lisp process with the appropriate exit code.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

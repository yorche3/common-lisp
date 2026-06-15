# Calculator — Common Lisp

Implementación de la especificación [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

Implementa 5 operaciones aritméticas (`addition`, `subtraction`, `multiplication`, `division`, `modulus`) usando únicamente `+` y `-` como operaciones primitivas.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo / Directorio | Propósito |
|----------------------|-----------|
| [`calculator.asd`](calculator.asd) | Sistema ASDF — define el sistema principal y el sistema de tests. |
| [`src/calculator.lisp`](src/calculator.lisp) | Implementación de las 5 operaciones aritméticas. |
| [`tests/calculator_tests.lisp`](tests/calculator_tests.lisp) | Suite de tests con FiveAM (5 tests). |
| [`run-tests.lisp`](run-tests.lisp) | Script que carga el sistema y ejecuta las pruebas. |
| [`.gitignore`](.gitignore) | Archivos compilados (`*.fasl`, `*.x86f`, etc.). |

**Estructura de directorios esperada:**

```text
calculator/
├── calculator.asd              # Sistema ASDF
├── run-tests.lisp              # Script de ejecución de pruebas
├── src/
│   └── calculator.lisp         # 5 operaciones aritméticas
├── tests/
│   └── calculator_tests.lisp   # 5 tests con FiveAM
├── .gitignore                  # Ignora archivos compilados
└── README.md                   # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **ASDF** como sistema de construcción y **FiveAM** como framework de pruebas.

Características:
- **5 operaciones**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Implementación minimalista**: `multiplication`, `division` y `modulus` se construyen usando solo `+` y `-` como operaciones primitivas, sin usar `*` ni `/`.
- **Dos sistemas ASDF**: `calculator` (biblioteca) y `calculator/tests` (depende de `fiveam`).
- **Script de pruebas**: `run-tests.lisp` carga el sistema y ejecuta la suite.

**EN:** This project uses **ASDF** as the build system and **FiveAM** as the testing framework.

Features:
- **5 operations**: `addition`, `subtraction`, `multiplication`, `division`, `modulus`.
- **Minimalist implementation**: `multiplication`, `division` and `modulus` are built using only `+` and `-` as primitive operations, without using `*` or `/`.
- **Two ASDF systems**: `calculator` (library) and `calculator/tests` (depends on `fiveam`).
- **Test script**: `run-tests.lisp` loads the system and runs the suite.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `calculator.asd` — Sistema ASDF

**ES:** Define dos sistemas: `calculator` (compila `src/calculator.lisp`) y `calculator/tests` (compila `tests/calculator_tests.lisp`, depende de `fiveam` y `calculator`).

**EN:** Defines two systems: `calculator` (compiles `src/calculator.lisp`) and `calculator/tests` (compiles `tests/calculator_tests.lisp`, depends on `fiveam` and `calculator`).

```common-lisp
(defsystem "calculator"
  :depends-on ()
  :components ((:module "src"
                :components ((:file "calculator")))))

(defsystem "calculator/tests"
  :depends-on ("calculator" "fiveam")
  :components ((:module "tests"
                :components ((:file "calculator_tests"))))
  :perform (test-op (op c)
    (uiop:symbol-call :calculator/tests :run-tests)))
```

### `src/calculator.lisp` — Implementación

**ES:** Las 5 operaciones. `multiplication` suma repetidamente, `division` resta repetidamente, y `modulus` usa ambos.

**EN:** The 5 operations. `multiplication` repeatedly adds, `division` repeatedly subtracts, and `modulus` uses both.

```common-lisp
(defun addition (a b)
  (+ a b))

(defun subtraction (a b)
  (- a b))

(defun multiplication (a b)
  (let ((result 0))
    (loop for i from 1 to b do
         (setf result (addition result a)))
    result))

(defun division (a b)
  (let ((quotient 0) (rem a))
    (loop while (>= rem b) do
         (setf rem (subtraction rem b))
         (setf quotient (addition quotient 1)))
    quotient))

(defun modulus (a b)
  (let ((quotient (division a b)))
    (subtraction a (multiplication quotient b))))
```

### `tests/calculator_tests.lisp` — Pruebas FiveAM

**ES:** 5 tests individuales, cada uno con una aserción `is`. La función `run-tests` ejecuta la suite y reporta resultados.

**EN:** 5 individual tests, each with an `is` assertion. The `run-tests` function runs the suite and reports results.

```common-lisp
(def-suite calculator-suite
  :description "Suite of calculator tests")
(in-suite calculator-suite)

(test addition-test
  (is (= 5 (addition 2 3))))

(test subtraction-test
  (is (= 2 (subtraction 5 3))))

(test multiplication-test
  (is (= 12 (multiplication 3 4))))

(test division-test
  (is (= 3 (division 10 3))))

(test modulus-test
  (is (= 1 (modulus 10 3))))

(defun run-tests ()
  (run! 'calculator-suite))
```

### `run-tests.lisp` — Script de ejecución

**ES:** Carga el sistema ASDF y ejecuta la suite de tests.

**EN:** Loads the ASDF system and runs the test suite.

```common-lisp
(asdf:load-asd (merge-pathnames "calculator.asd" *load-pathname*))
(asdf:load-system :calculator/tests)
(calculator/tests:run-tests)
```

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Roswell y Quicklisp instalados

```bash
# Roswell
# Descargar desde: https://github.com/roswell/roswell/releases
ros --version

# FiveAM se instalará automáticamente vía Quicklisp
```

### Ejecutar pruebas

```bash
cd core/foundations/unit_test/calculator
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

**Salida esperada / Expected output:**

```text
; compilation finished in 0:00:00.000
Running test suite CALCULATOR-SUITE
Running test ADDITION-TEST .
Running test SUBTRACTION-TEST .
Running test MULTIPLICATION-TEST .
Running test DIVISION-TEST .
Running test MODULUS-TEST .
Did 5 checks.
Pass: 5 (100%)
Skip: 0 ( 0%)
Fail: 0 ( 0%)
```

---

## 🧠 Algoritmos / operaciones

| Operación | Implementación | Primitivas usadas |
|-----------|---------------|-------------------|
| `addition(a, b)` | `(+ a b)` | `+` |
| `subtraction(a, b)` | `(- a b)` | `-` |
| `multiplication(a, b)` | Suma repetitiva de `a`, `b` veces | `+` |
| `division(a, b)` | Resta repetitiva, cuenta cociente | `+`, `-` |
| `modulus(a, b)` | `a - (cociente * b)` | `+`, `-` |

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `multiplication` y `division` están implementadas con `loop`, que en Common Lisp es la forma iterativa estándar.
- **EN:** `multiplication` and `division` are implemented with `loop`, which is the standard iterative form in Common Lisp.
- **ES:** `modulus` reutiliza `division` y `multiplication` en lugar de usar `rem` o `mod` nativas.
- **EN:** `modulus` reuses `division` and `multiplication` instead of using native `rem` or `mod`.
- **ES:** Las pruebas usan **FiveAM**, un framework de testing ligero para Common Lisp instalable vía Quicklisp.
- **EN:** Tests use **FiveAM**, a lightweight testing framework for Common Lisp installable via Quicklisp.
- **ES:** `(uiop:quit)` termina el proceso Lisp con el código de retorno apropiado.
- **EN:** `(uiop:quit)` terminates the Lisp process with the appropriate exit code.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

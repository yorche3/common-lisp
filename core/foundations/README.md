# 🚀 Foundations — Common Lisp

Implementaciones de la [Fase 0 — Fundamentos](https://yorche3.github.io/programming_languages/ROADMAP/#fase-0--fundamentos--foundations--completada) en **Common Lisp (Roswell + SBCL)**: `helloworld`, `hellouser`, `unit_test/calculator` y `numbers`.

---

## 📖 Módulos / Modules

| Módulo | Especificación | Enfoque | Tests | Estado |
|--------|---------------|---------|:-----:|:------:|
| [`helloworld/`](helloworld/) | [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) | Script Roswell (shebang) + `ros run` / `sbcl --script` | — | ✅ |
| [`hellouser/`](hellouser/) | [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) | `ros run` / `sbcl --script` | — | ✅ |
| [`unit_test/calculator/`](unit_test/calculator/) | [03_Unit_Test_Calculator](https://yorche3.github.io/programming_languages/core/foundations/03_Unit_Test_Calculator/) | ASDF + FiveAM (`ros run --load run-tests.lisp`) | 5 | ✅ |
| [`numbers/`](numbers/) | [04_Numbers](https://yorche3.github.io/programming_languages/core/foundations/04_Numbers/) | ASDF + FiveAM (`ros run --load run-tests.lisp`) | 33 | ✅ |

---

## 📁 Estructura / Structure

```text
foundations/
├── helloworld/                   # 01_Hello_World
│   ├── hello_world.lisp          # Script Roswell con shebang
│   └── README.md
│
├── hellouser/                    # 02_Hello_User
│   ├── hello_user.lisp           # (format t ...) + read-line
│   └── README.md
│
├── unit_test/
│   └── calculator/               # 03_Unit_Test_Calculator
│       ├── calculator.asd        # Sistema ASDF
│       ├── run-tests.lisp        # Script de ejecución
│       ├── src/
│       │   └── calculator.lisp   # 5 operaciones (+,-,*,/,mod)
│       ├── tests/
│       │   └── calculator_tests.lisp  # 5 tests FiveAM
│       └── README.md
│
└── numbers/                      # 04_Numbers
    ├── numbers.asd               # Sistema ASDF
    ├── run-tests.lisp            # Script de ejecución
    ├── src/
    │   └── numbers.lisp          # 15 funciones (3 enfoques × 5 algoritmos)
    ├── tests/
    │   ├── numbers_recursive_tests.lisp     # 11 tests recursivos
    │   ├── numbers_accumulator_tests.lisp   # 11 tests con acumulador
    │   └── numbers_iterative_tests.lisp     # 11 tests iterativos
    └── README.md
```

---

## 🛠️ Patrón común / Common Pattern

| Característica | Descripción |
|---------------|-------------|
| **Runtime** | SBCL (Steel Bank Common Lisp) vía Roswell |
| **CLI** | `ros` (Roswell) — gestor de entornos Common Lisp |
| **Build system** | ASDF (`<proyecto>.asd`) para proyectos con tests |
| **Test framework** | [FiveAM](https://common-lisp.net/project/fiveam/) — framework de testing ligero |
| **Test runner** | `ros run --load run-tests.lisp --eval '(uiop:quit)'` |
| **Script simple** | `ros run --load <archivo>.lisp --eval "(quit)"` o `sbcl --script <archivo>.lisp` |
| **Quicklisp** | Gestor de paquetes — instala dependencias (FiveAM) automáticamente |

---

## 🚀 Compilación rápida / Quick Build

```bash
# Hello, World!
cd helloworld
./hello_world.lisp          # si es ejecutable, o:
ros run --load hello_world.lisp --eval '(quit)'

# Hello, User!
cd hellouser
ros run --load hello_user.lisp --eval '(quit)'

# Calculator Tests
cd unit_test/calculator
ros run --load run-tests.lisp --eval '(uiop:quit)'

# Numbers Tests
cd numbers
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

## ▶️ Siguiente / Next

👉 Después de fundamentos, continúa con [Fase 1 — Algoritmos Puros](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).  
👉 After foundations, continue with [Phase 1 — Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-).

---

*[← Volver a Common Lisp](../../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

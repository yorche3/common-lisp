# Common Lisp

Proyectos en **Common Lisp**, ejecutados con **Roswell (ros)** sobre **SBCL**. Usa **ASDF** para la gestión de sistemas y **FiveAM** como framework de pruebas unitarias, con **Quicklisp** para la gestión de dependencias.

---

## 📂 Módulos / Modules

| Módulo | Descripción |
|--------|-------------|
| [`core/foundations/`](core/foundations/) | **Fase 0 — Fundamentos**: `helloworld`, `hellouser`, `calculator`, `numbers` |

---

### ▶️ Comenzar / Getting Started

```bash
# Hello, World!
cd core/foundations/helloworld
./hello_world.lisp

# Hello, User!
cd core/foundations/hellouser
ros run --load hello_user.lisp --eval '(quit)'

# Calculator Tests
cd core/foundations/unit_test/calculator
ros run --load run-tests.lisp --eval '(uiop:quit)'

# Numbers Tests
cd core/foundations/numbers
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

---

## 📦 Requisitos / Requirements

| Herramienta | Instalación |
|-------------|-------------|
| [Roswell](https://github.com/roswell/roswell) | Descargar desde [releases](https://github.com/roswell/roswell/releases) |
| SBCL (vía Roswell) | `ros install sbcl-bin` |
| Quicklisp (vía Roswell) | Incluido con Roswell |

```bash
# Verificar instalación
ros --version
ros list installed
```

---

## 🏗️ Tipos de proyecto / Project Types

### 1. Script simple (archivo único)

**ES:** Un único archivo `.lisp`, sin dependencias externas, ejecutado directamente con `ros run --load` y `--eval '(quit)'` para salir del REPL, o con `sbcl --script`. Ideal para `helloworld` y `hellouser`.

**EN:** A single `.lisp` file, no external dependencies, executed directly with `ros run --load` and `--eval '(quit)'` to exit the REPL, or with `sbcl --script`. Ideal for `helloworld` and `hellouser`.

```bash
ros run --load <archivo>.lisp --eval '(quit)'
# o
sbcl --script <archivo>.lisp
```

### 2. Proyecto ASDF con pruebas (ASDF + FiveAM)

**ES:** Para proyectos que requieren pruebas unitarias, se utiliza un sistema ASDF (`.asd`) que define la biblioteca y el sistema de tests. Las pruebas usan **FiveAM** y las dependencias se resuelven vía Quicklisp. Un script `run-tests.lisp` orquesta la carga y ejecución.

**EN:** For projects requiring unit tests, an ASDF system (`.asd`) defines the library and test system. Tests use **FiveAM** and dependencies are resolved via Quicklisp. A `run-tests.lisp` script orchestrates loading and execution.

```bash
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

---

## 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---
*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*
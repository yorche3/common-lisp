# Hello, User! — Common Lisp

Implementación de la especificación [02_Hello_User](https://yorche3.github.io/programming_languages/core/foundations/02_Hello_User/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL**.

Lee un nombre desde la entrada estándar y saluda al usuario.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_user.lisp`](hello_user.lisp) | Código fuente: solicita un nombre al usuario y saluda. |

**Estructura de directorios esperada:**

```text
hellouser/
├── hello_user.lisp     # Código fuente
└── README.md           # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este programa introduce dos conceptos nuevos respecto a `hello_world`:

1. **Lectura de entrada** — `read-line` lee una línea completa desde `*standard-input*`.
2. **Salida formateada** — `format` con `~A` para insertar el nombre en el saludo.

**EN:** This program introduces two new concepts compared to `hello_world`:

1. **Input reading** — `read-line` reads a full line from `*standard-input*`.
2. **Formatted output** — `format` with `~A` to insert the name into the greeting.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_user.lisp`

**ES:** El flujo del programa es:

1. Imprimir `"Enter your name: "` con `format t`.
2. Forzar el vaciado del buffer con `force-output` para asegurar que el prompt se muestre antes de leer.
3. Leer el nombre con `read-line`.
4. Imprimir `"Hello, <nombre>!"` con `format t` usando `~A` para insertar el nombre.

**EN:** Program flow:

1. Print `"Enter your name: "` with `format t`.
2. Force buffer flush with `force-output` to ensure the prompt is displayed before reading.
3. Read the name with `read-line`.
4. Print `"Hello, <name>!"` with `format t` using `~A` to insert the name.

```common-lisp
(format t "Enter your name: ")
(force-output)
(let ((name (read-line)))
  (format t "Hello, ~a!~%" name))
```

| Elemento | Propósito |
|----------|-----------|
| `format t "..."` | Imprime el prompt en la salida estándar |
| `force-output` | Vacía el buffer de salida para que el prompt se muestre inmediatamente |
| `read-line` | Lee una línea completa (hasta Enter) desde la entrada estándar |
| `let ((name ...))` | Vincula la entrada leída a la variable local `name` |
| `~a` | Directiva de formato: inserta el valor en forma "estética" (sin comillas) |
| `~%` | Directiva de formato: inserta un salto de línea |

> **ES:** `force-output` es necesaria porque algunos sistemas Lisp bufferizan la salida estándar. Sin ella, el prompt podría no aparecer antes de que el programa quede esperando entrada.
> **EN:** `force-output` is needed because some Lisp systems buffer standard output. Without it, the prompt might not appear before the program waits for input.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Roswell instalado

```bash
# Verificar instalación
ros --version
```

### Ejecutar

```bash
# Con Roswell
cd core/foundations/hellouser
ros run --load hello_user.lisp --eval "(quit)"

# O con SBCL directamente
sbcl --script hello_user.lisp
```

**Salida esperada / Expected output:**

```text
Enter your name: Ada
Hello, Ada!
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** `read-line` lee toda la línea incluyendo espacios, a diferencia de `read` que leería solo un símbolo.
- **EN:** `read-line` reads the entire line including spaces, unlike `read` which would only read a single symbol.
- **ES:** `force-output` asegura que el prompt se muestre antes de que `read-line` bloquee esperando entrada.
- **EN:** `force-output` ensures the prompt is displayed before `read-line` blocks waiting for input.
- **ES:** La directiva `~a` (minúscula) imprime el valor sin comillas ni escapes, ideal para cadenas.
- **EN:** The `~a` (lowercase) directive prints the value without quotes or escapes, ideal for strings.
- **ES:** `(quit)` termina el proceso Lisp, necesario con `ros run` para que no quede en el REPL.
- **EN:** `(quit)` terminates the Lisp process, needed with `ros run` so it doesn't stay in the REPL.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

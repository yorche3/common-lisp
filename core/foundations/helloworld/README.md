# Hello, World! — Common Lisp

Implementación de la especificación [01_Hello_World](https://yorche3.github.io/programming_languages/core/foundations/01_Hello_World/) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL**.

---

## 📂 Archivos y estructura / Files & Structure

| Archivo | Propósito |
|---------|-----------|
| [`hello_world.lisp`](hello_world.lisp) | Código fuente: imprime `"Hello, World! from Common Lisp"` en la consola. |

**Estructura de directorios esperada:**

```text
helloworld/
├── hello_world.lisp     # Código fuente
└── README.md            # Este archivo
```

---

## 🛠️ Enfoque y construcción / Approach & Build

**ES:** Este proyecto usa **Roswell (ros)** con **SBCL** y sigue un enfoque minimalista: un único archivo fuente, sin dependencias externas, ejecutado directamente con `ros`.

Características:
- **Sin dependencias externas** — solo usa la función `format` del estándar Common Lisp.
- **Ejecución directa** — un solo comando `ros` ejecuta el script.
- **Sin sistema de proyectos** — no necesita ASDF ni Quicklisp.

**EN:** This project uses **Roswell (ros)** with **SBCL** and follows a minimalist approach: a single source file, no external dependencies, executed directly with `ros`.

Features:
- **No external dependencies** — only uses the `format` function from Common Lisp standard.
- **Direct execution** — a single `ros` command runs the script.
- **No project system** — no ASDF or Quicklisp needed.

---

## 📄 Archivos de configuración clave / Key Configuration Files

### `hello_world.lisp`

**ES:** Punto de entrada. Llama a `format t` para imprimir el saludo en la salida estándar.

**EN:** Entry point. Calls `format t` to print the greeting to standard output.

```common-lisp
#!/bin/sh
#|-*- mode: lisp -*-*#
#|
exec ros -Q -- $0 "$@"
|#
(progn ;;init forms
  )

(defun main (&rest argv)
  (declare (ignorable argv))
  (format t "Hello, World! from Common Lisp~%"))
```

| Elemento | Propósito |
|----------|-----------|
| `shebang (#!/bin/sh ...)` | Cabecera que permite ejecutar el archivo directamente como script |
| `exec ros -Q -- $0 "$@"` | Ejecuta el script con Roswell, pasando los argumentos |
| `defun main (&rest argv)` | Punto de entrada definido por Roswell; `&rest argv` recibe los argumentos |
| `format t "...~%"` | Función de salida estándar de Common Lisp; `~%` inserta salto de línea |

> **ES:** Roswell provee una plantilla de script con shebang. La cabecera `#!/bin/sh` + `exec ros -Q -- $0 "$@"` permite que el archivo `.lisp` se ejecute directamente como un script de shell. Roswell define `main` como punto de entrada, y `format t` imprime en la consola.
> **EN:** Roswell provides a script template with shebang. The `#!/bin/sh` + `exec ros -Q -- $0 "$@"` header allows the `.lisp` file to be run directly as a shell script. Roswell defines `main` as the entry point, and `format t` prints to the console.

---

## 🚀 Compilación y ejecución / Build & Run

### Requisito: Tener Roswell instalado

Roswell es un gestor de entornos Common Lisp que maneja la instalación de implementaciones (SBCL, CCL, etc.) y la ejecución de scripts.

```bash
# Verificar instalación
ros --version

# Listar implementaciones instaladas
ros list installed
```

**Salida esperada / Expected output:**

```text
roswell 19.08.10.101(NO-GIT-REVISION)
Installed implementations:
Installed versions of sbcl-bin:
sbcl-bin/2.6.5
```

### Ejecutar

```bash
# Hacer ejecutable (solo una vez)
chmod +x hello_world.lisp

# Ejecutar directamente como script
cd core/foundations/helloworld
./hello_world.lisp

# O con Roswell
ros run --load hello_world.lisp --eval "(quit)"

# O con SBCL directamente
sbcl --script hello_world.lisp
```

**Salida esperada / Expected output:**

```text
Hello, World! from Common Lisp
```

---

## 📝 Notas de implementación / Implementation Notes

- **ES:** El shebang de Roswell permite ejecutar el archivo `.lisp` como un script de shell directamente (`./hello_world.lisp`).
- **EN:** Roswell's shebang allows running the `.lisp` file directly as a shell script (`./hello_world.lisp`).
- **ES:** Roswell maneja automáticamente la implementación de Lisp (SBCL por defecto). `ros run` inicia SBCL, `--load` carga el script y `--eval "(quit)"` sale del REPL.
- **EN:** Roswell automatically handles the Lisp implementation (SBCL by default). `ros run` starts SBCL, `--load` loads the script, and `--eval "(quit)"` exits the REPL.
- **ES:** La directiva `~%` en la cadena de formato de `format` es el equivalente a `\n` en otros lenguajes.
- **EN:** The `~%` directive in `format`'s format string is the equivalent of `\n` in other languages.
- **ES:** `(quit)` termina el proceso Lisp, necesario cuando se usa `ros run` para que no quede en el REPL.
- **EN:** `(quit)` terminates the Lisp process, needed when using `ros run` so it doesn't stay in the REPL.

---

### 🌐 Otras implementaciones / Other implementations

Este proyecto también está implementado en otros lenguajes. Explora el [repositorio principal](https://github.com/yorche3/programming_languages) para ver todas las versiones.

---

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

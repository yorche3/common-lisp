# Algorithms Pure — Common Lisp

Implementación de la fase [Algorithms Pure](https://yorche3.github.io/programming_languages/ROADMAP/#fase-1--algoritmos-puros--algorithms-pure-) en **Common Lisp**, ejecutado con **Roswell (ros)** sobre **SBCL** y probado con **FiveAM**.

---

## 📂 Módulos / Modules

| Módulo | Estado | Descripción / Description |
|--------|--------|---------------------------|
| [`naive_sort/`](naive_sort/) | ✅ | **Ordenamiento elemental** ($O(n^2)$): `selection-sort`, `bubble-sort`, `insertion-sort`. / **Elementary sorting** ($O(n^2)$): `selection-sort`, `bubble-sort`, `insertion-sort`. |

---

## 🚀 Compilación y ejecución / Build & Run

Cada módulo contiene sus propios comandos. Por ejemplo / Each module has its own commands. For example:

```bash
cd common-lisp/core/algorithms/naive_sort
ros run --load run-tests.lisp --eval '(uiop:quit)'
```

---

## 📝 Notas de implementación / Implementation Notes

**ES:** Common Lisp es un lenguaje con fuerte tradición funcional; el idioma evita la mutación cuando es razonable, por lo que los algoritmos devuelven una copia ordenada en lugar de ordenar in-place (la especificación permite ambas variantes). El indicador de fallo es `nil`. Las implementaciones usan `loop` y `rotatef`, sin invocar `sort` de la biblioteca estándar. El sistema base no tiene dependencias externas; `fiveam` se usa solo para pruebas.

**EN:** Common Lisp has a strong functional tradition; the idiom avoids mutation when reasonable, so the algorithms return a sorted copy instead of sorting in place (the specification allows both variants). The failure indicator is `nil`. Implementations use `loop` and `rotatef`, without calling the standard library's `sort`. The base system has no external dependencies; `fiveam` is used only for testing.

**ES:** Este proyecto también está implementado en otros lenguajes. Explora el repositorio principal para consultar las demás versiones.

**EN:** This project is also implemented in other languages. Explore the main repository to see the other versions.

---

*[← Volver a Core](../README.md)*

*🌐 [github.com/yorche3/programming_languages](https://github.com/yorche3/programming_languages) · [GitHub Pages](https://yorche3.github.io/programming_languages/)*

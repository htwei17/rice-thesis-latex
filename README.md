# Rice University Thesis Template (2026 Modernized)

**A clean, modern LaTeX template for Rice University PhD and Master's theses.**

This is a "hard fork" and modernization of the [legacy Rice LaTeX template](https://github.com/DaoWen/rice-thesis-latex), compatible with **XeLaTeX** engine, enabling support for system fonts, proper Unicode (including optional CJK characters), and compressed citation indices via **BibLaTeX**.

---

## 🛠️ Usage

### Option 1: Overleaf (Recommended)
1.  Find this project on Overleaf Templates.
2.  **Crucial Step:** Click the **Menu** button (top-left).
3.  Change **Compiler** from `pdfLaTeX` to **`XeLaTeX`**.
4.  Click **Recompile**.

### Option 2: Local Installation
You need a TeX distribution (TeX Live, MacTeX, or MiKTeX) installed. We recommend using `latexmk` to automate the build process.

**Build Command:**
```bash
latexmk -xelatex main.tex
```

**Clean Build Files:**
```bash
latexmk -c
```

---

## ⚙️ Configuration

### Class Options
You can pass options to the document class in `main.tex`:

```latex
% Standard setup
\documentclass[12pt]{ruthesis}

% Enable CJK font support (requires Fandol fonts or system fonts)
\documentclass[cjk]{ruthesis}

% Disable citation compression (e.g., show [1], [2] instead of [1-2])
\documentclass[nocompress]{ruthesis}
```

### Thesis Metadata
Edit the `main.tex` file to set your personal information. The template handles the formatting automatically.

```latex
\title{Your Thesis Title}
\author{Your Name}
\department{Physical and Astronomy}
\degree{Doctor of Philosophy}
% ... see main.tex for Committee members
```

---

## 📜 Credits & License

**Maintainer:** [Hao-Tian Wei](https://github.com/htwei17) (2026)  
**Previous Maintainer:** [DaoWen](https://github.com/DaoWen/rice-thesis-latex) (2017)  
**Original Author:** Jan Erik Odegard (1995)

* **License:** [LaTeX Project Public License 1.3c (LPPL)](https://www.latex-project.org/lppl/)
* **Copyright:** © 1995-2026 Rice University / Respective Authors.

This template is provided "as is" to help Rice University students. It is not an official product of the Rice University Office of Graduate and Postdoctoral Studies (GPS), though it is designed to meet their formatting guidelines. The authors provide no guarantee regarding strict adherence to current or future university formatting regulations, immunity from any compilation errors or crashes, or data integrity.

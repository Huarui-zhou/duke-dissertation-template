# Duke University Thesis and Dissertation LaTeX Template

This repository contains a modified and modernized LaTeX template for Duke University theses and dissertations.

The template is based on the existing Duke University thesis/dissertation LaTeX class developed and maintained over many years by multiple contributors. This version includes additional formatting and typography updates by **Huarui Zhou**.

## Overview

The template is designed to help format Duke University theses and dissertations according to current Graduate School formatting requirements while providing a cleaner and more modern typesetting style.

Major updates in this version include:

* Fixed page margins:

  * 1.5-inch left margin
  * 1-inch top margin
  * 1-inch right margin
  * 1-inch bottom margin measured below the page number
* Consistent margins on all pages without mirrored binding margins
* 14 pt main body text
* Libertinus Serif as the main text font
* Libertinus Math for mathematical typesetting
* Reduced excessive word hyphenation
* Redesigned and centered chapter headings
* Unified formatting for:

  * Abstract
  * Table of Contents
  * List of Figures
  * List of Tables
  * Acknowledgements
  * Biography
  * Numbered chapters
* Increased spacing between major headings and body text
* Updated title-page and abstract-page typography
* Support for both department and graduate program information
* Improved page-number placement and vertical spacing

## Compilation

This template uses `fontspec` and `unicode-math`, so it should be compiled using:

* LuaLaTeX, or
* XeLaTeX

LuaLaTeX is recommended.

A typical compilation workflow is:

```text
LuaLaTeX
BibTeX
LuaLaTeX
LuaLaTeX
```

If using Overleaf, select **LuaLaTeX** as the compiler.

## Bibliography

The template is compatible with `natbib`.

For numeric citations such as:

```text
[1]
[2–4]
[1,3,5–7]
```

the preamble can include:

```latex
\usepackage[numbers,square,sort&compress]{natbib}
```

A Nature-style bibliography can be produced using, for example:

```latex
\bibliographystyle{naturemag}
\bibliography{Bibliography/mybib}
```

## Repository Structure

A typical project may be organized as:

```text
.
├── thesis.tex
├── dukedissertation2026.cls
├── Bibliography/
│   └── mybib.bib
├── Abstract/
├── Acknowledgements/
├── Chapter1/
├── Chapter2/
├── Appendix1/
├── Biography/
└── Pictures/
```

The exact organization can be changed as needed.

## History and Attribution

This template is derived from the Duke University thesis and dissertation LaTeX template developed through contributions from multiple authors, including:

* Mitchell Abrams
* Leon Riesebos
* Michael Gratton
* Mark Holliday
* Charlie Martin
* Russ Tuck
* Sean O'Connell
* Michael Todd
* Syam Gadde
* Rajiv Wickremesinghe
* Hugh Crumley
* Michael Gao

The class file itself contains a more detailed development history and changelog.

### 2026 modifications

Additional modifications and formatting updates were made by:

**Huarui Zhou**
2026

These changes include updated margins, typography, font configuration, chapter and front-matter heading design, page layout, and title-page formatting.

## License

This repository is distributed under the **LaTeX Project Public License (LPPL), version 1.3c**.

This project is a modified version of an existing LaTeX work. Original authorship and contribution history are retained in the class file.

See the `LICENSE` file for details.

## Disclaimer

This repository is **not an official Duke University publication or officially maintained Duke University software**.

Formatting requirements may change over time. Users should always verify their final thesis or dissertation against the most recent requirements published by the Duke University Graduate School before submission.

The template is intended as a formatting aid and does not guarantee acceptance by the Graduate School.

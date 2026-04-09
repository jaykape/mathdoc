# Contributing Guidelines

This document provides guidelines for maintaining and contributing to this thesis project.

## Project Organization

### Directory Structure

- `thesis/` - Main thesis content and configuration
- `thesis/Figures/` - All figures and diagrams
- `thesis/Fonts/` - Custom fonts
- Root level - Configuration files and documentation

### File Naming Conventions

- Chapter files: `<number>-<topic>.tex` (e.g., `1-introduction.tex`)
- Appendix files: `A<number>-<description>.tex` (e.g., `A0-appendix-sample.tex`)
- Use lowercase with hyphens for separators
- Custom commands/styles: descriptive names (e.g., `quantum-circuit-drawing-command.tex`)

### Coding Standards

#### LaTeX Style

- Keep lines reasonably short (< 100 characters)
- Use meaningful section names with `\section{}`, `\subsection{}`, etc.
- Comment complex constructs
- Separate chapters into individual `.tex` files
- Use consistent spacing and indentation

#### Bibliography

- Add all references to `my-thesis-ref.bib`
- Use consistent citation key format: `AuthorYear` or `AuthorYearTopic`
- Verify all citations are in correct format for `chulanat.bst`

#### Mathematics

- Use `amsmath` environments for aligned equations
- Define custom mathematical commands if used multiple times
- Use consistent notation throughout

## Building the Document

### Local Build

```bash
make pdf        # Build thesis
make clean      # Clean artifacts
make distclean  # Full cleanup
```

### Build Verification

Always compile to check for:

- Missing `.tex` files or undefined references
- Bibliography errors
- Undefined LaTeX commands
- Overfull/underfull boxes

## Git Workflow

### Before Committing

1. Run `make clean` to remove build artifacts
2. Verify `.gitignore` prevents tracking build files
3. Write clear commit messages

### Commit Messages

Use clear, descriptive messages:

- "Add introduction chapter - initial draft"
- "Update literature review with new references"
- "Fix formatting in background chapter"
- "Add quantum circuit drawing commands"

## Chapter Development

1. Create chapter file following naming convention
2. Add minimal structure with `\chapter{}` and `\section{}` headers
3. Include in `main.tex`
4. Test compilation before major commits
5. Add progress updates to `PROGRESS.md`

## Figures and References

- Store all figures in `thesis/Figures/`
- Use descriptive filenames: `fig-<topic>-<number>.<ext>`
- Reference figures by labels: `\label{fig:...}`, `\ref{fig:...}`
- Maintain consistent figure captions and source attribution

## Support Resources

- Chulalongkorn thesis class documentation: `thesis/chula-memoir.cls`
- TeX/LaTeX references: [CTAN](https://www.ctan.org/), [Overleaf](https://www.overleaf.com/learn)
- Thesis parameters: `thesis/thesisParam.tex`

---

For questions or issues, review the existing thesis files and configuration before making changes.

.PHONY: all clean pdf view

# Main target
all: pdf

# Build PDF using latexmk
pdf:
	latexmk -pdf -cd thesis/main.tex

# View the PDF (adjust according to your PDF viewer)
view: pdf
	thesis/main.pdf

# Clean build artifacts
clean:
	latexmk -c -cd thesis/main.tex
	rm -f thesis/main.pdf

# Deep clean - remove all generated files
distclean:
	latexmk -C -cd thesis/main.tex
	rm -f thesis/*.pdf thesis/*.auxlock

# Help
help:
	@echo "Available targets:"
	@echo "  make          - Build PDF (default)"
	@echo "  make pdf      - Build PDF"
	@echo "  make view     - Build and view PDF"
	@echo "  make clean    - Remove LaTeX artifacts"
	@echo "  make distclean- Remove all generated files"
	@echo "  make help     - Show this help message"

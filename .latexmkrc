# latexmk configuration file for thesis compilation

# PDF mode: use PDF LaTeX
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

# Use pdflatex with optimized settings
$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';

# Bibtex command
$bibtex = 'bibtex %O %B';

# Remove generated auxiliary files after compilation
$clean_ext = 'synctex.gz dpth md5 auxlock';

# Set output directory for auxiliary files
# Uncomment if you want to organize build artifacts
# $aux_dir = 'build/aux';
# $out_dir = 'build/out';

# Number of passes for pdflatex
$max_repeat = 5;

# Ensure figures are found
# Add any custom figure search paths if needed
# $ENV{TEXINPUTS} = './Figures//:';

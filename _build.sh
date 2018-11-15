#!/bin/sh

set -ev

rm -r _book/
rm -r _bookdown_files/

Rscript -e "bookdown::render_book('index.Rmd')"

touch docs/.nojekyll

mv CAMH_Rstats.pdf docs/

rm -r _bookdown_files/

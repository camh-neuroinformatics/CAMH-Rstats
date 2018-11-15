This contains the R-stats workshop content being taught at CAMH. 


The bookdown formatting was adapted from a minimal example of a book based on R Markdown and **bookdown** (https://github.com/rstudio/bookdown). Please see the page "[Get Started](https://bookdown.org/yihui/bookdown/get-started.html)" at https://bookdown.org/yihui/bookdown/ for how to compile this example into HTML. You may generate a copy of the book in `bookdown::pdf_book` format by calling `bookdown::render_book('index.Rmd', 'bookdown::pdf_book')`. More detailed instructions are available here https://bookdown.org/yihui/bookdown/build-the-book.html.


```{r include=FALSE}
# automatically create a bib database for R packages
knitr::write_bib(c(
  .packages(), 'bookdown', 'knitr', 'rmarkdown'
), 'packages.bib')
```

## how to render

This will re-render the book into the /docs folder after making edits.

```sh
source _build.sh
touch docs/.nojekyll
mv ../CAMH_Rstats.pdf docs/
rm -r 
```

## Note to us

We can add css styles to custom blocks for an extra Q & A section later..
https://bookdown.org/yihui/bookdown/custom-blocks.html

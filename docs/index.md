--- 
title: "CAMH R-stats Workshops"
author: "Erin Dickie"
date: "2018-11-15"
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
bibliography: [book.bib, packages.bib]
biblio-style: apalike
link-citations: yes
github-repo: camh-neuroinformatics/CAMH-Rstats
description: "This is a minimal example of using the bookdown package to write a book. The output format for this example is bookdown::gitbook."
---

# Prerequisites

Please have these both installed (come early if you need help):

* **R**: [Download from here](https://cran.r-project.org/)
* **rstudio**: [Download from here](https://www.rstudio.com/products/RStudio/#Desktop)

Also, please install here awesome R packages (again, if you don't know how please come early):

* `rms` 
* `tidyverse`

--------

This book works from the following files of fake clinical data, that can be downloaded from the following links:


1. [messy_demographic.csv](https://raw.githubusercontent.com/CAMH-SCWG/example-party/master/messy_data/messy_demographic.csv)
2. [messy_cognitive.csv](https://raw.githubusercontent.com/CAMH-SCWG/example-party/master/messy_data/messy_cognitive.csv)
2. [messy_cognitive.csv](https://raw.githubusercontent.com/CAMH-SCWG/example-party/master/messy_data/messy_cognitive.csv)

---------

## RStudio environment



Welcome to R studio! You should see 4 spaces:

1. **Source**
  * Your script! everything you do to your data should be typed here!! It saves what you are
  doing in a file ending in '.R'
2. **Console**
  * The place where the good stuff happens. When you run a command, you see the output here.
3. **Enviroment/History**
  * Enviroment: a list of everything in your "Workspace"
  * History: a list of every command you have run
4. **Files/Plots/Packages/Help**
  * Files: a file browser (like windows Explorer)
  * Plots: your plots will show up here
  * Packages: a list of all the packages you have installed with checkboxes showing if it is loaded
  * Help: your help documentation with be shown here.

----------

## Loading libraries / installing packages 


for this tutorial, we are going to use the packages ggplot, rms and car.

+ Look at the **Packages Tab**
+ Click on the check box to the left of "ggplot2"
+ Notice that a bunch of lines start running in **Console** window to show you that the package is loading
+ Go to the **History Tab** (top right corner)
+ Notice that you should see lines starting in library("rms"..) and library("ggplot2"...) have just run
+ Click on these lines to highlight them, then click on **To Source** at the top of the panel
+ This moves the lines we just ran into our script so we can rerun this step tomorrow!


```r
library(tidyverse)
```

--------
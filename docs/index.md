--- 
title: "CAMH R-stats Workshops"
author: "Erin Dickie"
date: "2019-05-29"
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

## Installing software

Please have these both installed (come early if you need help):

* **R**: [Download from here](https://cran.r-project.org/)
  * **MacOS users**
    * Click on the "Download R for (Mac) OS X" link at the top of the page
    * Click on the `.pkg` file containing the latest version of R (currently 3.6.0) and save it to your computer. Double-click this file to run it and follow the installation instructions
  * **Windows users**
    * Click on the "Download R for Windows" link at the top of the page
    * Click on the "base" link
    * Click the "Download R 3.6.0 for Windows" and save the `.exe` file to your computer. Double click this file to run it and follow the installation instructions
  
* **RStudio**: [Download from here](https://www.rstudio.com/products/rstudio/download/#download)
  * **MacOS users**
    * Click on the latest Mac OS X version and save the `.dmg` file on your computer. Double-click the file to run it and follow the installation instructions
  * **Windows users**
    * Click on the latest Windows 7+ version and save the `.exe` file on your computer. Double-click the file to run it and follow the installation instructions

You may also use R and RStudio in a [web browser](https://rstudio.cloud). This method requires you to login with either a Gmail or GitHub account.

--------

## Downloading sample data

This book works from the following files of fake clinical data, that can be downloaded from the following links:

1. [messy_demographic.csv](https://raw.githubusercontent.com/josephmje/CAMH-Rstats/master/data/messy_demographic.csv)
2. [messy_cognitive.csv](https://raw.githubusercontent.com/josephmje/CAMH-Rstats/master/data/messy_cognitive.csv)
2. [messy_genotype.csv](https://raw.githubusercontent.com/josephmje/CAMH-Rstats/master/data/messy_genotype.csv)

---------

## RStudio environment

Welcome to RStudio! You should see 4 window panes:

1. **Source**
  * Your script! everything you do to your data should be typed here!! It saves what you are
  doing in a file ending in `.R`
2. **Console**
  * The place where the good stuff happens. When you run a command, you see the output here.
3. **Enviroment/History**
  * Environment: a list of everything in your "Workspace"
  * History: a list of every command you have run
4. **Files/Plots/Packages/Help**
  * Files: a file browser (like Windows Explorer or Finder)
  * Plots: your plots will show up here
  * Packages: a list of all the packages you have installed with checkboxes indicating whether they are loaded
  * Help: your help documentation with be shown here

----------

## Loading libraries / installing packages 

For this tutorial, we are going to use the packages tidyverse, tableone, rms and car. Please install them if you haven't done so already.


```r
install.packages(c("tidyverse", "rms", "tableone", "car"))
```

+ Look at the **Packages Tab**
+ Click on the check box to the left of "ggplot2"
+ Notice that a bunch of lines start running in **Console** window to show you that the package is loading
+ Go to the **History Tab** (top right corner)
+ Notice that you should `library(ggplot2)` has just run
+ Click on these lines to highlight them, then click on **To Source** at the top of the panel
+ This moves the lines we just ran into our script so we can re-run this step tomorrow!

--------

## Cheat Sheets

There are several [cheat sheets](https://www.rstudio.com/resources/cheatsheets/) available online that provide a quick reference when working with functions in the tidyverse.

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

<!--chapter:end:index.Rmd-->

# Importing Data into R

## Read in data

The two datasets we will be using are:

1. **messy_demographic.csv:**
  * 5 variables: 
    + subject identifier (subject_ID), age, sex, ethnicity, and diagnosis (dx) 

2. **messy_cognitive.csv:**
  * 4 variables: 
    + subject identifier (subID), and three cognitive scores (cog1, cog2, cog3) 

In order to view and manipulate this data in R, we need to *import* the data into our R workspace (the same as you would open a file in Excel to edit it).

*Rstudio trick:*

* Click on the `Environment` Tab, then click on `Import Dataset` --> `From Text File (readr)`
* Navigate the browser window to the location of *messy_cognitive.csv* and click **Open**
* This opens a text reader window: You see the raw text on the top and what R will read in (the data frame) at the bottom
* In my view, it looks like the R is not going to read in the first line as a header..to change this
* switch the **Heading** option on the right to **yes**
* Click **Import**
* Now, if you look at the **Environment** tab you should see that *demo_df* has been loaded into R, It has 350 rows (or observations) and 5 variables
* So that you do not have to type this again tomorrow - go to History, click on the line "demo_df <- read.csv(...)" and then click on **To Source**
* Repeat this whole process for *messy_demographic.csv*


```r
library(readr)
demo_df <- read_csv("~/Downloads/messy_demographic.csv")
cog_df <- read_csv("~/Downloads/messy_cognitive.csv")
```



* What you actually did was use the `read_csv` function... to find out more about this option you can type `?read_csv` in the Console
* This is the basic syntax of R functions: some.function("stuff inside to do the function on")
* The *help document* for the `read_csv` function is shown in the **Help** tab

Now we have two **"data frames"** loaded into our workspace. They are called demo_df and cog_df.

-------

## Basic data summaries and visualization ( head, tail, describe() )

+ Now that we have the data loaded, how do we just look at it? The simplest way is with the "View" function within RStudio.
+ In Enviroment tab, click on the little spreadsheet to the far right of the `demo_df` row. This shows you your data in what looks like a spreadsheet - but you cannot edit it!

To look at the top six rows of your data:


```r
head(demo_df)
```

```
## # A tibble: 6 x 5
##   subject_ID age     sex ethnicity dx   
##   <chr>      <chr> <dbl> <chr>     <chr>
## 1 SUB_1      43        0 Cauc      0    
## 2 SUB_2      47        1 Cauc      1    
## 3 SUB_3      69        1 Cauc      1    
## 4 SUB_4      51        0 Cauc      1    
## 5 SUB_5      52        1 Cauc      0    
## 6 SUB_6      71        0 AA        1
```

To look at the bottom six rows:


```r
tail(cog_df)
```

```
## # A tibble: 6 x 4
##   subID      cog1             cog2             cog3            
##   <chr>      <chr>            <chr>            <chr>           
## 1 subject345 10.5491439098318 29.0366805293698 50.0341778674542
## 2 subject346 13.7560798734217 21.047620123942  11.2510017219872
## 3 subject347 16.4949897425522 33.323511618334  2.42614834379569
## 4 subject348 11.1612493587292 30.8723352333704 16.0049438698844
## 5 subject349 15.3654440645612 29.7598065423247 44.3994545119479
## 6 subject350 13.993297479479  28.3229119000634 11.2012255384154
```

Using the function `names()` tells us what all the variables in our dataframe are called.


```r
names(demo_df)
```

```
## [1] "subject_ID" "age"        "sex"        "ethnicity"  "dx"
```

the `ls()` function does the same thing, except it returns the variables in alphabetical order


```r
ls(demo_df)
```

```
## [1] "age"        "dx"         "ethnicity"  "sex"        "subject_ID"
```

That was all nice, but we want to find out more about this data we can use `summary()`


```r
summary(demo_df)
```

```
##   subject_ID            age                 sex         
##  Length:350         Length:350         Min.   :   0.00  
##  Class :character   Class :character   1st Qu.:   0.00  
##  Mode  :character   Mode  :character   Median :   1.00  
##                                        Mean   :  29.44  
##                                        3rd Qu.:   1.00  
##                                        Max.   :9999.00  
##                                        NA's   :3        
##   ethnicity              dx           
##  Length:350         Length:350        
##  Class :character   Class :character  
##  Mode  :character   Mode  :character  
##                                       
##                                       
##                                       
## 
```

```r
summary(cog_df)
```

```
##     subID               cog1               cog2          
##  Length:350         Length:350         Length:350        
##  Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character  
##      cog3          
##  Length:350        
##  Class :character  
##  Mode  :character
```

---------

## Data cleaning

* Now that you have looked at your data - you might have noticed that there are a couple problems
The RA that you have been working with has coded missing values in three different ways ("9999", "missing", and "")
* We first need to set these all to NA - which R recognizes as missing value:

The following will take all values in demo_df that are equal to "", "missing", or "9999", and code them as missing in a way that R understands:


```r
demo_df[demo_df==""] <- NA
demo_df[demo_df=="missing"] <- NA
demo_df[demo_df=="9999"] <- NA
```

Because R is "smart", it categorizes data types automatically when data are loaded. Before working with new data, especailly if it is real (i.e. messy), it is important to tell R what kind of data
you are dealing with. This will be especially important when we discuss our statistical analyses... after all, R is statistical software.

The following will correctly format our variables for analyses:

* age is a numeric variable
* ethicity is a discrete factor
* sex is a discrete factor
* diagnosis is a discrete factor


```r
demo_df$age <- as.numeric(as.character(demo_df$age))
demo_df$ethnicity <- factor(demo_df$ethnicity,levels=c("Cauc","AA","As","In","Other"))
demo_df$sex <- factor(demo_df$sex, levels=c(0,1), labels=c("Male","Female"))
demo_df$dx <- factor(demo_df$dx, levels=c(0,1), labels=c("Control","Case"))
```

By indicating the levels of our factors, we have erased from R the memory that we once had values of
"", "9999", and "missing" (which up until now R had no reason to assume were not observations).

Let us now apply the same cleanup steps to our second data frame:

Remove missing:


```r
cog_df[cog_df==""] <- NA
cog_df[cog_df=="missing"] <- NA
cog_df[cog_df=="9999"] <- NA
```

Correctly format variables for analyses:


```r
cog_df$cog1 <- as.numeric(as.character(cog_df$cog1))
cog_df$cog2 <- as.numeric(as.character(cog_df$cog2))
cog_df$cog3 <- as.numeric(as.character(cog_df$cog3))
```

---------

## Merging data frames

In order to analyze the effect of sex on diagnosis, or perform any other comparison across our data frames, we should merge them. If you remember only this and nothing else today, it will still have been worth your time.

Conceptually, merging two data frames assumes that the rows in one correspond to rows in the other, even if they are not in the same order. In order to match up the correct rows between data frames we need to make sure that one column in each spreadsheet can act as a "key" (i.e. each row has a unique value in this key that is the same in both spreadsheets). In our case, we have one subject identifier column in each of our spreadsheets.

### First we need to make sure that the values in these columns are the same

We are going to make use a package called `stringr`, which was built to help us manipulate "strings" (string is a computer science word of sets of characters).  

*Note:* There are many ways to deal strings in r, too many ways in fact. `stringr` was created to make the commands working with strings more consistent so that your code will be easier for another person to read. 


```r
library(stringr)
cog_df$subject_ID <- str_replace(cog_df$subID,"subject","SUB_")
```

We can then merge the two datasets by specifying their names (in order x,y) and then specifying which columns are to be used as the key to merging the two data frames (by.x and by.y):


```r
library(dplyr)
```

```
## 
## Attaching package: 'dplyr'
```

```
## The following objects are masked from 'package:stats':
## 
##     filter, lag
```

```
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
alldata <- inner_join(demo_df,cog_df,by="subject_ID")
```

Skipping ahead a little - now we can look at histograms of our numeric variables, just to see what we are dealing with:


```r
hist(cog_df$cog1)
```

<img src="01-import-your-data_files/figure-html/plot-first-histograms-1.png" width="672" />

```r
hist(cog_df$cog2)
```

<img src="01-import-your-data_files/figure-html/plot-first-histograms-2.png" width="672" />

```r
hist(cog_df$cog3)
```

<img src="01-import-your-data_files/figure-html/plot-first-histograms-3.png" width="672" />

```r
hist(demo_df$age)
```

<img src="01-import-your-data_files/figure-html/plot-first-histograms-4.png" width="672" />

Now that our data are loaded, cleaned, and merged, it is time to do some basic statistics!

---------

### STUDY QUESTION 1: What is the relationship between sex and diagnosis?

**For this question, our null hypothesis is that there is no difference in the number of males and females between our case and control diagnosis groups**

The ftable() function will give us a 2 x 2 contingency table of the frequency of observations in each category. the formula syntax "y ~ x" is common in R!


```r
ftable(data=alldata,dx~sex)
```

```
##        dx Control Case
## sex                   
## Male           37   90
## Female        127   86
```

We now want to save that table as an *object* called "dxXsex_table":


```r
dxXsex_table <- ftable(data=alldata,dx~sex)
```

Now, in order to test our null hypothesis using a chi-squared test, we simply apply the chisq.test() function to that table:


```r
chisq.test(dxXsex_table)
```

```
## 
## 	Pearson's Chi-squared test with Yates' continuity correction
## 
## data:  dxXsex_table
## X-squared = 28.415, df = 1, p-value = 9.791e-08
```

Similarly, we can use the nonparametric Fisher test to get a more exact test statistic:


```r
fisher.test(dxXsex_table)
```

```
## 
## 	Fisher's Exact Test for Count Data
## 
## data:  dxXsex_table
## p-value = 5.68e-08
## alternative hypothesis: true odds ratio is not equal to 1
## 95 percent confidence interval:
##  0.1686647 0.4567064
## sample estimates:
## odds ratio 
##   0.279488
```

*A bit more advanced!*
This will accomplish the same thing as ftable(), except that here we are *indexing* our alldata dataframe with the R syntax [<row>,<column>]. the blank value for <row> tells R that we want all rows.
The c("dx","sex") value for <columns> means we want to use the columns named "dx" and "sex". the table() function knows to arrange these as a 2 x 2 contingency table.


```r
table(alldata[ ,c("dx","sex")])
```

```
##          sex
## dx        Male Female
##   Control   37    127
##   Case      90     86
```


---------

### STUDY QUESTION 2: What is the relationship between diagnosis and cog1?

**for this question, our null hypothesis is that there is no difference in cog1 between our case and control diagnosis groups**


```r
t.test(cog1 ~ dx, data=alldata)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  cog1 by dx
## t = -6.347, df = 334.92, p-value = 7.133e-10
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.871388 -1.512676
## sample estimates:
## mean in group Control    mean in group Case 
##              9.940047             12.132079
```

```r
library(ggplot2)

ggplot(alldata, aes(x=dx, y=cog1)) + 
  geom_boxplot()
```

```
## Warning: Removed 5 rows containing non-finite values (stat_boxplot).
```

<img src="01-import-your-data_files/figure-html/first-t-t-test-1.png" width="672" />

---------

***P.S.****
Here is an R script with all of the steps we went over today!!
[Download Intro R script]( https://github.com/CAMH-SCWG/example-party/data/clean.R )
© 2018 GitHub, Inc.
Terms
Privacy
Security
Status
Help
Contact GitHub
Pricing
API
Training
Blog
About

<!--chapter:end:01-import-your-data.Rmd-->

# Explore Data with R

## Getting Started

We will be using these three datasets for the analysis today..
Please download the following files:

1. [messy_demographic.csv](data/messy_demographic.csv) 
2. [messy_cognitive.csv](data/messy_cognitive.csv)
3. [messy_genotype.csv](data/messy_genotype.csv)

----


In this lesson, we are going to start building figures and table from our data. 

We are going to do so inside an R - notebook, so we can write ourself a little tutorial/report as what we are finding as we go!!

To write a report, we will make use of R-Markdown syntax. A cheatsheet for R Markdown Syntax is [here](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf).

Add a new chunk by clicking the *Insert Chunk* button on the toolbar or by pressing *Ctrl+Alt+I*.

We are also going to make heavy use of the "tidyverse" suite of packages. These packages include:

* **ggplot2**: for plotting ([ggplot cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf))
* **dplyr** & **tidyr**: for manipulating dataframes ([data Wrangling cheat sheet](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf))
* **knitr**: for adding tables to our reports

For more info on programming with the tidyverse I highly recommend the online book [R for data science](http://r4ds.had.co.nz/) by Garrett Grolemund & Hadley Wickham.

### The packages for today


```r
library(tidyverse)
```

```
## ── Attaching packages ────────────────────────────────── tidyverse 1.2.1 ──
```

```
## ✔ ggplot2 3.1.1     ✔ purrr   0.3.2
## ✔ tibble  2.1.1     ✔ dplyr   0.8.1
## ✔ tidyr   0.8.3     ✔ stringr 1.4.0
## ✔ readr   1.3.1     ✔ forcats 0.4.0
```

```
## ── Conflicts ───────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
```

### reading in the data




```r
demo_df <- read_csv("~/Desktop/messy_demographic.csv")
cog_df <- read_csv("~/Desktop/messy_cognitive.csv")
gene_df <- read_csv("~/Desktop/messy_genotype.csv")
```

### copy and paste the cleaning code

These are all the things we learned to do in [Intro to R]("{{site.root}}/workshops/intro-R").

We are going to put them in one big chunk here.


```r
library(stringr)

demo_df[demo_df==""] <- NA
demo_df[demo_df=="missing"] <- NA
demo_df[demo_df=="9999"] <- NA
demo_df <- demo_df %>%
  mutate(age = as.numeric(age),
         ethnicity = factor(ethnicity),
         sex = factor(sex, levels = c(0,1), 
                      labels = c("Male", "Female")),
         dx = factor(dx, levels = c(0,1), 
                     labels = c("Control", "Case")))
cog_df[cog_df==""] <- NA
cog_df[cog_df=="missing"] <- NA
cog_df[cog_df=="9999"] <- NA
cog_df <- cog_df %>%
  mutate(cog1 = as.numeric(cog1),
         cog2 = as.numeric(cog2),
         cog3 = as.numeric(cog3),
         subject_ID = str_replace(subID, "subject", "SUB_")) %>%
  select(subject_ID, cog1:cog3)
gene_df[gene_df==""] <- NA
gene_df[gene_df=="missing"] <- NA
gene_df[gene_df=="9999"] <- NA
gene_df <- gene_df %>%
  mutate(genotype = factor(genotype,
                           levels=c(0,1,2), 
                           labels=c("AA","AG","GG")),
         subject_ID = str_replace(subID, "subject", "SUB_")) %>%
  select(-subID)
alldata <- demo_df %>%
  inner_join(cog_df, by="subject_ID") %>%
  inner_join(gene_df, by="subject_ID")
```

### Let's see what we have here

We can use the summary function (from base R) to get an idea of what is in our dataset.

`summary` will print some summary statistics for numeric variables are counts for our factors.


```r
summary(alldata)
```

```
##   subject_ID             age            sex      ethnicity         dx     
##  Length:350         Min.   :22.00   Male  :130   AA   : 70   Control:166  
##  Class :character   1st Qu.:43.00   Female:216   As   : 42   Case   :178  
##  Mode  :character   Median :49.00   NA's  :  4   Cauc :196   NA's   :  6  
##                     Mean   :50.38                In   : 19                
##                     3rd Qu.:58.00                Other: 14                
##                     Max.   :89.00                NA's :  9                
##                     NA's   :8                                             
##       cog1             cog2            cog3           genotype  
##  Min.   : 2.868   Min.   :20.23   Min.   :  0.05796   AA  :103  
##  1st Qu.: 8.783   1st Qu.:29.22   1st Qu.:  8.82092   AG  :145  
##  Median :10.939   Median :31.36   Median : 19.79222   GG  : 94  
##  Mean   :11.087   Mean   :31.66   Mean   : 25.04099   NA's:  8  
##  3rd Qu.:12.964   3rd Qu.:34.03   3rd Qu.: 35.55916             
##  Max.   :22.189   Max.   :44.74   Max.   :104.21326             
##  NA's   :5        NA's   :5       NA's   :9
```

## Using tableone to make Table 1 of your paper

Table one is a cool package that creates the demogaphics table. 

It takes four useful arguments
 + **data**: the data to plot
 + **vars**: the variables (from your data) to include in your table
 + **factorVars**: a list of which variables (in vars) should be treated as factors
 + **strata**: the name of a variable to split the table by.


```r
library(tableone)
CreateTableOne(alldata,
               vars = c("age", "sex",
                        "genotype","ethnicity",
                        "cog1", "cog2", "cog3"),
               factorVars = c("sex", 
                              "genotype","ethnicity"),
               strata = "dx")
```

```
##                   Stratified by dx
##                    Control       Case          p      test
##   n                  166           178                    
##   age (mean (SD))  50.42 (11.95) 50.57 (11.06)  0.905     
##   sex = Female (%)   127 (77.4)     86 (48.9)  <0.001     
##   genotype (%)                                  0.371     
##      AA               44 (27.2)     58 (33.1)             
##      AG               68 (42.0)     73 (41.7)             
##      GG               50 (30.9)     44 (25.1)             
##   ethnicity (%)                                 0.523     
##      AA               36 (22.4)     32 (18.4)             
##      As               17 (10.6)     25 (14.4)             
##      Cauc             92 (57.1)    100 (57.5)             
##      In               11 ( 6.8)      8 ( 4.6)             
##      Other             5 ( 3.1)      9 ( 5.2)             
##   cog1 (mean (SD))  9.94 (2.91)  12.13 (3.44)  <0.001     
##   cog2 (mean (SD)) 31.55 (3.88)  31.78 (3.79)   0.573     
##   cog3 (mean (SD)) 25.20 (21.76) 25.25 (20.39)  0.982
```

## Research Question 1 (two group comparison)

#### Is performance on Cognitive Scale One (cog1) associated with Diagnosis (Dx)

To test this statistically, we are going to run an independant samples t-test, using the base `t.test` function.

When we call the t.test function, we are going to use "formula" notation. we're our dependant variable goes on the left side of a `~` and the predictors go to the right
i.e. `y ~ x`.


```r
t.test(cog1 ~ dx, data = alldata)
```

```
## 
## 	Welch Two Sample t-test
## 
## data:  cog1 by dx
## t = -6.347, df = 334.92, p-value = 7.133e-10
## alternative hypothesis: true difference in means is not equal to 0
## 95 percent confidence interval:
##  -2.871388 -1.512676
## sample estimates:
## mean in group Control    mean in group Case 
##              9.940047             12.132079
```

One cool thing to remember about everything you do in R is that they generate useful objects we can save. 


```r
my_ttest_result <- t.test(cog1 ~ dx, data = alldata)
my_ttest_result$p.value
```

```
## [1] 7.13299e-10
```

### Plotting our result


```r
library(ggplot2)

ggplot(data = alldata, aes(x = dx, y = cog1)) +
  geom_boxplot()
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-9-1.png" width="672" />
#### removing NA rows before plotting

We can use tidyr's `drop_na` to remove rows with NA's in the `dx` column


```r
alldata %>% 
  drop_na(dx) %>%
  ggplot(aes(x = dx, y = cog1, fill = dx)) +
    geom_boxplot() 
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-10-1.png" width="672" />

#### Introducing the the dotplot geom

`geom_dotplot` has to be one of my favs.. Let's use it in combination with `geom_boxplot`. 

Let's also use the `labs()` call to relabel our axes with more descriptive titles. 

Note: by setting `labs(x = NULL)` we are removing the word "dx" from the bottom of the plot


```r
alldata %>% 
  drop_na(dx) %>%
  ggplot(aes(x = dx, y = cog1, fill = dx)) +
    geom_dotplot(binaxis = "y", stackdir = "center") +
    geom_boxplot(alpha = 0.5) +     # using "alpha" to make the box-plot semi-transparent
    labs(x = NULL,                  #remove dx from the bottom
         y = "Cognitive Score 1",   #add more desciptive title to y-axis
         fill = "Diagnosis")        # change dx to Diagnosis in the legend
```

<img src="02-know-your-data_files/figure-html/plot bit-1.png" width="672" />

## pretty tables with dplyr

In the section below we use two powerful tools from dplyr:

+ `summarise`: will calculate summary statistics, we are going to ask for three stats here:
   + n_age: the number of valid (i.e. not NA) values for age
   + mean_age: the mean for age (after removing NA values using the na.rm argument)
   + sd_age: the standard deviation for age after removing the NA values
+ `group_by`: will split the data by the "grouping" variable(s) you input
  + in this case we are asking for separate summary statistics for each diagnostic group, for each genotype
  
After calculating our summary table we are going to call `kable`, a function in the `knitr` package. That make the table appear nicer in our "knitted" report.

*Note*: kable has some kewl optional arguments you can use to format you table further, such as `col.names`, `digits`, and `align`. Check out `?kable` for more info..



```r
table_2 <- alldata %>%
  drop_na(dx) %>%
  group_by(dx,genotype) %>%
  summarise(n_age = sum(!is.na(age)), #the total number of observations that are NOT NA
            mean_age = mean(age, na.rm = T),
            sd_age = sd(age, na.rm = T))
```

```
## Warning: Factor `genotype` contains implicit NA, consider using
## `forcats::fct_explicit_na`
```

```r
library(knitr)
kable(table_2)
```



dx        genotype    n_age   mean_age      sd_age
--------  ---------  ------  ---------  ----------
Control   AA             43   52.00000   10.574002
Control   AG             66   49.92424   11.024882
Control   GG             50   49.94000   14.217566
Control   NA              4   47.50000   12.476645
Case      AA             57   55.08772   10.554756
Case      AG             71   48.61972   10.355628
Case      GG             43   48.37209   11.176129
Case      NA              2   38.00000    9.899495

## use forcats to label risk_carriers

When working with a genotype of interest, it's very common group participants into "carriers" and "non-carriers" of a risk-allele. In this dataset, our risk allele is the "G" genotype. We will create a new "risk_carrier" variable by combining levels of the genotype variable.

Working with factors in R can be...annoying. Especially when we want to create new factors out of old factors. For this reason, the tidyverse includes a `forcats` package. That includes many function (all starting with `fct_`) for doing stuff to factors. We will use `fct_collapse` to combine the "GG" and "AG" genotype factors into a new "carrier" level in a new factor.


```r
library(forcats)
alldata <- alldata %>%
  mutate(risk_carrier = fct_collapse(genotype,
                                     carrier = c("GG", "AG"),
                                     non_carrier = "AA"))
```

## Make a simple scatter plot

Let's use `geom_point()` and `geom_smooth`, together to create a scatter plot with a trendline.

*Note:* to make the trendline straight, we use "method = lm" when calling geom_smooth().


```r
alldata %>%
  ggplot(aes(x = age, y = cog1)) +
    geom_point() + 
    geom_smooth(method = "lm") 
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-13-1.png" width="672" />

## Use plotting to show the age by risk carrier interaction

When we add a new mapping of `color = risk_carrier` to the top line of our plot this mapping applies to *both* the points and the trendline. 

*Note:* we are using `drop_na` to remove the NA as a category so that it does not occur as a third color in our plot.


```r
alldata %>%
  drop_na(risk_carrier) %>%
  ggplot(aes(x = age, y = cog1, color = risk_carrier)) +
    geom_point() + 
    geom_smooth(method = "lm") 
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-14-1.png" width="672" />

We can use faceting to add and extra dimension - separate plots for male and female subjects.


```r
alldata %>%
  drop_na(risk_carrier,sex) %>%
  ggplot(aes(x = age, y = cog1, color = risk_carrier)) +
    geom_point() + 
    geom_smooth(method = "lm") +
    facet_wrap(~sex)
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-15-1.png" width="672" />

`facet_grid` will allow us to facet by TWO variables. In this case sex and dx.


```r
alldata %>%
  dplyr::filter(!is.na(risk_carrier), !is.na(sex), !is.na(dx)) %>%
  ggplot(aes(x = age, y = cog1, color = risk_carrier)) +
    geom_point() + 
    geom_smooth(method = "lm") +
    facet_grid(dx~sex)
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-16-1.png" width="672" />

## BONUS section - gather cognitive scores into one plot

One things we want to do sometimes is to stack data from multiple columns in one column. The reason why this is useful, will hopefully become apparent in the next example.

This "stacking" task (also refered to as "melting") is accomplished using `gather` from the `tidyr` package. `gather` creates two new columns from your data: "key" and "value".
 + **key**: a new column that will hold the old variable names from the gathered data
 + **value**: a new column that will hold the data values

After the **key** and **value** arguments. We can tell `gather` what colums we want to stack using the same syntax used by dplyr's `select()`. In this example, we tell it we want to gather our three cognitive scales using `starts_with()`.


```r
library(tidyr)
alldata %>% 
  gather(cog_scale, cognitive_score, starts_with("cog"))
```

```
## # A tibble: 1,050 x 9
##    subject_ID   age sex   ethnicity dx    genotype risk_carrier cog_scale
##    <chr>      <dbl> <fct> <fct>     <fct> <fct>    <fct>        <chr>    
##  1 SUB_1         43 Male  Cauc      Cont… GG       carrier      cog1     
##  2 SUB_2         47 Fema… Cauc      Case  AG       carrier      cog1     
##  3 SUB_3         69 Fema… Cauc      Case  AA       non_carrier  cog1     
##  4 SUB_4         51 Male  Cauc      Case  GG       carrier      cog1     
##  5 SUB_5         52 Fema… Cauc      Cont… AA       non_carrier  cog1     
##  6 SUB_6         71 Male  AA        Case  AA       non_carrier  cog1     
##  7 SUB_7         56 Fema… Cauc      Case  AA       non_carrier  cog1     
##  8 SUB_8         35 Fema… <NA>      Cont… GG       carrier      cog1     
##  9 SUB_9         42 Fema… Cauc      Cont… AG       carrier      cog1     
## 10 SUB_10        45 Fema… Other     Case  <NA>     <NA>         cog1     
## # … with 1,040 more rows, and 1 more variable: cognitive_score <dbl>
```

The beauty of gather is that it can be combined with other the rest of the tidyverse using the pipe. Let's feed out gathered result to ggplot.

*Note:* using `scales = "free"` when faceting will force ggplot to draw a separate axis for each subplot (by default, `scales = "fixed"`, meaning that the same axes are drawn for each plot).


```r
alldata %>%
  gather(cog_scale, cognitive_score, starts_with("cog")) %>%
  drop_na(risk_carrier, dx) %>%
  ggplot(aes(x = age, y = cognitive_score, color = risk_carrier)) +
    geom_point() + 
    geom_smooth(method = "lm") +
    facet_wrap(~cog_scale, scales = "free")  
```

<img src="02-know-your-data_files/figure-html/unnamed-chunk-18-1.png" width="960" />

<!--chapter:end:02-know-your-data.Rmd-->

# Stats (Linear Models)

Please download the following files:


1. [messy_demographic.csv](data/messy_demographic.csv) 
2. [messy_cognitive.csv](data/messy_cognitive.csv)
3. [messy_genotype.csv](data/messy_genotype.csv)

----



We need 'rms', 'ggplot2', and 'car' packages
If you haven't already installed these:

Load the packages


```r
library(tidyverse)
library(dplyr)
library(tidyr)
library(broom)
library(readr)
```


#### p.s. today we are going to use the "pipe" `%>%`

`%>%` is the pipe 
The pipe takes the data from the left of if and feeds it to the function on the next line. Below are two ways for writing the same command.


```r
select(alldata, cog1:cog3)
alldata %>% 
  select(cog1:cog3)
```

## Set up (Running Intro to R commands)

*Note: we're going to use `read_csv()` from the `readr` package instead of base R's read.csv because it is a little more robust.*



```r
messy_demographic <- read_csv("~/Downloads/messy_demographic.csv")  # put in the location of the downloaded data file 1
messy_cognitive <- read_csv("~/Downloads/messy_cognitive.csv")  # put in the location of the downloaded data file 2
data3 <- read_csv("~/Downloads/messy_genotype.csv")
```


```
## Parsed with column specification:
## cols(
##   subject_ID = col_character(),
##   age = col_character(),
##   sex = col_double(),
##   ethnicity = col_character(),
##   dx = col_character()
## )
```

```
## Parsed with column specification:
## cols(
##   subID = col_character(),
##   cog1 = col_character(),
##   cog2 = col_character(),
##   cog3 = col_character()
## )
```

```
## Parsed with column specification:
## cols(
##   subID = col_character(),
##   genotype = col_character()
## )
```

The data should be merged and ready to go from day 1. If not, here's the code for it:
Copied from [here](https://camh-scwg.github.io/compucool-may-2017/workshops/stats_with_R)


```r
## I'm using require, it's actually pretty much the same thing as "library"
require(dplyr)
require(stringr)
require(readr)
## we know that we need we have a same missing value issues in all three dataframes
## to avoid copying and pasting 3 times let's set them to a function
recode_missing <- function(df) {
  df[df==""] <- NA
  df[df=="missing"] <- NA
  df[df=="9999"] <- NA
  df[df==9999] <- NA
  return(df)
}
## pipeping messy demographic to the function we made
## then defining the factors inside a call to mutate
## note I use readr::parse_number(), which less error prone version of as.numeric() 
clean_demographic <- messy_demographic %>%
  recode_missing() %>%
  mutate(age = parse_number(age),
         ethnicity = factor(ethnicity,
                            levels=c("Cauc","AA","As","In","Other")),
         sex = factor(sex, levels = c(0,1),
                            labels = c("Male","Female")),
         dx = factor(dx, levels=c(0,1), 
                           labels=c("Control","Case")))
## recoding missing values in using out hand made recode_missing function
## then I use dplyr mutate_at to convert all 3 cog vars to a number
clean_cognitive <- messy_cognitive %>%
  recode_missing() %>%
  mutate_at(vars(cog1:cog3), funs(parse_number(.)))
```

```
## Warning: funs() is soft deprecated as of dplyr 0.8.0
## please use list() instead
## 
##   # Before:
##   funs(name = f(.))
## 
##   # After: 
##   list(name = ~ f(.))
## This warning is displayed once per session.
```

```r
## recode and set genotype to a factor
clean_genotype <- messy_genotype %>%
  recode_missing() %>%
  mutate(genotype = factor(genotype, 
                           levels=c(0,1,2), 
                           labels=c("AA","AG","GG")))
## use stringr to make the subject IDs match
## use dplyr's inner_join to put all three together
## use select to remove the extra column and put "subID" as the first column
alldata <- clean_demographic %>%
  mutate(subID = str_replace(subject_ID, "SUB_", "subject")) %>%
  inner_join(clean_cognitive, by = "subID") %>%
  inner_join(clean_genotype, by = "subID") %>%
  select(subID, everything(), -subject_ID)
## remove the intermediate data from your workspace
rm(messy_demographic, messy_cognitive, messy_genotype,
   clean_genotype, clean_cognitive, clean_demographic)
```

## A very fast stats refresher!!

### what stat function do I need??

For today, we are going to focus on what are called "parametric" statistics. We can spend a semester (and many people do) describing the uses of different statistical tests. However today, to pick the "best" statistical test there are two real questions:

1. What type of data is my dependant variable ("y")?
2. What type of data is my independant/predictor variable ("x")?

|               |        |**Dependant Variable (y)**                          |
|---------------|--------|----------------------------|-----------------------|
|               |        |*Factor*                    |*Numeric*              |
|**Independant (x)**| *Factor*    | Chi-Squared `chisq.test(ftable(y~x))`| t-test`t.test(y~x)` OR ANOVA `anova(lm(y~x))`|
|                   |*Numeric*    |Logistic Regression `glm(y~x,family=binomial())` | Correlation`cor.test(y~x)` OR Regression `lm(y ~ x)` |
|                   |*Combination (or multiple)* |Logistic Regression `glm(y~x1 + x2,family=binomial())`| Multiple Regression `lm(y ~ x1 + x2)`|

This table is generally works, UNLESS:

1. Your data is not normally distributed (we will test for that later...).
    + is this is an issue..you will need to enter the land of non-parametric statistics
2. Your data is not "independant", in other words you have a "repeated-measures design"
    + you might need a *paired t.test* or *repeated measures ANOVA*
3. You have more than one dependant variable. 
    + Then you need to enter the realm of multivariate statistics.. 

There are tools for all of this in R.  But I will not go into them during this tutorial

**Most of what we want to do, we can do with the linear model (`lm`)**

## Looking at Cognition 2 vs Age

The linear model function in R (`lm`), like many stats functions in R, uses *formula notation*, where you describe you dependant and independant variables, separated by a tilda `~`.

Let's take an example where we want to predict the scores on cognitive scale 2 using our age variable.

In the next chuck we create a *linear model fit* object. An then call summary on that object.


```r
fit_cog2_age <-lm(cog2 ~ age, data = alldata) # creates lm "fit" object
summary(fit_cog2_age)                         # prints a summary report of the fit
```

```
## 
## Call:
## lm(formula = cog2 ~ age, data = alldata)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -9.8482 -1.9839 -0.0404  1.5766  8.7988 
## 
## Coefficients:
##             Estimate Std. Error t value Pr(>|t|)    
## (Intercept) 20.85385    0.72780   28.65   <2e-16 ***
## age          0.21359    0.01405   15.20   <2e-16 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 2.947 on 335 degrees of freedom
##   (13 observations deleted due to missingness)
## Multiple R-squared:  0.4083,	Adjusted R-squared:  0.4065 
## F-statistic: 231.1 on 1 and 335 DF,  p-value: < 2.2e-16
```

## Using `broom` to save/organize model fit numbers

The best part about running stats in R, in contrast to running your stats in some other "point and click" interface. I that your statistical results (i.e. you test stats, residuals, p values) can all be saved into objects that you can later format into tables, plot, print directly into your report...This is very powerful.

Statistical result objects can be tough to work with. The `broom` package extract numbers from statistical fit results into dataframes that are easier to work with.

### `augment` grabs residuals and predicted values


```r
cogbyage_aug <- alldata %>%
  do(augment(lm(cog2~age,data = .)))
head(cogbyage_aug)
```

```
## # A tibble: 6 x 10
##   .rownames  cog2   age .fitted .se.fit  .resid    .hat .sigma .cooksd
##   <chr>     <dbl> <dbl>   <dbl>   <dbl>   <dbl>   <dbl>  <dbl>   <dbl>
## 1 1          28.8    43    30.0   0.192 -1.22   0.00426   2.95 3.66e-4
## 2 2          37.5    47    30.9   0.168  6.58   0.00325   2.93 8.15e-3
## 3 3          37.7    69    35.6   0.305  2.14   0.0107    2.95 2.88e-3
## 4 4          31.7    51    31.7   0.161 -0.0801 0.00297   2.95 1.10e-6
## 5 5          31.4    52    32.0   0.162 -0.546  0.00302   2.95 5.21e-5
## 6 6          36.1    71    36.0   0.329  0.0370 0.0125    2.95 1.01e-6
## # … with 1 more variable: .std.resid <dbl>
```

### `tidy` grabs to middle table (beta's and t-stats)


```r
cogbyage_tidy <- alldata %>%
  do(tidy(lm(cog2~age,data = .)))
cogbyage_tidy
```

```
## # A tibble: 2 x 5
##   term        estimate std.error statistic  p.value
##   <chr>          <dbl>     <dbl>     <dbl>    <dbl>
## 1 (Intercept)   20.9      0.728       28.7 4.09e-92
## 2 age            0.214    0.0140      15.2 4.59e-40
```

### `glance` grabs to full model stats 


```r
cogbyage_glance <- alldata %>%
  do(glance(lm(cog2~age,data = .)))
cogbyage_glance
```

```
## # A tibble: 1 x 11
##   r.squared adj.r.squared sigma statistic  p.value    df logLik   AIC   BIC
##       <dbl>         <dbl> <dbl>     <dbl>    <dbl> <int>  <dbl> <dbl> <dbl>
## 1     0.408         0.407  2.95      231. 4.59e-40     2  -841. 1689. 1700.
## # … with 2 more variables: deviance <dbl>, df.residual <int>
```

## Example: printing our formatted t

### now that things are nicely organized we can built tables for our publications, compare across models, and print results to our report 


```r
my_t_stat <- cogbyage_tidy %>%
  dplyr::filter(term == "age") %>%
  select(statistic) %>%
  round(.,2) ## round to 2 decimal places
print(my_t_stat)
```

```
## # A tibble: 1 x 1
##   statistic
##       <dbl>
## 1      15.2
```

### Printing a result to our report

The following line:
We observe a significant relationship between age adn cognitive scale 2 (t = 15.2, p = 4.5927599\times 10^{-40})

was written in markdown as:

```
We observe a significant relationship between age adn cognitive scale 2 (t = 15.2, p = 4.5927599\times 10^{-40})
```

## plotting distributions

### Using ggplot to plot a histogram of cognition score 1


```r
ggplot(alldata, aes(x=cog1)) + geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## Warning: Removed 5 rows containing non-finite values (stat_bin).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-11-1.png" width="672" />

### Using a combination of "gather" and ggplot to plot all three scores in one plot


```r
alldata %>%
  gather(cognitive_scale, cognitive_score, 
         cog1:cog3) %>%
  ggplot(aes(x = cognitive_score)) +
    geom_histogram() +
    facet_wrap(~cognitive_scale, scales = "free")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## Warning: Removed 19 rows containing non-finite values (stat_bin).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-12-1.png" width="672" />

## Transforming variables to "normal"

From the histogram above.. It looks like `cog3` is not normally distributed. This is a problem because it violates "the assumption of normally", and therefore parametric tests (i.e. the linear model) should not be run in this case.

One solution to this problem is to transform this variable into normally distributed variables, and then do the stats on those.

Let's use `dplyr`'s `mutate` function to calculate a log (i.e. log10) and square-root transform (`sqrt`).


```r
alldata <- alldata %>%
  mutate(cog3_log  = log(cog3),
         cog3_sqrt = sqrt(cog3))
```

Let's plot histograms of these new values


```r
alldata %>%
  gather(cognitive_scale, cognitive_score, 
         cog3_log, cog3_sqrt) %>%
  ggplot(aes(x = cognitive_score)) +
    geom_histogram() +
    facet_wrap(~cognitive_scale, scales = "free")
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## Warning: Removed 18 rows containing non-finite values (stat_bin).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-14-1.png" width="672" />

## Using "power transform" from the `car` library

The people behind the `car` library decided to use their computer's to find the perfect transform!

The function `powerTransform` magically finds the perfect transform!




```r
library(car)
```

```
## Loading required package: carData
```

```
## 
## Attaching package: 'car'
```

```
## The following object is masked from 'package:dplyr':
## 
##     recode
```

```
## The following object is masked from 'package:purrr':
## 
##     some
```

```r
# calculate the best exponent using powerTransform:
pT <- powerTransform(alldata$cog3)
# apply the power transform and save the result to a new variable
alldata$cog3_powerT <- alldata$cog3^pT$lambda ## note ^ is exponent in r
```

Using `powerTransform` is a little tricky (it requires two steps). When things get tricky in R, it's nice to wrap what you want to do inside a function. That way, you can call the function instead of remembering all the steps next time you want to do something!


```r
## run the power transform, return the transformed variable
## where x is a vector of values
get_pT <- function(x) {
 pT <- x^powerTransform(x)$lambda
 return(pT)
}
alldata <- alldata %>%
  mutate(cog3_pT = get_pT(cog3))
ggplot(alldata, aes(x=cog3_pT)) + geom_histogram()
```

```
## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.
```

```
## Warning: Removed 9 rows containing non-finite values (stat_bin).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-16-1.png" width="672" />

## Recodeding our genotype into risk-allele carriers vs non-carriers


```r
summary(alldata$genotype)
```

```
##   AA   AG   GG NA's 
##  103  145   94    8
```


```r
library(forcats)
alldata <- alldata %>%
  mutate(risk_carrier = fct_recode(genotype,
                                   carrier = "GG",
                                   carrier = "AG",
                                   non_carrier = "AA"))
```


## Investigating Interactions 

### fitting our data with an age by risk-carrier interaction

The concept of statistical interaction goes by many names and has many definitions.  Simply this is the concept that the effect of one variable changes depending on the value of another variable. 

Interaction is indicated in R formula syntax with a ":" or `*`, depending on if you want to automatically include the main effects of your interacting variables or not. As a general rule, always use `*`.


```r
fit2 <- lm(cog1 ~ age*risk_carrier, data = alldata)
summary(fit2)
```

```
## 
## Call:
## lm(formula = cog1 ~ age * risk_carrier, data = alldata)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -7.9601 -1.9774 -0.0874  1.6888 12.2729 
## 
## Coefficients:
##                         Estimate Std. Error t value Pr(>|t|)    
## (Intercept)              9.18323    1.61921   5.671 3.12e-08 ***
## age                      0.06365    0.02967   2.145 0.032678 *  
## risk_carriercarrier      4.31736    1.85584   2.326 0.020611 *  
## age:risk_carriercarrier -0.12545    0.03468  -3.617 0.000345 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 3.164 on 326 degrees of freedom
##   (20 observations deleted due to missingness)
## Multiple R-squared:  0.1272,	Adjusted R-squared:  0.1191 
## F-statistic: 15.83 on 3 and 326 DF,  p-value: 1.234e-09
```


```r
alldata %>%
  drop_na(risk_carrier) %>%
ggplot(aes(x = age, y = cog1, color = risk_carrier)) +
  geom_point() +
  geom_smooth(method = "lm")
```

```
## Warning: Removed 12 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 12 rows containing missing values (geom_point).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-20-1.png" width="672" />

### Plotting all three cognitve variables at once!


```r
alldata %>%
  gather(cognitive_scale, cognitive_score, 
         cog1, cog2, cog3_pT) %>%
  drop_na(risk_carrier) %>%
  ggplot(aes(y = cognitive_score, x = age, color = risk_carrier)) +
    geom_point() +
    geom_smooth(method = "lm") +
    facet_wrap(~cognitive_scale, scales = "free")
```

```
## Warning: Removed 40 rows containing non-finite values (stat_smooth).
```

```
## Warning: Removed 40 rows containing missing values (geom_point).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-21-1.png" width="960" />

### Running our linear model on all three cognitive variables at once!


```r
lm_results <- alldata %>%
  gather(cognitive_scale, cognitive_score, 
         cog1, cog2, cog3_pT) %>%
  drop_na(risk_carrier) %>%
  group_by(cognitive_scale) %>%
  do(tidy(lm(cognitive_score ~ age*risk_carrier, data = .)))
library(knitr)
kable(lm_results %>%
  select(cognitive_scale, term, statistic, p.value) %>%
    arrange(p.value))
```



cognitive_scale   term                        statistic     p.value
----------------  ------------------------  -----------  ----------
cog2              (Intercept)                14.1811015   0.0000000
cog2              age                         7.1325824   0.0000000
cog3_pT           (Intercept)                 5.9003102   0.0000000
cog1              (Intercept)                 5.6714248   0.0000000
cog1              age:risk_carriercarrier    -3.6168948   0.0003454
cog1              risk_carriercarrier         2.3263728   0.0206113
cog1              age                         2.1451691   0.0326778
cog2              age:risk_carriercarrier     0.7207797   0.4715616
cog2              risk_carriercarrier        -0.6541716   0.5134625
cog3_pT           risk_carriercarrier         0.5955776   0.5518758
cog3_pT           age:risk_carriercarrier    -0.4754718   0.6347731
cog3_pT           age                         0.0187474   0.9850542

## use p.adjust to correct for multiple comparisons


```r
age_effects <- lm_results %>%
  dplyr::filter(term == "age")
age_effects$p.FDR <- p.adjust(age_effects$p.value, method = "fdr")
kable(age_effects)
```



cognitive_scale   term     estimate   std.error   statistic     p.value       p.FDR
----------------  -----  ----------  ----------  ----------  ----------  ----------
cog1              age     0.0636475   0.0296701   2.1451691   0.0326778   0.0490167
cog2              age     0.1986365   0.0278492   7.1325824   0.0000000   0.0000000
cog3_pT           age     0.0001522   0.0081193   0.0187474   0.9850542   0.9850542

## BONUS SECTION: using `rms` to get more details

When you want more detailed info out of your models. The `rms` library can be very useful.


#### total_behaviour_score ~ age 
 
Calculate a composite variable by combining multiple variables
Note: new variables can be made easily (using dplyr's mutate verb)


```r
alldata$totalcog <- (alldata$cog1 + alldata$cog3) / alldata$cog2
```


Simple linear regression (two ways: base package and rms)


```r
library(rms)
```

```
## Loading required package: Hmisc
```

```
## Loading required package: lattice
```

```
## Loading required package: survival
```

```
## Loading required package: Formula
```

```
## 
## Attaching package: 'Hmisc'
```

```
## The following objects are masked from 'package:dplyr':
## 
##     src, summarize
```

```
## The following objects are masked from 'package:base':
## 
##     format.pval, units
```

```
## Loading required package: SparseM
```

```
## 
## Attaching package: 'SparseM'
```

```
## The following object is masked from 'package:base':
## 
##     backsolve
```

```
## 
## Attaching package: 'rms'
```

```
## The following objects are masked from 'package:car':
## 
##     Predict, vif
```

```r
lm.base <- lm(data=alldata, totalcog ~ age)
lm.rms <- ols(data=alldata, totalcog ~ age)
```

Let's compare the output's


```r
lm.base
```

```
## 
## Call:
## lm(formula = totalcog ~ age, data = alldata)
## 
## Coefficients:
## (Intercept)          age  
##     1.78587     -0.01219
```

```r
summary(lm.base)
```

```
## 
## Call:
## lm(formula = totalcog ~ age, data = alldata)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -1.0529 -0.5054 -0.1940  0.4352  2.3720 
## 
## Coefficients:
##              Estimate Std. Error t value Pr(>|t|)    
## (Intercept)  1.785875   0.172793  10.335  < 2e-16 ***
## age         -0.012192   0.003346  -3.644 0.000313 ***
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 0.6966 on 322 degrees of freedom
##   (26 observations deleted due to missingness)
## Multiple R-squared:  0.03961,	Adjusted R-squared:  0.03663 
## F-statistic: 13.28 on 1 and 322 DF,  p-value: 0.0003125
```

```r
anova(lm.base)
```

```
## Analysis of Variance Table
## 
## Response: totalcog
##            Df  Sum Sq Mean Sq F value    Pr(>F)    
## age         1   6.445  6.4446   13.28 0.0003125 ***
## Residuals 322 156.259  0.4853                      
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

**Note**: to make the most out of rms package functionality, we need to store summary stats using the datadist() function. That way, when we call summary() on an ols() object (we just made one called "lm.rms") it will give us useful info. 


```r
dd.alldata <- datadist(alldata)
options(datadist="dd.alldata")
lm.rms
```

```
## Frequencies of Missing Values Due to Each Variable
## totalcog      age 
##       18        8 
## 
## Linear Regression Model
##  
##  ols(formula = totalcog ~ age, data = alldata)
##  
##  
##                 Model Likelihood     Discrimination    
##                    Ratio Test           Indexes        
##  Obs     324    LR chi2     13.09    R2       0.040    
##  sigma0.6966    d.f.            1    R2 adj   0.037    
##  d.f.    322    Pr(> chi2) 0.0003    g        0.160    
##  
##  Residuals
##  
##      Min      1Q  Median      3Q     Max 
##  -1.0529 -0.5054 -0.1940  0.4352  2.3720 
##  
##  
##            Coef    S.E.   t     Pr(>|t|)
##  Intercept  1.7859 0.1728 10.34 <0.0001 
##  age       -0.0122 0.0033 -3.64 0.0003  
## 
```

```r
summary(lm.rms)
```

```
##              Effects              Response : totalcog 
## 
##  Factor Low High Diff. Effect   S.E.     Lower 0.95 Upper 0.95
##  age    43  58   15    -0.18288 0.050183 -0.28161   -0.084151
```

```r
anova(lm.rms)
```

```
##                 Analysis of Variance          Response: totalcog 
## 
##  Factor     d.f. Partial SS MS        F     P    
##  age          1    6.444638 6.4446382 13.28 3e-04
##  REGRESSION   1    6.444638 6.4446382 13.28 3e-04
##  ERROR      322  156.258677 0.4852754
```

Visualize predicted results using rms

```r
plot(Predict(lm.rms))
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-28-1.png" width="672" />

## ols gets more powerful as the model get's more complicated

This is were we start to add covariates and do multiple regression


```r
lm3 <- ols(data=alldata, cog1 ~ age*risk_carrier + sex )
lm3
```

```
## Frequencies of Missing Values Due to Each Variable
##         cog1          age risk_carrier          sex 
##            5            8            8            4 
## 
## Linear Regression Model
##  
##  ols(formula = cog1 ~ age * risk_carrier + sex, data = alldata)
##  
##  
##                 Model Likelihood     Discrimination    
##                    Ratio Test           Indexes        
##  Obs     326    LR chi2     49.39    R2       0.141    
##  sigma3.1587    d.f.            4    R2 adj   0.130    
##  d.f.    321    Pr(> chi2) 0.0000    g        1.432    
##  
##  Residuals
##  
##       Min       1Q   Median       3Q      Max 
##  -7.61165 -2.06275 -0.03454  1.86219 11.69825 
##  
##  
##                             Coef    S.E.   t     Pr(>|t|)
##  Intercept                   9.7644 1.6478  5.93 <0.0001 
##  age                         0.0622 0.0299  2.08 0.0386  
##  risk_carrier=carrier        4.3775 1.8678  2.34 0.0197  
##  sex=Female                 -0.8926 0.3636 -2.45 0.0146  
##  age * risk_carrier=carrier -0.1251 0.0349 -3.59 0.0004  
## 
```

```r
anova(lm3)
```

```
##                 Analysis of Variance          Response: cog1 
## 
##  Factor                                            d.f. Partial SS
##  age  (Factor+Higher Order Factors)                  2   165.95975
##   All Interactions                                   1   128.34287
##  risk_carrier  (Factor+Higher Order Factors)         2   432.58671
##   All Interactions                                   1   128.34287
##  sex                                                 1    60.13082
##  age * risk_carrier  (Factor+Higher Order Factors)   1   128.34287
##  REGRESSION                                          4   523.84580
##  ERROR                                             321  3202.66179
##  MS        F     P     
##   82.97987  8.32 0.0003
##  128.34287 12.86 0.0004
##  216.29335 21.68 <.0001
##  128.34287 12.86 0.0004
##   60.13082  6.03 0.0146
##  128.34287 12.86 0.0004
##  130.96145 13.13 <.0001
##    9.97714
```

```r
summary(lm3)
```

```
##              Effects              Response : cog1 
## 
##  Factor                             Low High Diff. Effect   S.E.   
##  age                                43  58   15    -0.94428 0.26908
##  risk_carrier - non_carrier:carrier  2   1   NA     1.75290 0.41015
##  sex - Male:Female                   2   1   NA     0.89259 0.36358
##  Lower 0.95 Upper 0.95
##  -1.47370   -0.41489  
##   0.94596    2.55980  
##   0.17728    1.60790  
## 
## Adjusted to: age=49 risk_carrier=carrier
```


## BONUS SECTION 2 - the "right" way to plot....

**How to visualize a significant effect from our regression...Controlling for the other variables in the model....**
 
To visualize a given effect more informatively, we want to caculate the residuals of the model lacking our co-varitate of interest and plot those residuals as our outcome:

For genotype we want a boxplot of model residuals:


```r
lm3.plot <- ols(data=alldata, cog1 ~ genotype + age)
ggplot(data=alldata, aes(y=resid(lm3.plot), x=sex)) + 
  geom_boxplot()
```

```
## Warning: Removed 20 rows containing non-finite values (stat_boxplot).
```

<img src="03-linear-models_files/figure-html/unnamed-chunk-30-1.png" width="672" />

<!--chapter:end:03-linear-models.Rmd-->


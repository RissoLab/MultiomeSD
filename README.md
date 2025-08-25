# About this repository

This repository is part of the paper **Sleep deprivation induces 3D chromatin reorganization in CA1 pyramidal glutamatergic neurons with altered responses in Shank3 mutant mice**

## Repository Organization

This repository is organized in two main section,

1.  The website section at [this link](https://rissolab.github.io/MultiomeSD/), with all the compiled code organized as **Articles**.

2.  The code section at this [link](https://github.com/RissoLab/MultiomeSD), where it is possible to find all the *code* used to generate the articles found in the Articles section.
    In some cases, because some of the steps are time demanding the code is reported, but not live executed.

In particular: 

-   The `Vignettes` folder contains all the designed code for the data processing.

-   The `R` folder contains additional support R code needed to generate some plots and to process some data structures.

-   The `Dockerfile` in the main branch allows to re-create the R environment with all the packages and the exact same versions used during the analysis.
    (See additional instructions below)

-   The `inst/preprocessing` folder contains all the code (MAKEFILE(s)) and additional files to process raw data with 10x cellranger ARC (see `Data Loading` article in the [related website](https://rissolab.github.io/MultiomeSD/)).

## Paper Authors:

Dominika Vojtasova1,2,\*, Dario Righelli3,a,\*, Christoph Thieme1,§, Alexander Kukalev1,§, Dominik Szabó1,2, Michael Cooney4, Liam Speakman4, Elizabeth Medina5, Kaitlyn Ford5, Caitlin Ottaway5, Kristan Singletary5, Izabela Harabula1,2, Ibai Irastorza-Azcarate1, Elena Zuin6, Lonnie Welch4,#, Davide Risso3,#, Lucia Peixoto5,#, Ana Pombo1,2,7,8,#

1 Max-Delbrück-Center for Molecular Medicine, Berlin Institute for Medical Systems Biology, Epigenetic Regulation and Chromatin Architecture Group, Berlin, Germany.

2 Humboldt University of Berlin, Berlin, Germany.

3 Department of Statistical Sciences, University of Padova, Padova, Italy.

4 School of Electrical Engineering and Computer Science, Ohio University, Athens, OH, USA 

5 Department of Translational Medicine and Physiology, Sleep and Performance Research Center, Elson S. Floyd College of Medicine, Washington State University, Spokane, WA, USA.

6 Department of Biology, University of Padova, Padova, Italy.

7 Department of Biology, Johns Hopkins University, Baltimore, MD, USA.

8 Department of Molecular Biology and Genetics, Johns Hopkins University School of Medicine, Baltimore, MD, USA

Present address: 

a Dario Righelli: Department of Electrical Engineering and Information Technology, University of Naples “Federico II”, Naples, Italy 

b Kaitlyn Ford: Center for Developmental Biology and Regenerative Medicine, Seattle Children’s Research Institute, USA

\* equal first authors, § equal third authors, \# co-corresponding

## Paper Abstract

Sleep disorders, which lead to sleep deprivation (SD), co-occur with neurological conditions and negatively impact the quality of life of individuals and caregivers.
SD affects different brain regions, but its influence on different hippocampal cell types and on different levels of gene regulation remain unknown.
Here, we investigated SD effects on gene expression, chromatin accessibility and 3D genome topology in the adult mouse hippocampus with single-cell resolution.
We identify CA1-dorsal pyramidal glutamatergic neurons as the most affected cell type.
We show that SD induces widespread changes in 3D genome structure, including at many genes involved in synaptic pathways, including excitation-inhibition balance, and in neurodevelopmental disorders.
Using Shank3∆C mutant mice, an autism model that recapitulates insomnia, we reveal altered SD responses affecting specific genes and pathways.
These findings identify candidate genes that drive SD-induced homeostatic changes, providing foundations for understanding sleep function and sleep-neurological disorder links.

# Introduction

Here we provide the code and insights to reproduce the entire analysis of the 10x-Genomics Multiome dataset specifically performed to test sleep deprivation effect on brain.

The experimental design it's on mouse specie and consists of two genotypes Wild Types and Shank3 DeltaC Knock Out.
Each genotype has two different conditions Sleep Deprived and Home Cage Controls, each of three different biological replicates, for a total of 12 samples.

Brain Samples have been collected for each individual and 10x-Genomics Multiome library preparation has been performed to obtain single nuclei ATAC and Gene Expression.

This analysis is aimed to investigate global effects of sleep deprivation (SD) on the brain with a focus on the CA1 dorsal section, which, in our analysis, resulted to be the most affected brain area by this condition.

# Docker

Together with the website in the github repository, we share a Docker file that can be used to reproduce the entire analysis with the exact same R package versions used for the analysis.

In detail, the Docker is build on the Docker image of Bioconductor release version 3.18, and extended with the needed packages.

A set of specifically developed packages (on github) is needed and provided for the analysis:

-   [AllenInstituteBrainData](https://github.com/drighelli/AllenInstituteBrainData): a package based on the Allen Institute Mouse Brain Data.
    It provides the annotation for the whole Mouse brain as realeased in 2020.

-   [TENxMultiomeTools](https://github.com/drighelli/TENxMultiomeTools): a package for the Quality Control of 10x-Genomics multiome data.

## Running the docker

Main steps for running the docker:

1.  Download the Dockerfile present at this [link](https://github.com/RissoLab/MultiomeSD/Dockerfile).

2.  In a terminal, place yourself in the same folder where the Dockerfile is present.

3.  Compile it with the `docker build -t multiome_sleep`. Once completed, check the list of dockers with the `docker images` command.

4.  Run the docker with `docker run multiome_sleep`.

5.  Once running, navigate to http://localhost:8787/ in your browser and login with username `rstudio` and password `bioc`.


# Data Availability

Sequencing data have been deposited in NCBI’s Gene Expression Omnibus (GEO) under the accession number GSE286323.


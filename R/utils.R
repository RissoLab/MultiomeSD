reshapeSEDEscan2 <- function(se, details=NULL)
{
    require("SummarizedExperiment")
    stopifnot(is(se, "SummarizedExperiment"))
    names(assays(se)) <-"counts"
    se$Sample <- gsub("_CA1-do.bam|_CA1-do_sorted.bam", "", basename(se$readsFiles))
    rc <- strsplit(basename(se$readsFiles), "_")
    se$condition <- unlist(lapply(rc, function(c) c[2]))
    se$replicate <- unlist(lapply(rc, function(r) r[1]))
    se$cellType <- "CA1-do"
    se$genotype <- "WT"
    se$genotype[grep("S3", se$condition)] <- "KO"
    sd <- grep("SD", se$condition)
    se$condition <- "CTRL"
    se$condition[sd] <- "SD"
    se$gcondition <- paste(se$genotype, se$condition, sep="_")
    if(!is.null(details)) rowData(se)$details <- details
    colnames(se) <- se$Sample
    rownames(se) <- paste0(seqnames(rowRanges(se)), ":", 
                           start(rowRanges(se)), "-", 
                           end(rowRanges(se)))
    return(se)
}




buildTab <- function(scelist)
{
    tablist <- lapply(scelist, function(sce){
        tab <- data.frame(Nuclei=as.numeric(metadata(sce)$n_nuclei),
                          Genes=dim(sce)[1],
                          DEGs=as.numeric(metadata(sce)$n_degs),
                          DEGs_UP=as.numeric(metadata(sce)$n_degs_up),
                          DEGs_DOWN=as.numeric(metadata(sce)$n_degs_down),
                          PosCtrl=as.numeric(metadata(sce)$n_pc),
                          Normalization=metadata(sce)$norm)
        return(tab)
    })
    tab <- matrix(unlist(tablist), ncol=dim(tablist[[1]])[2], byrow=TRUE)
    rownames(tab) <- names(scelist)
    tab <- as.data.frame(tab)
    colnames(tab) <- colnames(tablist[[1]])
    tab$Nuclei <- as.numeric(tab$Nuclei)
    tab$DEGs <- as.numeric(tab$DEGs)
    tab$Label <- names(scelist)
    return(tab)
}


statDEG <- function(sce)
{
    rowData(sce)$sign <- FALSE
    rowData(sce)$sign[rowData(sce)$FDR < 0.05] <- TRUE
    metadata(sce)$n_nuclei <- sum(sce$ncells)
    metadata(sce)$n_degs <- sum(rowData(sce)$sign)
    metadata(sce)$n_degs_up <- sum(rowData(sce)[rowData(sce)$sign,]$logFC > 0)
    metadata(sce)$n_degs_down <- sum(rowData(sce)[rowData(sce)$sign,]$logFC < 0)
    metadata(sce)$n_pc <- sum(rowData(sce)[rowData(sce)$sign,]$posctl)
    sce
}

getColorPaletteGgp <- function(g)
{
    stopifnot(is(g, "ggplot"))
    # Extract the ggplot build object
    g_build <- ggplot_build(g)
    
    # Extract the legend information from the scales
    legend_info <- g_build$plot$scales$scales
    
    # Find the legend for the color scale (modify if needed)
    color_legend <- legend_info[[which(sapply(legend_info, function(x) x$aesthetics[1] == "colour"))]]
    
    # Extract the labels and their corresponding colors
    palette <- color_legend$palette(length(color_legend$get_labels()))
    
    names(palette) <- color_legend$get_labels()
    return(palette)
}
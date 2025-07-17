library(cowplot)
#########################
#' ProcessDEResultsForPlot
#'
#' @param de.results
#' @param threshold
#' @param counts.dataframe
#' @param design.matrix
#' @param pos.ctrls.list
#'
#' @return
#' @export
#' @examples
ProcessDEResultsForPlot <- function(de.results, threshold=0.05,
                                    counts.dataframe=NULL, design.matrix=NULL,
                                    pos.ctrls.list=NULL)
{
    de.results.new <- de.results
    # de.results.new <- de.results.new[order(rownames(de.results.new)),]
    if(!is.null(counts.dataframe))
    {
        counts.dataframe.ord <- counts.dataframe[
            order(rownames(counts.dataframe)),]
    }
    
    
   if ("F" %in% colnames(de.results.new)) { ## working on edgeR results
        
        de.results.new <- de.results.new[, c(1:3, 6:7)]
        de.results.new$padj <- format(round(de.results.new$FDR, 8), nsmall=8)
        de.results.new$pval <- de.results.new$PValue
        de.results.new$log2FoldChange <- de.results.new$logFC
        de.results.new$log10FoldChange <- log10( (de.results.new[,1]/de.results.new[,2]))
        de.results.new$minuslog10pval <- -log10(de.results.new$PValue)
        # de.results.new$log2Counts <- (1/2) * log2((de.results.new[,1] * de.results.new[,2]))
        de.results.new$significance <- paste("P. Adj >=", threshold)
        idx <- which(de.results.new$FDR < threshold)
        de.results.new$significance[idx] <- paste("P. Adj <", threshold)
        # de.results.new <- de.results.new[order(de.results.new$padj, decreasing=FALSE),]
        de.results.new$minuslog10PAdj <- (-1) * log10(de.results.new$FDR)
        de.results.new$method <- rep(x="edgeR", times=dim(de.results.new)[1])
        
        de.results.new$gene <- de.results$gene
        
        if(!is.null(pos.ctrls.list))
        {
            de.results.new$posc <- NA
            
            # de.results.new <- de.results.new[order(rownames(de.results.new)),]
            # pos.ctrls.list <- pos.ctrls.list[order(pos.ctrls.list)]
            idx.pos <- which(tolower(de.results.new$gene) %in%
                                 tolower(pos.ctrls.list))
            # print(length(idx.pos))
            if(length(idx.pos)!=0)
            {
                de.results.new$posc[idx.pos] <- "pos-ctrl"
            } else {
                warning("no positive controls found!")
            }
        }
    } 
    
    # de.results.new$gene <- rownames(de.results.new)
    
    return(de.results.new)
}




#' GeneratePlotStrings
#'
#' @param path
#' @param prefix
#' @param plot.type
#'
#' @return
#' @export
#'
#' @examples
GeneratePlotStrings <- function(path=NULL, prefix, plot.type) {
    title <- gsub(pattern = "_", replacement = " ", x = UpdatePrefix(prefix, plot.type))
    
    plot.folder <- gsub(pattern = " ", replacement = "_", x = file.path(path, plot.type))
    
    plot.file.name <- gsub(pattern = " ", replacement = "_", x = UpdatePrefix(prefix, plot.type))
    if(!is.null(path)) dir.create(plot.folder, showWarnings = FALSE, recursive = TRUE)
    
    return(list("title"= title, "plot.folder"=plot.folder, "plot.file.name"=plot.file.name))
}


#' UpdatePrefix
#'
#' @param prefix
#' @param ...
#'
#' @return
#' @export
#'
#' @examples
UpdatePrefix <- function(prefix, ...) {
    # new.prefix <- paste(prefix, postix, sep=sep)
    dots <- list(...)
    if( length(dots) != 0 ) {
        for (str in dots) {
            # str <- gsub(pattern = ".", replacement = "_", str)
            prefix <- paste(prefix, str, sep = " " )
        }
        
    } else {
        stop("provide a string to append to ", new.prefix)
    }
    return(prefix)
}

createSignLabelsNumbers <- function(proc.df, column.name)
{
    values <- unique(proc.df[[column.name]])
    tot.de <- sum(proc.df[[column.name]] == values[1])
    tot.not.de <- dim(proc.df)[1] - tot.de 
    
    idxsign <- which(proc.df[[column.name]]==values[1])
    proc.df[[column.name]][idxsign] <- paste0(values[1], 
                                              " [", tot.de, "]")
    proc.df[[column.name]][-idxsign] <- paste0(values[2], 
                                               " [", tot.not.de, "]")
    return(proc.df)
}


luciaVolcanoPlot1 <- function(res.o, positive.controls.df, prefix, 
                              threshold=0.01, plotly.flag=TRUE, cowplot=FALSE)
{
    require(ggplot2)
    xlabl <- bquote(~log[2]~"(FC)")
    ylabl <- bquote(~-log[10]~"(PValue)")
    title <- paste(prefix, "Volcano Plot")
    
    new.de <- ProcessDEResultsForPlot(de.results=res.o, threshold=threshold)
    pos.contr <- positive.controls.df
    with.pos.de <- new.de
    
    without.pos.de <- createSignLabelsNumbers(with.pos.de, "significance")
    without.pos.de$Significance <- without.pos.de$significance
    pp <- ggplot(data=without.pos.de) +
        geom_point(aes(x=log2FoldChange, y=minuslog10pval, color=Significance, 
                       text=paste0("padj=", padj, "\nname=", gene)), 
                   size=0.7) +
        scale_color_manual(values=c("red2", "blue2")) #+
    #     geom_vline(xintercept=-1, color="green4", linetype="dashed", size=0.5) +
    #     geom_vline(xintercept=1, color="green4", linetype="dashed", size=0.5) + 
    # geom_hline(yintercept=1.715, color="green4", linetype="dashed", size=0.5) 
    # pp
    
    if( !is.null(positive.controls.df) )
    {
        with.pos.de$hit <- NA
        idxpc <- which(tolower(with.pos.de$gene) %in% tolower(pos.contr[,1]))
        if(length(idxpc) > 0) 
        {
            with.pos.de$hit[idxpc] <- "Pos. Controls"
            sub.de <- with.pos.de[which(with.pos.de$hit=="Pos. Controls"),] 
            sub.de$col <- "Pos. Controls"
            
            sign <- which(sub.de$significance==paste("P. Adj <", threshold))
            sub.de$hit[sign] <- paste("Pos. Controls <", threshold)
            notsign <- which(sub.de$significance==paste("P. Adj >=", threshold))
            sub.de$hit[notsign] <- paste("Pos. Controls >=", threshold)
            
            sub.de <- createSignLabelsNumbers(sub.de, "hit")
            
            pp <- pp + 
                geom_point(data=sub.de, aes(x=log2FoldChange, y=minuslog10pval, 
                        color=hit,
                        text=paste0("padj=", padj, "\nname=", gene)), size=0.9) +
                scale_color_manual(values=c("black", "gray56", "red2", "red2"))
        }
    }
    if(cowplot) pp <- pp + theme_cowplot()
    pp <- pp + ggtitle(title) + xlab(xlabl)+ ylab(ylabl)
    return(pp)
}
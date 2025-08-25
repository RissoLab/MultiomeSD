# computeFilterCellsMetrics <- function(scelist,
#                                       metric=c("quantile", "is.outlier", "both"), lowQuant="5%", highQuant="90%",
#                                       nucleosomeThr=2, TSSThr=1)
# {
#     stopifnot( all( c("nCount_ATAC", "nCount_RNA", "nFeature_RNA",
#                       "nucleosome_signal", "TSS.enrichment") %in%
#                         colnames(colData(scelist[[1]]))
#     )
#     )
#
#     metric=match.arg(metric)
#
#     nsth <- nucleosomeThr
#     tssth <- TSSThr
#     nms <- names(scelist)
#     scelist <- lapply(seq_along(scelist), function(i)
#     {
#         sce <- scelist[[i]]
#         if( (metric=="quantile") || (metric=="both") )
#         {
#             (qnca <- quantile(sce$nCount_ATAC, c(.01, .05, .10, .90, .95), na.rm=TRUE))
#             (qncr <- quantile(sce$nCount_RNA, c(.01, .05, .10, .90, .95), na.rm=TRUE))
#             (qnfr <- quantile(sce$nFeature_RNA, c(.01, .05, .10, .90, .95), na.rm=TRUE))
#             (qns <- quantile(sce$nucleosome_signal, c(.01, .05, .10, .90, .95, .99), na.rm=TRUE))
#             (qtsse <- quantile(sce$TSS.enrichment, c(.01, .05, .10, .90, .95), na.rm=TRUE))
#
#             sce$nCount_ATAC_passed <- FALSE
#             sce$nCount_RNA_passed <- FALSE
#             sce$nFeature_RNA_passed <- FALSE
#             sce$nucleosome_passed <- FALSE
#             sce$TSS_passed <- FALSE
#
#             filtered <- subset(
#                 x = colData(sce),
#                 subset = nCount_ATAC < qnca[highQuant] &
#                     nCount_ATAC >  qnca[lowQuant]
#             )
#
#             idx <- which(rownames(colData(sce)) %in% rownames(filtered))
#             sce$nCount_ATAC_passed[idx] <- TRUE
#
#             filtered <- subset(
#                 x = colData(sce),
#                 subset =    nCount_RNA < qncr[highQuant] &
#                     nCount_RNA >  qncr[lowQuant]
#             )
#
#             idx <- which(rownames(colData(sce)) %in% rownames(filtered))
#             sce$nCount_RNA_passed[idx] <- TRUE
#
#             filtered <- subset(
#                 x = colData(sce),
#                 subset = nFeature_RNA > qnfr[lowQuant]
#             )
#
#             idx <- which(rownames(colData(sce)) %in% rownames(filtered))
#             sce$nFeature_RNA_passed[idx] <- TRUE
#
#             filtered <- subset(
#                 x = colData(sce),
#                 subset = nucleosome_signal < nsth
#             )
#             idx <- which(rownames(colData(sce)) %in% rownames(filtered))
#             sce$nucleosome_passed[idx] <- TRUE
#
#             filtered <- subset(
#                 x = colData(sce),
#                 subset = TSS.enrichment > tssth
#             )
#             idx <- which(rownames(colData(sce)) %in% rownames(filtered))
#             sce$TSS_passed[idx] <- TRUE
#             sce$in_signac <- (sce$nCount_ATAC_passed &
#                                   sce$nCount_RNA_passed &
#                                   sce$nFeature_RNA_passed &
#                                   sce$nucleosome_passed &
#                                   sce$TSS_passed)
#         }
#         if( (metric=="isOutlier") || (metric=="both") )
#         {
#             require("scuttle")
#             sce$nCount_ATAC_passed_io <- !isOutlier(sce$nCount_ATAC)
#             sce$nCount_RNA_passed_io <- !isOutlier(sce$nCount_RNA)
#             sce$nFeature_RNA_passed_io <- !isOutlier(sce$nFeature_RNA)
#             sce$nucleosome_passed_io <- !isOutlier(sce$nucleosome_signal)
#             sce$TSS_passed_io <- !isOutlier(sce$TSS.enrichment)
#             sce$passed_io <- (sce$nCount_ATAC_passed_io &
#                                   sce$nCount_RNA_passed_io &
#                                   sce$nFeature_RNA_passed_io &
#                                   sce$nucleosome_passed_io &
#                                   sce$TSS_passed_io)
#         }
#         if(metric=="both")
#         {
#             sce$passed_both <- (sce$in_signac & sce$passed_io)
#         }
#         sce
#     })
#     names(scelist) <- nms
#     return(scelist)
# }

plotFilteredCells <- function(sce,
                              filterCellsBy=c("all", "custom"),
                              inout=c("out", "in"),
                              customColName="passed_both", name)
{
    inout=match.arg(inout)
    filterCellsBy=match.arg(filterCellsBy)
    switch(filterCellsBy,
           "all"={
               mask=rep(TRUE, dim(sce)[2])
           },
           "custom"={

               stopifnot( all(!is.null(customColName), (customColName %in% colnames(colData(sce))) ) )
               col <- colData(sce)[[customColName]]
               fl <- FALSE
               if(is.logical(col)) fl <- TRUE
               if(inout=="in")
               {
                   if(fl)
                   {
                       mask <- col==TRUE
                   } else {
                       mask <- col=="1. TRUE"
                   }

               } else {
                   if(fl)
                   {
                       mask <- col==FALSE
                   } else {
                       mask <- col=="2. FALSE"
                   }
               }
           }
    )
    leg_title <- "Filter Passed"
    gg1 <- plotColData(sce[,mask], y=c("nCount_ATAC"),
                       colour_by="nCount_ATAC_passed") +
        ggtitle("nCount_ATAC") +
        theme(plot.title = element_text(size = 8, face = "bold")) +
        labs(color = leg_title, fill = leg_title) +
        guides(color = guide_legend(title = leg_title),
               fill  = guide_legend(title = leg_title))
    gg2 <- plotColData(sce[,mask], y=c("nCount_RNA"),
                       colour_by="nCount_RNA_passed") +
        ggtitle("nCount_RNA")+
        theme(plot.title = element_text(size = 8, face = "bold"))
    gg3 <- plotColData(sce[,mask], y=c("nFeature_RNA"),
                       colour_by="nFeature_RNA_passed") +
        ggtitle("nFeature_RNA")+
        theme(plot.title = element_text(size = 8, face = "bold"))
    gg4 <- plotColData(sce[,mask], y=c("nucleosome_signal"),
                       colour_by="nucleosome_passed") +
        ggtitle("nucleosome_signal")+
        theme(plot.title = element_text(size = 8, face = "bold"))
    gg5 <- plotColData(sce[,mask], y=c("TSS.enrichment"),
                       colour_by="TSS_passed") +
        ggtitle("TSS.enrichment")+
        theme(plot.title = element_text(size = 8, face = "bold"))

    gg6 <- ggarrange(gg1, gg2, gg3, gg4, gg5, nrow=1, common.legend=TRUE,
                     legend="bottom")

    gg6 <- annotate_figure(gg6, top = text_grob(paste0(name,"_", inout," cells"),
                                                color = "black", face = "bold", size = 14))

    # ggsave(filename=paste0("../qc_filtered_in/", names(scelist)[i], "combined_coloured.png"), plot=gg6)
    return(gg6)
}

.get_legend<-function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)}

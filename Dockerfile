# Start with Bioconductor version 3.18 image
FROM bioconductor/bioconductor_docker:RELEASE_3_18

# Set environment variables
ENV TZ=Europe/Zurich

# Install remotes package for GitHub installations if not already installed
RUN R -e "if (!requireNamespace('remotes', quietly = TRUE)) install.packages('remotes')"

# Install CRAN and Bioconductor packages with specified versions
RUN R -e " \
    BiocManager::install(version = '3.18', ask = FALSE); \
    BiocManager::install(c( \
        'AnnotationDbi', version = '1.64.1', \
        'batchelor', version = '1.18.0', \
        'BiocNeighbors', version = '1.20.0', \
        'BiocParallel', version = '1.36.0', \
        'biomaRt', version = '2.58.0', \
        'ChIPpeakAnno', version = '3.36.0', \
        'ChIPseeker', version = '1.38.0', \
        'clusterExperiment', version = '2.22.0', \
        'cowplot', version = '1.1.1', \
        'DEScan2', version = '1.22.0', \
        'dplyr', version = '1.1.3', \
        'DT', version = '0.30', \
        'EnsDb.Mmusculus.v79', version = '2.99.0', \
        'GenomicRanges', version = '1.54.1', \
        'ggplot2', version = '3.4.4', \
        'ggpubr', version = '0.6.0', \
        'ggrepel', version = '0.9.4', \
        'Matrix', version = '1.6-5', \
        'MOFA2', version = '1.10.0', \
        'MultiAssayExperiment', version = '1.28.0', \
        'muscat', version = '1.16.0', \
        'org.Mm.eg.db', version = '3.18.0', \
        'pheatmap', version = '1.0.12', \
        'plotly', version = '4.10.3', \
        'RColorBrewer', version = '1.1-3', \
        'readxl', version = '1.4.3', \
        'rtracklayer', version = '1.62.0', \
        'RUVSeq', version = '1.36.0', \
        'S4Vectors', version = '0.40.1', \
        'scater', version = '1.30.0', \
        'scDblFinder', version = '1.16.0', \
        'scran', version = '1.30.0', \
        'scuttle', version = '1.12.0', \
        'SingleCellExperiment', version = '1.24.0', \
        'SummarizedExperiment', version = '1.32.0', \
        'TxDb.Mmusculus.UCSC.mm10.knownGene', version = '3.10.0', \
        'UpSetR', version = '1.4.0' \
    ), ask = FALSE, update = FALSE)"

# Install GitHub packages with specific versions from the 'drighelli' account
RUN R -e "remotes::install_github(c( \
        'drighelli/AllenInstituteBrainData', \
        'drighelli/darioscripts@developing_SummExp', \
        'drighelli/TENxMultiomeTools' \
    ))"

# Force installation of edgeR 4.0.1 from the provided URL
RUN R -e "remotes::install_url('https://mghp.osn.xsede.org/bir190004-bucket01/archive.bioconductor.org%2Fpackages%2F3.18%2Fbioc%2Fsrc%2Fcontrib%2FArchive%2FedgeR%2FedgeR_4.0.1.tar.gz')"


ALL: ATAC GEX

ATAC: ATAC_S3 ATAC_S3SD ATAC_SD ATAC_WT

GEX: GEX_S3 GEX_S3SD GEX_SD GEX_WT

wrkrs = 10

GEX_S3: sample_sheet_GEX_S3_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211004_A00643_0326_A_H3HHCDMXY_P1160_P1178 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/GEX_S3/outs/

GEX_S3SD: sample_sheet_GEX_S3SD_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211004_A00643_0326_A_H3HHCDMXY_P1160_P1178 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/GEX_S3SD/outs/

GEX_SD: sample_sheet_GEX_SD_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211004_A00643_0326_A_H3HHCDMXY_P1160_P1178 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/GEX_SD/outs/

GEX_WT: sample_sheet_GEX_WT_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211004_A00643_0326_A_H3HHCDMXY_P1160_P1178 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/GEX_WT/outs/

ATAC_S3: sample_sheet_ATAC_S3_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211006_A00643_0329_A_HHWY5DRXY_P1161_P1152 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/ATAC_S3/outs/

ATAC_S3SD: sample_sheet_ATAC_S3SD_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211006_A00643_0329_A_HHWY5DRXY_P1161_P1152 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/ATAC_S3SD/outs/

ATAC_SD: sample_sheet_ATAC_SD_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211006_A00643_0329_A_HHWY5DRXY_P1161_P1152 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/ATAC_SD/outs/

ATAC_WT: sample_sheet_ATAC_WT_rep1.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_1/211006_A00643_0329_A_HHWY5DRXY_P1161_P1152 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_1/ATAC_WT/outs/

REP1: REP1_S3 REP1_S3SD REP1_SD REP1_WT

REP1_S3:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_s3.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP1_S3SD:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_s3sd.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP1_SD:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_sd.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP1_WT:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_wt.csv \
	--localcores=$(wrkrs) \
	--localmem=40

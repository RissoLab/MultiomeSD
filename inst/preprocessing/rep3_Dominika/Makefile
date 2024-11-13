ALL: ATAC GEX ATAC_L2

ATAC: ATAC_S3 ATAC_S3SD ATAC_SD ATAC_WT

ATAC_L2: ATAC_L2_S3 ATAC_L2_S3SD ATAC_L2_SD ATAC_L2_WT

GEX: GEX_S3 GEX_S3SD GEX_SD GEX_WT

wrkrs = 10

GEX_S3: sample_sheet_GEX_S3_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/GEX/211210_A00643_0378_BHVT75DSX2 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/GEX_S3/outs/

GEX_S3SD: sample_sheet_GEX_S3SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/GEX/211210_A00643_0378_BHVT75DSX2 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/GEX_S3SD/outs/

GEX_SD: sample_sheet_GEX_SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/GEX/211210_A00643_0378_BHVT75DSX2 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/GEX_SD/outs/

GEX_WT: sample_sheet_GEX_WT_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/GEX/211210_A00643_0378_BHVT75DSX2 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/GEX_WT/outs/

ATAC_S3: sample_sheet_ATAC_S3_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/211202_A00643_0373_A_HM3CFDRXY_P1235 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_S3/outs/

ATAC_S3SD: sample_sheet_ATAC_S3SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/211202_A00643_0373_A_HM3CFDRXY_P1235 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_S3SD/outs/

ATAC_SD: sample_sheet_ATAC_SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/211202_A00643_0373_A_HM3CFDRXY_P1235 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_SD/outs/

ATAC_WT: sample_sheet_ATAC_WT_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/drighelli/multiome_2022/rep_2_3/211202_A00643_0373_A_HM3CFDRXY_P1235 \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_WT/outs/

ATAC_L2_S3: sample_sheet_ATAC_L2_S3_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/data/dominika_2022/211202_A00643_0374_A_HM3CFDRXY_P1235/211202_A00643_0374_BHNNVVDRXY/ \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_L2_S3/outs/

ATAC_L2_S3SD: sample_sheet_ATAC_L2_S3SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/data/dominika_2022/211202_A00643_0374_A_HM3CFDRXY_P1235/211202_A00643_0374_BHNNVVDRXY/ \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_L2_S3SD/outs/

ATAC_L2_SD: sample_sheet_ATAC_L2_SD_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/data/dominika_2022/211202_A00643_0374_A_HM3CFDRXY_P1235/211202_A00643_0374_BHNNVVDRXY/ \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_L2_SD/outs/

ATAC_L2_WT: sample_sheet_ATAC_L2_WT_rep3.csv
	cellranger-arc mkfastq --id=$@ \
	--run=/mnt/tebe/data/dominika_2022/211202_A00643_0374_A_HM3CFDRXY_P1235/211202_A00643_0374_BHNNVVDRXY/ \
	--csv=$< \
	--localcores=$(wrkrs) \
	--localmem=40 \
	--output-dir=/mnt/tebe/drighelli/multiome_2022/rep_3/ATAC_L2_WT/outs/

REP3: REP3_S3 REP3_S3SD REP3_SD REP3_WT

REP3_S3:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_s3.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP3_S3SD:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_s3sd.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP3_SD:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_sd.csv \
	--localcores=$(wrkrs) \
	--localmem=40

REP3_WT:
	cellranger-arc count --id=$@ \
	--reference=/mnt/ganimede/data/references/refdata-cellranger-arc-mm10-2020-A-2.0.0 \
	--libraries=libraries_wt.csv \
	--localcores=$(wrkrs) \
	--localmem=40

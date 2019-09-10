# pwd
cd /home/rad/users/gaurav/projects/ctrc

# Create relevant Dirs
mkdir -p  /media/rad/HDD1/PUB_CRCs/{chip/{mcl,tcellTallcellLine_hg,tcellTallcellLine_mm},atac/atac_tcellTallcellLine_mm}
 
# Copy relevant data to relevant dirs
# ChIP data
# Tcell and T-All celline data
# Mouse
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR3330047,SRR3330050,SRR1521788,SRR1521789,SRR1521790,SRR1521791,SRR1521792,SRR1521793,SRR1521823,SRR1521824,SRR1521825,SRR1521826,SRR1521827,SRR1521817,SRR1521818,SRR1521819,SRR1521820,SRR6000464}*.gz /media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_mm

# Human
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR3098550,SRR1143213,SRR1143214,SRR1143215,SRR1143216,SRR3098557,SRR3098559,SRR1522114}*.gz /media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_hg

# MCL ChIPseq PairEnd data
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR2050993,SRR2050993,SRR2050991,SRR2050991,SRR2051002,SRR2051002,SRR5444128,SRR5444128}*.gz /media/rad/HDD1/PUB_CRCs/chip/mcl

# ATACseq data
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR1533853,SRR1533854,SRR1533855,SRR1533856,SRR1533861}*.gz /media/rad/HDD1/PUB_CRCs/atac/atac_tcellTallcellLine_mm/

# Rename files
# Tcell and T-All celline data
# Mouse
cd /media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_mm
mv *SRR3330047* H3K27ac_DP1_mm_chipseq_R1.fastq.gz
mv *SRR3330050* H3K27ac_DP2_mm_chipseq_R1.fastq.gz 
mv *SRR1521788* H3K27ac_LTHSC_mm_chipseq_R1.fastq.gz 
mv *SRR1521789* H3K27ac_LTHSC_mm_chipseq_R2.fastq.gz 
mv *SRR1521790* H3K27ac_STHSC_mm_chipseq_R1.fastq.gz 
mv *SRR1521791* H3K27ac_STHSC_mm_chipseq_R2.fastq.gz 
mv *SRR1521792* H3K27ac_MPP_mm_chipseq_R1.fastq.gz 
mv *SRR1521793* H3K27ac_MPP_mm_chipseq_R2.fastq.gz 
mv *SRR1521823* H3K27ac_CLP_mm_chipseq_R1.fastq.gz 
mv *SRR1521824* H3K27ac_CLP_mm_chipseq_R2.fastq.gz 
mv *SRR1521825* H3K27ac_CLP_mm_chipseq_R3.fastq.gz 
mv *SRR1521826* H3K27ac_CLP_mm_chipseq_R4.fastq.gz 
mv *SRR1521827* H3K27ac_CLP_mm_chipseq_R5.fastq.gz 
mv *SRR1521817* H3K27ac_CD4_mm_chipseq_R1.fastq.gz 
mv *SRR1521818* H3K27ac_CD4_mm_chipseq_R2.fastq.gz 
mv *SRR1521819* H3K27ac_CD8_mm_chipseq_R1.fastq.gz 
mv *SRR1521820* H3K27ac_CD8_mm_chipseq_R2.fastq.gz 
mv *SRR6000464* H3K27ac_EL4_GSM2770758_mm_chipseq_R1.fastq.gz
cd -

# Human
cd /media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_hg
mv *SRR3098550* H3K27ac_CCRFCEM_GSM2037781_hs_chipseq_R1.fastq.gz
mv *SRR1143213* H3K27ac_DND41_GSM1314136_hs_chipseq_R1.fastq.gz
mv *SRR1143214* H3K27ac_DND41_GSM1314136_hs_chipseq_R2.fastq.gz
mv *SRR1143215* H3K27ac_DND41_GSM1314136_hs_chipseq_R3.fastq.gz
mv *SRR1143216* H3K27ac_DND41_GSM1314136_hs_chipseq_R4.fastq.gz
mv *SRR3098557* H3K27ac_Loucy_GSM2037788_hs_chipseq_R1.fastq.gz
mv *SRR3098559* H3K27ac_MOLT4_GSM2037790_hs_chipseq_R1.fastq.gz
mv *SRR1522114* H3K27ac_RPMI8402_GSM1442003_hs_chipseq_R1.fastq.gz
mv *SRR568221*  H3K27ac_DND41_Broad_GSM1003462_hs_chipseq_R1.fastq.gz
mv *SRR568222*  H3K27ac_DND41_Broad_GSM1003462_hs_chipseq_R2.fastq.gz
cd -

# MCL ChIPseq PairEnd data
cd /media/rad/HDD1/PUB_CRCs/chip/mcl
mv *SRR2050993_1* H3K27ac_JEKO1_GSE69558_hs_chipseq_1.fastq.gz
mv *SRR2050993_2* H3K27ac_JEKO1_GSE69558_hs_chipseq_2.fastq.gz
mv *SRR2050991_1* H3K27ac_GRANTA519_GSE69558_hs_chipseq_1.fastq.gz
mv *SRR2050991_2* H3K27ac_GRANTA519_GSE69558_hs_chipseq_2.fastq.gz
mv *SRR2051002_1* H3K27ac_MINO_GSE69558_hs_chipseq_1.fastq.gz
mv *SRR2051002_2* H3K27ac_MINO_GSE69558_hs_chipseq_2.fastq.gz
mv *SRR5444128_1* H3K27ac_Maver1_GSM2571793_hs_chipseq_1.fastq.gz
mv *SRR5444128_2* H3K27ac_Maver1_GSM2571793_hs_chipseq_2.fastq.gz
cd -

# ATACseq data
cd /media/rad/HDD1/PUB_CRCs/atac/atac_tcellTallcellLine_mm/
mv *SRR1533853* CD4PosTcells_mm_atacseq_R1.fastq.gz
mv *SRR1533854* CD4PosTcells_mm_atacseq_R2.fastq.gz
mv *SRR1533855* CD4PosTcells_mm_atacseq_R3.fastq.gz
mv *SRR1533856* CD4PosTcells_mm_atacseq_R4.fastq.gz
mv *SRR1533861* CD8PosTcells_mm_atacseq_R1.fastq.gz
cd -
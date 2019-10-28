# pwd
cd /home/rad/users/gaurav/projects/ctrc

# Download the files
aria2c -j 32 -x 16 -c -i /home/rad/users/gaurav/projects/ctrc/docs/download_3.txt -l /home/rad/users/gaurav/projects/ctrc/docs/download_3.log -d /media/rad/HDD1/PUB_CRCs/atac/atac_tALLcellLine_hg

# Create relevant Dirs
mkdir -p  /media/rad/HDD1/PUB_CRCs/{chip/{mcl,tALLcellLine_hg,tALLcellLine_mm},atac/atac_tALLcellLine_mm}
 
# Copy relevant data to relevant dirs
# ChIP data
# Tcell and T-All celline data
# Mouse
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR3330047,SRR3330050,SRR1521788,SRR1521789,SRR1521790,SRR1521791,SRR1521792,SRR1521793,SRR1521823,SRR1521824,SRR1521825,SRR1521826,SRR1521827,SRR1521817,SRR1521818,SRR1521819,SRR1521820,SRR6000464}*.gz /media/rad/HDD1/PUB_CRCs/chip/tALLcellLine_mm

# Human
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR3098550,SRR1143213,SRR1143214,SRR1143215,SRR1143216,SRR3098557,SRR3098559,SRR1522114}*.gz /media/rad/HDD1/PUB_CRCs/chip/tALLcellLine_hg

# MCL ChIPseq PairEnd data
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR2050993,SRR2050993,SRR2050991,SRR2050991,SRR2051002,SRR2051002,SRR5444128,SRR5444128}*.gz /media/rad/HDD1/PUB_CRCs/chip/mcl

# ATACseq data
rsync -arvP /media/nas/raw/PUB_CRCs/{SRR1533853,SRR1533854,SRR1533855,SRR1533856,SRR1533861}*.gz /media/rad/HDD1/PUB_CRCs/atac/atac_tALLcellLine_mm/

# AML data
cd /media/nas/fastq/Studies/AGRad_mPDAC
ls *DS{11,28,32}*/results/rescued/*.txt    | parallel --progress --eta -j 16 'rsync -arvPR {} /media/rad/HDD1/pdacMetastasis/input/local_AGRad_mPDAC/cherrypicked2'
ls *DS{11,28,32}*/results/bam/*.Tumor.bam* | parallel --progress --eta -j 32 'rsync -arvRP {} /media/rad/HDD1/pdacMetastasis/input/local_AGRad_mPDAC/cherrypicked2'
cd -

# Rename files
# Tcell and T-All celline data
# Mouse
cd /media/rad/HDD1/PUB_CRCs/chip/tALLcellLine_mm
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
cd /media/rad/HDD1/PUB_CRCs/chip/tALLcellLine_hg
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
cd /media/rad/HDD1/PUB_CRCs/atac/atac_tALLcellLine_mm/
mv *SRR1533853* CD4PosTcells_mm_atacseq_R1.fastq.gz
mv *SRR1533854* CD4PosTcells_mm_atacseq_R2.fastq.gz
mv *SRR1533855* CD4PosTcells_mm_atacseq_R3.fastq.gz
mv *SRR1533856* CD4PosTcells_mm_atacseq_R4.fastq.gz
mv *SRR1533861* CD8PosTcells_mm_atacseq_R1.fastq.gz
mv SRR4345672_1.fastq.gz EL4_GSM2337212_mm_atacseq_R1_1.fastq.gz
mv SRR4345673_1.fastq.gz EL4_GSM2337213_mm_atacseq_R2_1.fastq.gz
mv SRR4345672_2.fastq.gz EL4_GSM2337212_mm_atacseq_R1_2.fastq.gz
mv SRR4345673_2.fastq.gz EL4_GSM2337213_mm_atacseq_R1_2.fastq.gz
cd -

# ATACseq data
cd /media/rad/HDD1/PUB_CRCs/atac/atac_tALLcellLine_hg/
mv SRR8820028_1.fastq.gz Jurkat_GSM3693103_hs_atacseq_R1_1.fastq.gz
mv SRR8820034_1.fastq.gz RPMI8402_GSM3693105_hs_atacseq_R1_1.fastq.gz
mv SRR8820035_1.fastq.gz CCRFCEM_GSM3693106_hs_atacseq_R1_1.fastq.gz
mv SRR8820031_1.fastq.gz MOLT4_GSM3693104_hs_atacseq_R1_1.fastq.gz

mv SRR8820028_2.fastq.gz Jurkat_GSM3693103_hs_atacseq_R1_2.fastq.gz
mv SRR8820034_2.fastq.gz RPMI8402_GSM3693105_hs_atacseq_R1_2.fastq.gz
mv SRR8820035_2.fastq.gz CCRFCEM_GSM3693106_hs_atacseq_R1_2.fastq.gz
mv SRR8820031_2.fastq.gz MOLT4_GSM3693104_hs_atacseq_R1_2.fastq.gz
cd -

# AML data
cd /media/nas/raw/PUB_CRCs/download_8_AML
mv SRR7071419.fastq.gz H3K27ac_THP1_GSM3112082_SRR7071419_hs_chipseq_R1.fastq.gz
mv SRR1957039_1.fastq.gz H3K27ac_MOLM13_GSM1652920_SRR1957039_hs_chipseq_R1_1.fastq.gz
mv SRR1957039_2.fastq.gz H3K27ac_MOLM13_GSM1652920_SRR1957039_hs_chipseq_R1_2.fastq.gz
mv SRR1768122.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768122_hs_chipseq_R1.fastq.gz
mv SRR1768123.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768123_hs_chipseq_R2.fastq.gz
mv SRR1768124.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768124_hs_chipseq_R3.fastq.gz
mv SRR1768125.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768125_hs_chipseq_R4.fastq.gz
mv SRR8723507.fastq.gz H3K27ac_MM1_GSM3669483_SRR8723507_hs_chipseq_R1.fastq.gz
mv SRR8723509.fastq.gz H3K27ac_MM6_GSM3669485_SRR8723509_hs_chipseq_R1.fastq.gz
mv SRR10059514.fastq.gz H3K27ac_HL60_GSM4057498_SRR10059514_hs_chipseq_R1.fastq.gz
mv SRR7236818.fastq.gz H3K27ac_Kasumi1_GSM3165517_SRR7236818_hs_chipseq_R1.fastq.gz
mv SRR5863450.fastq.gz H3K27ac_MV411_GSM2716701_SRR5863450_hs_chipseq_R1.fastq.gz
mv SRR6987861.fastq.gz H3K27ac_EOL1_GSM3094374_SRR6987861_hs_chipseq_R1.fastq.gz
mv SRR10059518.fastq.gz H3K27ac_OCIAML3_GSM4057502_SRR10059518_hs_chipseq_R1.fastq.gz
mv SRR10059525.fastq.gz H3K27ac_K562_GSM4057509_SRR10059525_hs_chipseq_R1.fastq.gz
cd -

# Merge MOLM14 samples
zcat H3K27ac_MOLM14_GSM1587893_SRR1768122_hs_chipseq_R1.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768123_hs_chipseq_R2.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768124_hs_chipseq_R3.fastq.gz  H3K27ac_MOLM14_GSM1587893_SRR1768125_hs_chipseq_R4.fastq.gz >  H3K27ac_MOLM14_GSM1587893_SRR1768122345_hs_chipseq_R1.fastq
# 1,9G	H3K27ac_MOLM14_GSM1587893_SRR1768122345_hs_chipseq_R1.fastq.gz
# 427M	H3K27ac_MOLM14_GSM1587893_SRR1768122_hs_chipseq_R1.fastq.gz
# 343M	H3K27ac_MOLM14_GSM1587893_SRR1768123_hs_chipseq_R2.fastq.gz
# 643M	H3K27ac_MOLM14_GSM1587893_SRR1768124_hs_chipseq_R3.fastq.gz
# 499M	H3K27ac_MOLM14_GSM1587893_SRR1768125_hs_chipseq_R4.fastq.gz
rm H3K27ac_MOLM14_GSM1587893_SRR1768122_hs_chipseq_R1.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768123_hs_chipseq_R2.fastq.gz H3K27ac_MOLM14_GSM1587893_SRR1768124_hs_chipseq_R3.fastq.gz  H3K27ac_MOLM14_GSM1587893_SRR1768125_hs_chipseq_R4.fastq.gz

# Diaferia data
cd /media/nas/raw/PUB_CRCs/download_7_diaferia
mv SRR2919436.fastq.gz H3K27ac_CAPAN1_GSM1574235_SRR2919436_hs_chipseq_R1.fastq.gz
mv SRR1736432.fastq.gz H3K27ac_CAPAN2_GSM1574236_SRR1736432_hs_chipseq_R1.fastq.gz
mv SRR2919437.fastq.gz H3K27ac_CFPAC1_GSM1574237_SRR2919437_hs_chipseq_R1.fastq.gz
mv SRR2919438.fastq.gz H3K27ac_HPAF2_GSM1574238_SRR2919438_hs_chipseq_R1.fastq.gz
mv SRR2919439.fastq.gz H3K27ac_MiaPaca2_GSM1574239_SRR2919439_hs_chipseq_R1.fastq.gz
mv SRR1736436.fastq.gz H3K27ac_PANC1_GSM1574240_SRR1736436_hs_chipseq_R1.fastq.gz
mv SRR1736437.fastq.gz H3K27ac_PT45P1_GSM1574241_SRR1736437_hs_chipseq_R1.fastq.gz
cd -

# ATACseq Murine Tcells data
cd /media/nas/raw/PUB_CRCs/download_5/atacPE
mv SRR3152810_1.fastq.gz.1  BMHSC1_GSM2056296_mm_atacseq_R1_1.fastq.gz
mv SRR3152810_2.fastq.gz.1  BMHSC1_GSM2056296_mm_atacseq_R1_2.fastq.gz
mv SRR3152811_1.fastq.gz.1  BMHSC2_GSM2056297_mm_atacseq_R1_1.fastq.gz
mv SRR3152811_2.fastq.gz.1  BMHSC2_GSM2056297_mm_atacseq_R1_2.fastq.gz
mv SRR3152818_1.fastq.gz.1  BMMPP1_GSM2056304_mm_atacseq_R1_1.fastq.gz
mv SRR3152818_2.fastq.gz.1  BMMPP1_GSM2056304_mm_atacseq_R1_2.fastq.gz
mv SRR3152819_1.fastq.gz.1  BMMPP2_GSM2056305_mm_atacseq_R1_1.fastq.gz
mv SRR3152819_2.fastq.gz.1  BMMPP2_GSM2056305_mm_atacseq_R1_2.fastq.gz
mv SRR3152808_1.fastq.gz.1  BMCLP1_GSM2056294_mm_atacseq_R1_1.fastq.gz
mv SRR3152808_2.fastq.gz.1  BMCLP1_GSM2056294_mm_atacseq_R1_2.fastq.gz
mv SRR3152809_1.fastq.gz.1  BMCLP2_GSM2056295_mm_atacseq_R1_1.fastq.gz
mv SRR3152809_2.fastq.gz.1  BMCLP2_GSM2056295_mm_atacseq_R1_2.fastq.gz
mv SRR3152806_1.fastq.gz.1  BMB1_GSM2056292_mm_atacseq_R1_1.fastq.gz
mv SRR3152806_2.fastq.gz.1  BMB1_GSM2056292_mm_atacseq_R1_2.fastq.gz
mv SRR3152807_1.fastq.gz.1  BMB2_GSM2056293_mm_atacseq_R1_1.fastq.gz
mv SRR3152807_2.fastq.gz.1  BMB2_GSM2056293_mm_atacseq_R1_2.fastq.gz
mv SRR3152822_1.fastq.gz.1  BMNK1_GSM2056308_mm_atacseq_R1_1.fastq.gz
mv SRR3152822_2.fastq.gz.1  BMNK1_GSM2056308_mm_atacseq_R1_2.fastq.gz
mv SRR3152823_1.fastq.gz.1  BMNK2_GSM2056309_mm_atacseq_R1_1.fastq.gz
mv SRR3152823_2.fastq.gz.1  BMNK2_GSM2056309_mm_atacseq_R1_2.fastq.gz
mv SRR3152846_1.fastq.gz.1  SPCD41_GSM2056332_mm_atacseq_R1_1.fastq.gz
mv SRR3152846_2.fastq.gz.1  SPCD41_GSM2056332_mm_atacseq_R1_2.fastq.gz
mv SRR3152847_1.fastq.gz.1  SPCD42_GSM2056333_mm_atacseq_R1_1.fastq.gz
mv SRR3152847_2.fastq.gz.1  SPCD42_GSM2056333_mm_atacseq_R1_2.fastq.gz
mv SRR3152820_1.fastq.gz.1  SPCD81_GSM2056306_mm_atacseq_R1_1.fastq.gz
mv SRR3152820_2.fastq.gz.1  SPCD81_GSM2056306_mm_atacseq_R1_2.fastq.gz
mv SRR3152821_1.fastq.gz.1  SPCD82_GSM2056307_mm_atacseq_R1_1.fastq.gz
mv SRR3152821_2.fastq.gz.1  SPCD82_GSM2056307_mm_atacseq_R1_2.fastq.gz
mv SRR5799383_1.fastq.gz.1  ETPT1_GSM2692171_mm_atacseq_R1_1.fastq.gz
mv SRR5799383_2.fastq.gz.1  ETPT1_GSM2692171_mm_atacseq_R1_2.fastq.gz
mv SRR5799384_1.fastq.gz.1  ETPT2_GSM2692172_mm_atacseq_R1_1.fastq.gz
mv SRR5799384_2.fastq.gz.1  ETPT2_GSM2692172_mm_atacseq_R1_2.fastq.gz
mv SRR5799385_1.fastq.gz.1  DN2aT1_GSM2692173_mm_atacseq_R1_1.fastq.gz
mv SRR5799385_2.fastq.gz.1  DN2aT1_GSM2692173_mm_atacseq_R1_2.fastq.gz
mv SRR5799386_1.fastq.gz.1  DN2aT2_GSM2692174_mm_atacseq_R1_1.fastq.gz
mv SRR5799386_2.fastq.gz.1  DN2aT2_GSM2692174_mm_atacseq_R1_2.fastq.gz
mv SRR5799387_1.fastq.gz.1  DN2bT1_GSM2692175_mm_atacseq_R1_1.fastq.gz
mv SRR5799387_2.fastq.gz.1  DN2bT1_GSM2692175_mm_atacseq_R1_2.fastq.gz
mv SRR5799388_1.fastq.gz.1  DN2bT2_GSM2692176_mm_atacseq_R1_1.fastq.gz
mv SRR5799388_2.fastq.gz.1  DN2bT2_GSM2692176_mm_atacseq_R1_2.fastq.gz
mv SRR5799389_1.fastq.gz.1  DN3T1_GSM2692177_mm_atacseq_R1_1.fastq.gz
mv SRR5799389_2.fastq.gz.1  DN3T1_GSM2692177_mm_atacseq_R1_2.fastq.gz
mv SRR5799545_1.fastq.gz.1  DN3T2_GSM2692333_mm_atacseq_R1_1.fastq.gz
mv SRR5799545_2.fastq.gz.1  DN3T2_GSM2692333_mm_atacseq_R1_2.fastq.gz
mv SRR5799390_1.fastq.gz.1  DN4T1_GSM2692178_mm_atacseq_R1_1.fastq.gz
mv SRR5799390_2.fastq.gz.1  DN4T1_GSM2692178_mm_atacseq_R1_2.fastq.gz
mv SRR5799391_1.fastq.gz.1  DN4T2_GSM2692179_mm_atacseq_R1_1.fastq.gz
mv SRR5799391_2.fastq.gz.1  DN4T2_GSM2692179_mm_atacseq_R1_2.fastq.gz

cd -

# ChIPseq Human  T-ALL data
cd /media/nas/raw/PUB_CRCs/download_5/chip
zcat SRR1143213.fastq.gz SRR1143214.fastq.gz SRR1143215.fastq.gz SRR1143216.fastq.gz > H3K27ac_DND41_GSM1314136_hs_chipseq_R1.fastq
zcat {SRR1143217,SRR1143218,SRR1143219,SRR1143220}.fastq.gz > H3K27me3_DND41_GSM1314137_hs_chipseq_R1.fastq
zcat {SRR1143221,SRR1143222,SRR1143223,SRR1143224}.fastq.gz > H3K36me3_DND41_GSM1314138_hs_chipseq_R1.fastq
zcat {SRR1143225,SRR1143226,SRR1143227,SRR1143228}.fastq.gz > H3K4me1_DND41_GSM1314139_hs_chipseq_R1.fastq
zcat {SRR1143229,SRR1143230,SRR1143231,SRR1143232}.fastq.gz > H3K27me3_DND41_GSM1314140_hs_chipseq_R1.fastq
mv SRR1057274.fastq.gz H3K27ac_Jurkat_GSM1296384_hs_chipseq_R1.fastq.gz
zcat {SRR1791404,SRR1791405,SRR1791406,SRR1791407,SRR1791408,SRR1791409}.fastq.gz > H3K36me3_Jurkat_GSM1603209_hs_chipseq_R1.fastq
mv SRR4031389.fastq.gz H3K4me2_Jurkat_GSM2279063_hs_chipseq_R1.fastq.gz
mv SRR4031399.fastq.gz H3K27me3_Jurkat_GSM2279071_hs_chipseq_R1.fastq.gz
mv SRR6987883.fastq.gz CTCF_Jurkat_GSM3094396_hs_chipseq_R1.fastq.gz
mv SRR7782877_1.fastq.gz H3K4me1_Jurkat_GSM3374691_hs_chipseq_R1_1.fastq.gz
mv SRR7782877_2.fastq.gz H3K4me1_Jurkat_GSM3374691_hs_chipseq_R1_2.fastq.gz
mv SRR061743.fastq.gz H3K4me3_Jurkat_GSM569085_hs_chipseq_R1.fastq.gz
mv SRR647929.fastq.gz H3K27me3_Jurkat_GSM1062740_hs_chipseq_R1.fastq.gz

cd -
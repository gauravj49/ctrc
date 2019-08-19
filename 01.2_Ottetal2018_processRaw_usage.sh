# PWD
cd /home/rad/users/gaurav/projects/trn

# Map H3k27Ac chip data with bowtie2
# The basic options for aligning reads to the genome using Bowtie2 are:
# -p: number of processors / cores
# -q: reads are in FASTQ format
# --local: local alignment feature to perform soft-clipping
# -x: /path/to/genome_indices_directory
# -U: /path/to/FASTQ_file
# -S: /path/to/output/SAM_file
bowtie2 -p 32 -q --local \
-x /home/rad/packages/bowtie2/indexes/hg19 \
-U output/ott_etal_2018/input/raw/h3k27ac_jurkat_hs_chipseq_SRR1057274.fastq.gz \
-S output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.sam


# Convert to bam
# -b means make a bam file
# -S means input is a sam file
samtools view -bS output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.sam | samtools sort - -o output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam

# Index bam file
samtools index output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam

# Run peakcalling 
macs2 callpeak \
	-t output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam \
 	-f BAM \
	-p 1e-9 --keep-dup=auto \
	-n h3k27ac_jurkat \
	--outdir output/ott_etal_2018/output/macs2 2> output/ott_etal_2018/output/macs2/h3k27ac_jurkat-macs2.log

# Call SuperEnhancers using ROSE2
cd /home/rad/packages/TRN/pipeline
python2.7 ROSE2_main.py \
-g HG19 \
-t 1000 -s 12500 \
-i /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/macs2/h3k27ac_jurkat_summits.bed \
-r /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam \
-o /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/rose

# Get the Core Regulatory Circuits (CRCs) using crc2
# Needs sudo pip install networkx==1.9.1
python2.7 CRC2.py \
-e /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/rose/h3k27ac_jurkat_summits_AllEnhancers.table.txt \
-b /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam \
-g HG19 \
-o /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/crc \
-n h3k27ac_jurkat

# # Generate plots as a standard output of the network construction algorithm contained in COLTRON
# coltron -e /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/rose/h3k27ac_jurkat_summits_AllEnhancers.table.txt \
# -b /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/h3k27ac_jurkat_hs_chipseq_SRR1057274.bam \
# -g HG19 \
# -o /home/rad/users/gaurav/projects/trn/output/ott_etal_2018/output/coltron \
# -n h3k27ac_jurkat



# Analyze ATACseq data using atacseq pipeline
# https://github.com/tobiasrausch/ATACseq
# https://informatics.fas.harvard.edu/atac-seq-guidelines.html

# PWD
cd /home/rad/users/gaurav/projects/trn

# Turn on virtualenv for python 2
source ${HOME}/packages/python2/bin/activate

# To deactivate 
deactivate

# Download relevant raw data
# Jurkat H3k27Ac T-ALL cell line Organism:Homo sapiens, Platform:ILLUMINA, ReleaseDate:2015-07-22, Run:SRR1057274, SRASample:SRS518646, SRAStudy:SRP029600
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR105/004/SRR1057274/SRR1057274.fastq.gz
mv SRR1057274.fastq.gz output/ott_etal_2018/input/raw/h3k27ac_jurkat_hs_chipseq_SRR1057274.fastq.gz

# NextSeq 500 paired end sequencing; GSM3693103: JURKAT (ATAC-seq); Homo sapiens; ATAC-seq 
# SRA Sample:SRS4557135, SRA Study:SRP189933, Sample Name:GSM3693103, cell line:JURKAT, disease state:Childhood T acute lymphoblastic leukemia, source name:blood derived tumor cells
# Run: SRR8820028
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR882/008/SRR8820028/SRR8820028_1.fastq.gz
wget ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR882/008/SRR8820028/SRR8820028_2.fastq.gz

mv SRR8820028_1.fastq.gz output/ott_etal_2018/input/raw/lymphLeukemia_jurkat_hs_atacseq_SRR8820028_1.fastq.gz
mv SRR8820028_2.fastq.gz output/ott_etal_2018/input/raw/lymphLeukemia_jurkat_hs_atacseq_SRR8820028_2.fastq.gz

# Map H3k27Ac chip data with chipcheetah
# Need to modify chipcheetah to work it on any computer ... 
# for now using the regular mapper with bowtie and macs2 individually


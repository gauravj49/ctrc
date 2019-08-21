# PWD
cd /home/rad/users/gaurav/projects/ctrc

################## Pipeline ##########################
# bamliquidator installation
# https://github.com/BradnerLab/pipeline/wiki/bamliquidator

# 1) Add the Bradner Lab pipeline PPA from a terminal:
sudo add-apt-repository ppa:bradner-computation/pipeline
sudo apt-get update
# 2) If you get an error "add-apt-repository: command not found", then first do sudo apt-get install software-properties-common python-software-properties
# Install using the ppa:
sudo apt-get install bamliquidator
# 3) OPTIONAL: If you would like to utilize the graphing capabilities, install Bokeh, e.g.
sudo python2.7 -m pip install bokeh==0.9.3 "openpyxl>=1.6.1,<2.0.0"

# # Make the CTRC pipeline setup
# 1) Add both pipeline and CLL_TFnetworks_2018 repositories as submodule for to ctrc
# NOTE: They have hardcoded path inside the scripts. Please read and set them accordingly
cd /home/rad/users/gaurav/projects/ctrc
git submodule add https://github.com/gauravj49/CLL_TFnetworks_2018 scripts/CLL_TFnetworks_2018
git submodule add https://github.com/gauravj49/pipeline scripts/pipeline


################## DATA ##############################
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


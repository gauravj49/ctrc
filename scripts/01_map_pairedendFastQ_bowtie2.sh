#!/bin/bash

# USAGE: bash 01_map_pairedendFastQ_bowtie2.sh input/fastq/hgStomachF35 output/hgStomachF35 mm10

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
fastqdir=$1
bamdir=$2
species=$3
projName=$4
scriptsdir="${jobdir}/scripts/01_map_fastQ_bowtie2/${projName}"
bt2index="/home/rad/packages/bowtie2/indexes/${species}"
mappingLogsDir="${bamdir}/mappingLogs"

# Create required dirs
mkdir -p ${scriptsdir} ${bamdir} ${mappingLogsDir}

for f in ${fastqdir}/*_1.fastq.gz
do 
 # Get basefile name
 fastQfile=$(basename "$f" .fastq.gz)
 fq1=${f}
 fq2=$(dirname ${fq1})/$(basename ${fq1} _1.fastq.gz)_2.fastq.gz
 scriptFile="${scriptsdir}/${fastQfile}.sh"
 bamfile=${bamdir}/${fastQfile}.bam
 mappingLogFile=${mappingLogsDir}/${fastQfile}_bowtiw2_mapping.log

 # Get the jobname to submit for each job
 jobname="01_$fastQfile"

 # Create the script file
 touch "${scriptFile}"

 # Align reads
 # 1.1) Map H3k27Ac chip data with bowtie2
 # The basic options for aligning reads to the genome using Bowtie2 are:
 # -p: number of processors / cores
 # -q: reads are in FASTQ format
 # -x: /path/to/genome_indices_directory
 # -U: /path/to/FASTQ_file
 # -S: /path/to/output/SAM_file

 # Details:
 	 #-U Comma-separated list of files containing unpaired reads to be aligned, e.g. lane1.fq,lane2.fq,lane3.fq,lane4.fq. Reads may be a mix of different lengths. If - is specified, bowtie2 gets the reads from the "standard in" or "stdin" filehandle.
	 #-x The basename of the index for the reference genome. The basename is the name of any of the index files up to but not including the final .1.bt2 / .rev.1.bt2 / etc. bowtie2 looks for the specified index first in the current directory, then in the directory specified in the BOWTIE2_INDEXES environment variable.
	 #-S File to write SAM alignments to. By default, alignments are written to the "standard out" or "stdout" filehandle (i.e. the console).

 echo "bowtie2 -x ${bt2index} -p 8 --very-sensitive -1 ${fq1} -2 ${fq2} > ${bamdir}/${fastQfile}.sam  2>&1 | tee ${mappingLogFile}" > "${scriptFile}"

 # Convert the SAM to BAM
 echo "samtools view -b -S ${bamdir}/${fastQfile}.sam > ${bamdir}/${fastQfile}.unsorted.bam" >> "${scriptFile}"

 # Sort the bam file
 echo "samtools sort -o ${bamdir}/${fastQfile}.bam ${bamdir}/${fastQfile}.unsorted.bam" >> "${scriptFile}"

 # Remove extra files
 echo "rm -rf ${bamdir}/${fastQfile}.sam ${bamdir}/${fastQfile}.unsorted.bam"  >> "${scriptFile}"

 # create index of the bam files
 echo "samtools index ${bamfile} " >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"

done



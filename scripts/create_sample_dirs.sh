#!/bin/bash

# USAGE: bash scripts/create_sample_dirs.sh "output/chip/mcl/mapping"

# # Output folder structure
# ├── Project_name
# │   └── SampleNames
# │       ├── sample_rmdup.bam
# │       └── sample_rmdup.bam.bai
# └── logs
#     └── mappingLogs
#         ├── sample_bowtie2_mapping.log
#         └── ...

# Set user defined environment variables
mappingDir=$1

# Create folders for each file and relevant folders
for b in ${mappingDir}/*_rmdup.bam;
do
 # Get the basename
 bname=$(basename ${b} .bam)
 
 # Get the output dir
 outdir=$(dirname ${mappingDir})

 # Create relevant folders
 sampleDir="${outdir}/${bname}/mapping"; mkdir -p ${sampleDir}

 # Move the relevant files from previous analysis
 mv ${b}* ${sampleDir}

 # Move the respecitive logs dir to project log dir
 logsDir="${outdir}/logs"; mkdir -p ${logsDir}
 mv "${mappingDir}/mappingLogs" ${logsDir}
done

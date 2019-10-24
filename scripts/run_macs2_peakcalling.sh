#!/bin/bash

# USAGE: bash scripts/run_macs2_peakcalling.sh "output/chip/mcl/mapping" "output/chip/mcl/peaks" "mcl"

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
projdir=$1    # "/media/rad/HDD1/ctrcs/output/AML"
projName=$2   # AML
scriptsdir="${jobdir}/scripts/02_peakcalling/${projName}"
peakcallingLogsDir="${projdir}/logs/peakcallingLogs"

 # # Input folder structure
 # ├── Project_name
 # │   └── SampleNames
 # │       ├── sample_rmdup.bam
 # │       └── sample_rmdup.bam.bai
 # └── logs
 #     └── mappingLogs
 #         ├── sample_bowtie2_mapping.log
 #         └── ...

# Create required dirs
mkdir -p ${scriptsdir} ${projdir} ${peakcallingLogsDir}

for f in $(find ${projdir} -maxdepth 3 -name *rmdup.bam);
do
 # Get basefile name
 bname=$(basename ${f} .bam)
 sampleDir="${projdir}/${bname}/peaks";
 scriptFile="${scriptsdir}/${bname}.sh"
 peakcallingLogFile=${peakcallingLogsDir}/${bname}_macs2_peakcalling.log

 # Get the jobname to submit for each job
 jobname="01_$bname"

 # Create the script file
 touch "${scriptFile}"
 echo "#!/bin/bash" > "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Run peakcalling
 echo "macs2 callpeak -t ${f} -f BAM -p 1e-5 --keep-dup=auto -n ${bname} --outdir ${sampleDir}  2>&1 | tee ${peakcallingLogFile}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done


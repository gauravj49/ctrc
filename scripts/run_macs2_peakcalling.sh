#!/bin/bash

# USAGE: bash scripts/run_macs2_peakcalling.sh "output/chip/mcl/mapping" "output/chip/mcl/peaks" "mcl"

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
bamdir=$1
outdir=$2
projName=$3
scriptsdir="${jobdir}/scripts/02_peakcalling/${projName}"
peakcallingLogsDir="${outdir}/peakcallingLogs"

# Create required dirs
mkdir -p ${scriptsdir} ${outdir} ${peakcallingLogsDir}

for f in ${bamdir}/*.bam
do 
 # Get basefile name
 bname=$(basename "${f}" .bam)
 scriptFile="${scriptsdir}/${bname}.sh"
 peakcallingLogFile=${peakcallingLogsDir}/${bname}_macs2_peakcalling.log

 # Get the jobname to submit for each job
 jobname="01_$bname"

 # Create the script file
 touch "${scriptFile}"
 echo "#!/bin/bash" > "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Run peakcalling
 echo "macs2 callpeak -t ${f} -f BAM -p 1e-9 --keep-dup=auto -n ${bname} --outdir ${outdir}  2>&1 | tee ${peakcallingLogFile}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done


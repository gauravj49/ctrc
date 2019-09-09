#!/bin/bash

# USAGE: bash scripts/run_macs2_peakcalling.sh "output/chip/mcl/mapping" "output/chip/mcl/peaks" "mcl"

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
outdir=$1
projName=$2
scriptsdir="${jobdir}/scripts/02_peakcalling/${projName}"
peakcallingLogsDir="${outdir}/logs/peakcallingLogs"


# Create required dirs
mkdir -p ${scriptsdir} ${outdir} ${peakcallingLogsDir}

for f in $(find ${outdir} -maxdepth 2 -name *.bam);
do
 # Get basefile name
 bname=$(basename ${f} .bam)
 sampleDir="${outdir}/${bname}";
 scriptFile="${scriptsdir}/${bname}.sh"
 peakcallingLogFile=${peakcallingLogsDir}/${bname}_macs2_peakcalling.log

 # Get the jobname to submit for each job
 jobname="01_$bname"

 # Create the script file
 touch "${scriptFile}"
 echo "#!/bin/bash" > "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Run peakcalling
 echo "macs2 callpeak -t ${f} -f BAM -p 1e-9 --keep-dup=auto -n ${bname} --outdir ${sampleDir}  2>&1 | tee ${peakcallingLogFile}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done


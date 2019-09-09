#!/bin/bash

# USAGE: bash scripts/get_crcs.sh "output/chip/mcl/mapping" "output/chip/mcl/peaks" "output/chip/mcl/crc" "mcl" "hg19"

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
outdir=$1
projName=$2
species=$3
scriptsdir="${jobdir}/scripts/03_crcs/${projName}"
crcLogsDir="${outdir}/logs/CRCLogs"

# Create required dirs
mkdir -p ${scriptsdir} ${outdir} ${crcLogsDir}

# Get the list of bam files to get the sample names 


for f in $(find ${outdir} -maxdepth 2 -name *.bam);
do
 # Get basefile name
 bname=$(basename ${f} .bam)
 sampleDir="${outdir}/${bname}";
 scriptFile="${scriptsdir}/${bname}.sh"
 crcdir="${sampleDir}/crcs"; rm -rf ${crcdir}; mkdir -p ${crcdir}
 crcLogFile="${crcLogsDir}/${bname}_crcs.log"
 summitsBed="${sampleDir}/${bname}_summits.bed"
 bamFile="${sampleDir}/${bname}.bam"
 encTableFile="${crcdir}/${bname}_summits_AllEnhancers.table.txt"

 # Get the jobname to submit for each job
 jobname="01_$bname"

 # Create the script file
 touch "${scriptFile}"
 echo "#!/bin/bash" > "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Get superenhancers

 # Run code from the subdirectory
 echo "cd ${jobdir}/scripts/pipeline" >> "${scriptFile}"

 # 3.1) Call SuperEnhancers using ROSE2
 echo "python2.7 ROSE2_main.py -g ${species} -t 1000 -s 12500 -i ${summitsBed} -r ${bamFile} -o ${crcdir} 2>&1 | tee ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # 3.2) Get the Core Regulatory Circuits (CRCs) using crc2
 # Check if FIMO is installed from the meme suite
 # Needs sudo python2.7 -m pip install networkx==1.9.1
 echo "cd ${jobdir}/scripts/CLL_TFnetworks_2018" >> "${scriptFile}"
 echo "python2.7 CRC2.py -e ${encTableFile} -b ${bamFile} -g ${species} -o ${crcdir} -n ${projName} 2>&1 | tee -a ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Get back to original working dir
 echo "cd ${jobdir}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done

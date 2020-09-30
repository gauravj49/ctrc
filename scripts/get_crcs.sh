#!/bin/bash

# USAGE: bash scripts/get_crcs.sh /media/rad/HDD1/nfchip/christine/pdacBatch1/analysis/crcs pdacBatch1 mouse

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
crcdir=$1
projName=$2
species=$3
ifNFpipeline=${4:-""} # if nf is entered then use the NFcore pipeline nomenclature

scriptsdir="${jobdir}/scripts/03_crcs/${projName}"
crcLogsDir="${crcdir}/CRCLogs"


# Create required dirs
mkdir -p ${scriptsdir} ${crcdir} ${crcLogsDir}

# Get the list of bam files to get the sample names 
for sampleDir in $(ls -d ${crcdir}/*);
do
 # Get basefile name
 bname=$(basename ${sampleDir})
 scriptFile="${scriptsdir}/${bname}_crcs.sh"
 crcLogFile="${crcLogsDir}/${bname}_crcs.log"
 summitsBed="$(find ${sampleDir} -name ${bname}*summits.bed*)"
 bamFile="$(find ${sampleDir} -name ${bname}*.bam)"
 encTableFile="${sampleDir}/rose2/$(basename ${summitsBed} .bed)_AllEnhancers.table.txt"
#  bamFile="${sampleDir}/${bname}_R1.bam"
#  if [ ${ifNFpipeline} == 'nf' ]; then
#   bamFile="${sampleDir}/${bname}_R1.mLb.clN.sorted.bam"
#  fi
#  encTableFile="${sampleDir}/rose2/${bname}_summits_AllEnhancers.table.txt"

 # Create the script file
 touch "${scriptFile}"
 echo "#!/bin/bash" > "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Get superenhancers

 # Run code from the subdirectory
 echo "cd ${jobdir}/scripts/pipeline" >> "${scriptFile}"

 # 3.1) Call SuperEnhancers using ROSE2
 echo "python2.7 ROSE2_main.py -g ${species} -t 1000 -s 12500 -i ${summitsBed} -r ${bamFile} -o ${sampleDir}/rose2 2>&1 | tee ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # 3.2) Get the Core Regulatory Circuits (CRCs) using crc2
 # Check if FIMO is installed from the meme suite
 # Needs sudo python2.7 -m pip install networkx==1.9.1
 echo "cd ${jobdir}/scripts/CLL_TFnetworks_2018" >> "${scriptFile}"
 echo "python2.7 CRC2.py -e ${encTableFile} -b ${bamFile} -g ${species} -o ${sampleDir}/crcs -n ${bname} 2>&1 | tee -a ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Get back to original working dir
 echo "cd ${jobdir}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done

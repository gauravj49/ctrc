#!/bin/bash

# USAGE: bash scripts/get_crcs.sh "output/chip/mcl/mapping" "output/chip/mcl/peaks" "output/chip/mcl/crc" "mcl" "hg19"
# NOTE : The peaksdir, bamdir and outdir should be relative path as I will convert it to absolute path

# Set user defined environment variables
jobdir="/home/rad/users/gaurav/projects/ctrc"
bamdir="${jobdir}/$1"
peaksdir="${jobdir}/$2"
outdir="${jobdir}/$3"
projName=$4
species=$5
scriptsdir="${jobdir}/scripts/03_crcs/${projName}"
crcLogsDir="${outdir}/CRCLogs"

# Create required dirs
mkdir -p ${scriptsdir} ${outdir} ${crcLogsDir}

for f in ${bamdir}/*.bam
do 
 # Get basefile name
 bname=$(basename "${f}" .bam)
 scriptFile="${scriptsdir}/${bname}.sh"
 crcLogFile="${crcLogsDir}/${bname}_crcs.log"
 summitsBed="${peaksdir}/${bname}_summits.bed"
 encTableFile="${outdir}/${bname}_summits_AllEnhancers.table.txt"
 
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
 echo "python2.7 ROSE2_main.py -g ${species} -t 1000 -s 12500 -i ${summitsBed} -r ${f} -o ${outdir} 2>&1 | tee ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # 3.2) Get the Core Regulatory Circuits (CRCs) using crc2
 # Check if FIMO is installed from the meme suite
 # Needs sudo python2.7 -m pip install networkx==1.9.1
 echo "cd ${jobdir}/scripts/CLL_TFnetworks_2018" >> "${scriptFile}"
 echo "python2.7 CRC2.py -e ${encTableFile} -b ${f} -g ${species} -o ${outdir} -n ${projName} 2>&1 | tee ${crcLogFile}" >> "${scriptFile}"
 echo "" >> "${scriptFile}"

 # Get back to original working dir
 echo "cd ${jobdir}" >> "${scriptFile}"

 # Write the command in the script file and give it correct permission to run
 chmod 775 "${scriptFile}"
 echo "${scriptFile}"
done

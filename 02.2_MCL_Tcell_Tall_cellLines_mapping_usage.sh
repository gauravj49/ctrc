# pwd
cd /home/rad/users/gaurav/projects/ctrc

################# Wrapper Main Function #############
run_se_mapping_qc(){

 local fastqdir=$1
 local outputDir=$2
 local species=$3
 local projName=$4
 
 local scriptsdir="scripts/01_map_fastQ_bowtie2/${projName}"
 
 # Perform mapping
 bash scripts/01_map_singleendFastQ_bowtie2.sh ${fastqdir} ${outputDir} ${species} ${projName}
 cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}
 
 # Run multiqc
 multiqcDir="${outputDir}/multiqc"; mkdir -p ${multiqcDir}
 multiqc -o ${multiqcDir} -n ${projName} ${outputDir}

}

run_pe_mapping_qc(){

 local fastqdir=$1
 local outputDir=$2
 local species=$3
 local projName=$4
 
 local scriptsdir="scripts/01_map_fastQ_bowtie2/${projName}"
 
 # Perform mapping
 bash scripts/01_map_pairedendFastQ_bowtie2.sh ${fastqdir} ${outputDir} ${species} ${projName}
 cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}
 
 # Run multiqc
 multiqcDir="${outputDir}/multiqc"; mkdir -p ${multiqcDir}
 multiqc -o ${multiqcDir} -n ${projName} ${outputDir}

}
############### For Users ###################
# Get the wrappers and then run them in parallel
# 2) Anja Pfaus
# 2.1) For Tcell and T-ALL cells celline data for humans
# mkdir -p  /media/rad/HDD1/PUB_CRCs/{chip/{mcl,tcellTallcellLine_hg,tcellTallcellLine_mm},atac/atac_tcellTallcellLine_mm}

species="hg19"
projName="tcellTallcellLine_hg"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_hg"
outputDir="output/chip/tcellTallcellLine_hg/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.2) For Tcell and T-ALL cells celline data for mouse
species="mm10"
projName="tcellTallcellLine_mm"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_mm"
outputDir="output/chip/tcellTallcellLine_mm/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.3) For MCL celline data
species="hg19"
projName="mcl"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/mcl"
outputDir="output/chip/mcl/mapping"
run_pe_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

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
 echo "bash scripts/map_singleendFastQ_bowtie2.sh ${fastqdir} ${outputDir} ${species} ${projName}"
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
 bash scripts/map_pairedendFastQ_bowtie2.sh ${fastqdir} ${outputDir} ${species} ${projName}
 cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}
 
 # Run multiqc
 multiqcDir="${outputDir}/multiqc"; mkdir -p ${multiqcDir}
 multiqc -o ${multiqcDir} -n ${projName} ${outputDir}
}

############### For Users ###################
# Get the wrappers and then run them in parallel

# 2) Anja Pfaus

# 2.1) For Tcell and T-ALL cells celline data for humans
species="hg19"
projName="tcellTallcellLine_hg"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/tcellTallcellLine_hg"
outputDir="output/chip/tcellTallcellLine_hg/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.2.1) For Tcell and T-ALL cells celline data for mouse
species="mm10"
projName="tALLcellLine_mm"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/tALLcellLine_mm"
outputDir="output/chip/tALLcellLine_mm/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.2.2) Convert bam to bigwig using deeptools bamCoverage
# https://deeptools.readthedocs.io/en/latest/content/feature/effectiveGenomeSize.html
bigwigdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tALLcellLine_mm/bigwig"; mkdir -p ${bigwigdir}
effectiveGenomeSize=2652783500 # for mm10
for f in /home/rad/users/gaurav/projects/ctrc/output/chip/tALLcellLine_mm/H3K27ac*/mapping/*_rmdup.bam;
do
  echo ${f}; 
  bname=$(basename ${f} .bam); 
  bamCoverage -b ${f} -o ${bigwigdir}/${bname}_SeqDepthNorm.bw --binSize 50 --normalizeUsing RPGC --effectiveGenomeSize ${effectiveGenomeSize} --ignoreForNormalization chrX -p 64
  echo ""; 
done

bigwigdir="/media/rad/HDD1/temp_chip/${projName}/bigwig"; mkdir -p ${bigwigdir}
for f in ${outputDir}/*_rmdup.bam; 
do
done

# 2.3) For MCL celline data
species="hg19"
projName="mcl"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/mcl"
outputDir="output/chip/mcl/mapping"
run_pe_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.4) AML
cd /media/nas/raw/PUB_CRCs; ls download_8_AML | parallel --progress --eta -j 32 'rsync -arvRP download_8_AML/{} /media/rad/HDD1/PUB_CRCs/chip'; cd -
species="hg19"
projName="AML"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/AML"
outputDir="/media/rad/HDD1/ctrcs/output/AML/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

# 2.5) diaferia
cd /media/nas/raw/PUB_CRCs; ls download_7_diaferia | parallel --progress --eta -j 32 'rsync -arvRP download_7_diaferia/{} /media/rad/HDD1/PUB_CRCs/chip'; cd -
species="hg19"
projName="diaferia"
fastqdir="/media/rad/HDD1/PUB_CRCs/chip/diaferia"
outputDir="/media/rad/HDD1/ctrcs/output/diaferia/mapping"
run_se_mapping_qc ${fastqdir} ${outputDir} ${species} ${projName}

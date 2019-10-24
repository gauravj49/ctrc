# pwd
cd /home/rad/users/gaurav/projects/ctrc

################################################## MACS2 ###########################################################

# 2.0) Remove duplicates from the Tcell and T-ALL cells celline data for humans
oldbamdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tcellTallcellLine_hg"
# allBams=$(find ${oldbamdir} -name *.bam)
# parallel 'bamfile={}; \
# rmdupbam=$(dirname ${bamfile})/$(basename ${bamdile} .bam)_rmdup.bam
# samtools rmdup  -s ${bamfile} ${rmdupbam}' ::: ${allBams}
ls ${oldbamdir}/*.bam | parallel --progress --eta -j 16 'samtools rmdup {} {.}_rmdup.bam'
ls ${oldbamdir}/*rmdup.bam | parallel --progress --eta -j 16 'samtools index -@ 32 {}'

# 2.1) For Tcell and T-ALL cells celline data for humans
species="hg19"
projName="tcellTallcellLine_hg"
oldbamdir="output/chip/tcellTallcellLine_hg/mapping"
oldpeaksdir="output/chip/tcellTallcellLine_hg/peaks"
outdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tcellTallcellLine_hg"
scriptsdir="scripts/02_peakcalling/${projName}"

# # Get the separate sample dir if the bam files are in one mapping dir
# create_sample_dirs ${oldbamdir} ${oldpeaksdir}
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${outdir} ${projName}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.2) For Tcell and T-ALL cells celline data for mouse
species="mm10"
projName="tcellTallcellLine_mm"
bamdir="output/chip/tcellTallcellLine_mm/mapping"
peaksdir="output/chip/tcellTallcellLine_mm/peaks"
scriptsdir="scripts/02_peakcalling/${projName}"
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${bamdir} ${peaksdir} ${projName}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.3) For MCL celline data
species="hg19"
projName="mcl"
bamdir="output/chip/mcl/mapping"
peaksdir="output/chip/mcl/peaks"
scriptsdir="scripts/02_peakcalling/${projName}"
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${bamdir} ${peaksdir} ${projName}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.4) AML
species="hg19"
projName="AML"
oldmappingDir="/media/rad/HDD1/ctrcs/output/AML/mapping"
projdir="/media/rad/HDD1/ctrcs/output/AML"
scriptsdir="scripts/02_peakcalling/${projName}"
# Get the separate sample dir if the bam files are in one mapping dir
bash scripts/create_sample_dirs.sh ${oldmappingDir}
# rm -rf ${projdir}/mapping
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${projdir} ${projName}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.5) Diaferia
species="hg19"
projName="diaferia"
oldmappingDir="/media/rad/HDD1/ctrcs/output/diaferia/mapping"
projdir="/media/rad/HDD1/ctrcs/output/diaferia"
scriptsdir="scripts/02_peakcalling/${projName}"
# Get the separate sample dir if the bam files are in one mapping dir
bash scripts/create_sample_dirs.sh ${oldmappingDir}
# rm -rf ${projdir}/mapping
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${projdir} ${projName}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}


################################################## CRCS ###########################################################
# 2.1) For Tcell and T-ALL cells celline data for humans
species="hg19"
projName="tcellTallcellLine_hg"
outdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tcellTallcellLine_hg"
scriptsdir="scripts/03_crcs/${projName}"

# # Create folders for each file and move them to the relevant folders
# create_sample_dirs ${bamdir} ${peaksdir} ${outdir}

# Get CRCs
bash scripts/get_crcs.sh ${outdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.2) For Tcell and T-ALL cells celline data for mouse
species="mm10"
projName="tcellTallcellLine_mm"
outdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tcellTallcellLine_mm"
bamdir="output/chip/tcellTallcellLine_mm/mapping"
peaksdir="output/chip/tcellTallcellLine_mm/peaks"
scriptsdir="scripts/03_crcs/${projName}"

# Create folders for each file and move them to the relevant folders
create_sample_dirs ${bamdir} ${peaksdir} ${outdir}

# Get CRCs
bash scripts/get_crcs.sh ${outdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.3) For MCL celline data
species="hg19"
projName="mcl"
outdir="/home/rad/users/gaurav/projects/ctrc/output/chip/mcl"
bamdir="output/chip/mcl/mapping"
peaksdir="output/chip/mcl/peaks"
scriptsdir="scripts/03_crcs/${projName}"

# Create folders for each file and move them to the relevant folders
create_sample_dirs ${bamdir} ${peaksdir} ${outdir}

# Get CRCs
bash scripts/get_crcs.sh ${outdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# rsync --exclude *.bam --exclude *.bai --exclude *.sam -arvPR output/chip/tcellTallcellLine_hg output/chip/tcellTallcellLine_hg_CRCs_Anja_macs_10e5

# 2.4) AML
species="hg19"
projName="AML"
projdir="/media/rad/HDD1/ctrcs/output/${projName}"
scriptsdir="scripts/03_crcs/${projName}"
# Get CRCs
bash scripts/get_crcs.sh ${projdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.5) Diaferia
species="hg19"
projName="diaferia"
projdir="/media/rad/HDD1/ctrcs/output/${projName}"
scriptsdir="scripts/03_crcs/${projName}"
# Get CRCs
bash scripts/get_crcs.sh ${projdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

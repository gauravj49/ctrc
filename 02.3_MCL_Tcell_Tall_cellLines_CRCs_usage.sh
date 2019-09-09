# pwd
cd /home/rad/users/gaurav/projects/ctrc

################# Wrapper Main Function #############
create_sample_dirs(){
 local bamdir=$1
 local peaksdir=$2

 # Create folders for each file and relevant folders
 for b in ${bamdir}/*.bam;
 do
  # Get the basename
  bname=$(basename ${b} .bam)

  # Get the output dir
  outdir=$(dirname ${bamdir})

  # Create relevant folders
  sampleDir="${outdir}/${bname}"; mkdir -p ${sampleDir}

  # Move the relevant files from previous analysis
  mv ${bamdir}/${bname}* ${peaksdir}/${bname}* ${sampleDir}

  # Move the respecitive logs dir to project log dir
  logsDir="$(dirname ${bamdir})/logs"; mkdir -p ${logsDir}
  mv ${bamdir}/mappingLogs ${peaksdir}/peakcallingLogs ${logsDir}
 done
}

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

################################################## CRCS ###########################################################
# 2.1) For Tcell and T-ALL cells celline data for humans
species="hg19"
projName="tcellTallcellLine_hg"
outdir="/home/rad/users/gaurav/projects/ctrc/output/chip/tcellTallcellLine_hg"
bamdir="output/chip/tcellTallcellLine_hg/mapping"
peaksdir="output/chip/tcellTallcellLine_hg/peaks"
scriptsdir="scripts/03_crcs/${projName}"

# Create folders for each file and move them to the relevant folders
create_sample_dirs ${bamdir} ${peaksdir} ${outdir}

# Get CRCs
bash scripts/get_crcs.sh ${outdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/H3K27ac_DND41*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

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

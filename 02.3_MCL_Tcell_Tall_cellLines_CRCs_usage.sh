# pwd
cd /home/rad/users/gaurav/projects/ctrc

# 2.1) For Tcell and T-ALL cells celline data for humans
species="hg19"
projName="tcellTallcellLine_hg"
bamdir="output/chip/tcellTallcellLine_hg/mapping"
peaksdir="output/chip/tcellTallcellLine_hg/peaks"
scriptsdir="scripts/02_peakcalling/${projName}"
# Perform parallel peakcalling
bash scripts/run_macs2_peakcalling.sh ${bamdir} ${peaksdir} ${projName}
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
bamdir="output/chip/tcellTallcellLine_hg/mapping"
peaksdir="output/chip/tcellTallcellLine_hg/peaks"
crcdir="output/chip/mcl/crc"
scriptsdir="scripts/03_crcs/${projName}"
# Get CRCs
bash scripts/get_crcs.sh ${bamdir} ${peaksdir} ${crcdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}

# 2.3) For MCL celline data
species="hg19"
projName="mcl"
bamdir="output/chip/mcl/mapping"
peaksdir="output/chip/mcl/peaks"
crcdir="output/chip/mcl/crc"
scriptsdir="scripts/03_crcs/${projName}"
# Get CRCs
bash scripts/get_crcs.sh ${bamdir} ${peaksdir} ${crcdir} ${projName} ${species}
cmd="parallel ::: "; for s in ${scriptsdir}/*.sh; do chmod 775 ${s}; cmd=$(echo "${cmd} ${s}"); done; eval ${cmd}



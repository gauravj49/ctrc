#!/bin/bash

# USAGE: bash scripts/create_nf_sample_dirs.sh pdacBatch1 /media/rad/HDD1/nfchip/christine/pdacBatch1/analysis/crcs /media/rad/HDD1/nfchip/christine/pdacBatch1/results/bwa/mergedLibrary /media/rad/HDD1/nfchip/christine/pdacBatch1/results/bwa/mergedLibrary/macs/narrowPeak
# jobdir="/home/rad/users/gaurav/projects/ctrc"

projName=${1:-"pdacBatch1"}
outdir=${2:-"/media/rad/HDD1/nfchip/christine/pdacBatch1/analysis/crcs"}
bamdir=${3:-"/media/rad/HDD1/nfchip/christine/pdacBatch1/results/bwa/mergedLibrary"}
peaksdir=${4:-"/media/rad/HDD1/nfchip/christine/pdacBatch1/results/bwa/mergedLibrary/macs/narrowPeak"}

# Get relevant directories
projDir="${outdir}/${user}/${projName}"

# Input argument and relevant directories
echo "######################################################################"
echo "# Input argument and relevant directories "
echo ""
echo "projName=${projName}"
echo "outdir=${outdir}"
echo "bamdir=${bamdir}"
echo "projDir=${projDir}"
echo ""
echo "######################################################################"
echo ""

# Create folders for each file and relevant folders
for b in ${bamdir}/*.bam;
do
  # Get the basename
  bname=$(basename ${b} .mLb.clN.sorted.bam)
  # Create relevant folders
  sampleDir="${outdir}/${bname}"; mkdir -p ${sampleDir}
  # Link the bam and peaks file from the mapping and peaks dir
  ln -s ${b} ${sampleDir}
  ln -s ${b}.bai ${sampleDir}
  ln -s ${peaksdir}/${bname}_summits.bed ${sampleDir}
  # Print status
  echo "- Creating links for:"
  echo -e "\t- ${sampleDir}/bname.mLb.clN.sorted.bam"
  echo -e "\t- ${sampleDir}/bname.mLb.clN.sorted.bam.bai"
  echo -e "\t- ${sampleDir}/bname_summits.bed"
  echo ""
done



#!/bin/sh
set -ue

# Get the bam file from the command line
DATA=$1

# Create a pattern to rename created files
pat=$(echo $DATA | sed 's/.bam//')
echo $pat
# Forward strand.
#
echo " alignments of the second in pair if they map to the forward strand "
#####
samtools view -b -f 128 -F 16 $DATA > fwd1_${pat}.bam
samtools index fwd1_${pat}.bam
#####
echo "done"
echo "###"

echo " alignments of the first in pair if they map to the reverse  strand"
#####
samtools view -b -f 80 $DATA > fwd2_${pat}.bam
samtools index fwd2_${pat}.bam
echo "done"
echo "###"
#
echo "Combine alignments that originate on the forward strand."
#
samtools merge -f ${pat}_fwd.bam fwd1_${pat}.bam fwd2_${pat}.bam
samtools index ${pat}_fwd.bam
echo "done"
echo "###"

# Supress intermediate
rm fwd1_${pat}.ba* fwd2_${pat}.ba*

# Reverse strand
#
echo "alignments of the second in pair if they map to the reverse strand"
#
samtools view -b -f 144 $DATA > rev1_${pat}.bam
samtools index rev1_${pat}.bam
echo "done"
echo "###"

echo " alignments of the first in pair if they map to the forward strand"

samtools view -b -f 64 -F 16 $DATA > rev2_${pat}.bam
samtools index rev2_${pat}.bam
echo "done"
echo "###"
#
echo "Combine alignments that originate on the reverse strand."
echo "###"
#

samtools merge -f ${pat}_rev.bam rev1_${pat}.bam rev2_${pat}.bam
samtools index ${pat}_rev.bam
echo "DONE"

# supress intermediate reverse
rm rev1_${pat}.ba* rev2_${pat}.ba*

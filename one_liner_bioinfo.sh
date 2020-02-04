# Get the average coverage of a bam file. 
samtools depth -a snps.bam  | awk '{sum+=$3} END { print "Average = ",sum/NR}' 
# Same as above but only for one contig
samtools depth -a snps.bam  | grep contig_name | awk '{sum+=$3} END { print "Average = ",sum/NR}' 


# Credit for those who made these one-liners.
russdurrett @biostars

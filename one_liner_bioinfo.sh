# Get the average coverage of a bam file. 
samtools depth  snps.bam  | awk '{sum+=$3} END { print "Average = ",sum/NR}' 
# Same as above but only for one contig
samtools depth  snps.bam  | grep contig_name | awk '{sum+=$3} END { print "Average = ",sum/NR}' 

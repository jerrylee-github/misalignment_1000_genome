

while IFS= read -r line
do
  echo $line
  sampleid=`basename $line | cut -d '.' -f 1`
  newFile="${sampleid}_new_bamfile.bam"
  coverageFile="${sampleid}_cov_count.txt"
  samtools view -h -b -L Pseudogene_target_sorted.bed $line > $newFile
  samtools index $newFile
  bedtools2.24/bin/bedtools coverage -counts -sorted -g hg19_genome_index.txt -a Pseudogene_target_sorted.bed -b $newFile > $coverageFile
done < 1000Genome_bam_files.txt

configfile: "config/config.yaml"

rule MappingtheReads:
  input:
    read1 = config['fastq_file'],
    read2 = config['fastq_file2'],
    index_complete=config['StargenomeDir'] + '.index_complete',
    indexedGenome = config['StargenomeDir']
  output:
    alignedTranscriptome = config['output_dir'] + "mappingthereads/Aligned.toTranscriptome.out.bam",
    alignedbyCoordGenome = config['output_dir'] + "mappingthereads/Aligned.sortedByCoord.out.bam"
  message:
    "Mapping the reads... expected 2 output files to " +  f"{config['output_dir']}mappingthereads/"
  log:
    "logs/MappingtheReads.log"
  conda:
    "envs/getTools.yaml"
  threads: 30
  shell:
     "STAR --genomeDir {input.indexedGenome} --readFilesIn {input.read1} {input.read2} --readFilesCommand zcat --outFilterType BySJout --outSAMtype BAM SortedByCoordinate --outSAMattrIHstart 0 --outFilterIntronMotifs RemoveNoncanonical --quantMode TranscriptomeSAM --outWigType bedGraph --outWigStrand Stranded --outFileNamePrefix " + f"{config['output_dir']}mappingthereads/ " + "2> {log}" 

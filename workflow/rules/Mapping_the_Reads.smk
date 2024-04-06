configfile: "config/config.yaml"
mapDir=config['output_dir'] + "mappingthereads/"

rule MappingtheReads:
  input:
    read1=config['fastq_file'],
    read2=config['fastq_file2'],
    index_complete=config['output_dir'] + '.index_complete'
  output:
    alignedTranscriptome=mapDir + "Aligned.toTranscriptome.out.bam",
    alignedbyCoordGenome=mapDir + "Aligned.sortedByCoord.out.bam"
  message:
    "Mapping the reads... expected 2 output files to " + mapDir
  log:
    "logs/MappingtheReads.log"
  benchmark:
    "benchmarks/MappingtheReads.benchmark.txt"
  conda:
    "envs/getTools.yaml"
  threads: config['threads']
  params:
    mapDir=config['output_dir'] + "mappingthereads/",
    indexedGenome=config['StargenomeDir']
  shell:
     """
     mkdir -p {mapDir}
     STAR --genomeDir {params.indexedGenome} --readFilesIn {input.read1} {input.read2} --readFilesCommand zcat --outFilterType BySJout --outSAMtype BAM SortedByCoordinate --outSAMattrIHstart 0 --outFilterIntronMotifs RemoveNoncanonical --quantMode TranscriptomeSAM --outWigType bedGraph --outWigStrand Stranded --outFileNamePrefix {params.mapDir} 1> {log} 2> {log}
     """
